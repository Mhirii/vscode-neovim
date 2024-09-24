#!/usr/bin/env bash
#	=============== info ===============
#		Manages my vscode config
#		Use at your own risk.
#
#		This script is meant to be downloaded using curl or wget and piped to bash.
#

#	=============== vars ===============
repo="https://github.com/mhirii/vscode-neovim"
spinner=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
default_vscode_config="$HOME/.config/Code/User"
SPIN_PID=""
#	=============== mutable ===============
nvim_path=""
repo_path=""
clone_path="$HOME/.config/vscode-nvim"
#	=============== lib ===============
echo_error() {
	echo -e "\n\e[31m$1\e[0m"
}
echo_warning() {
	echo -e "\n\e[33m$1\e[0m"
}
echo_success() {
	echo -e "\n\e[32m$1\e[0m"
}
echo_info() {
	echo -e "\n\e[34m$1\e[0m"
}

spin() {
	local i=0
	while true; do
		i=$(((i + 1) % 10))
		printf "\r${spinner[$i]}"
		sleep .1
	done
}

kill_spinner() {
	if [ -n "$SPIN_PID" ]; then
		kill "$SPIN_PID"
		SPIN_PID=""
	fi
}

safe_exit() {
	kill_spinner
	if [ -z "$1" ]; then
		exit
	else
		exit "$1"
	fi
}

function run_with_spinner() {
	local function_to_run=$1
	spin &
	SPIN_PID=$!
	$function_to_run
	kill_spinner
}

safe_target() {
	if [ -f "$1" ]; then
		echo_warning "File already exists at $1, moving to $1.bak"
		mv "$1" "$1.bak"
	fi
	if [ -d "$1" ]; then
		echo_warning "Directory already exists at $1, moving to $1.bak"
		mv "$1" "$1.bak"
	fi
	if [ -L "$1" ]; then
		echo_warning "Symlink already exists at $1, removing"
		rm "$1"
	fi
}

clone_repo() {
	target=$1
	echo_info "Cloning repository to $1"
	safe_target "$target"
	git clone "$repo" "$target" || {
		echo_error "Failed to clone repository"
		safe_exit 1
	}
	repo_path=$target
}

check_repo() {
	target=$1
	if [ ! -d "$target" ]; then
		echo_warning "Repository not found"
		clone_repo "$target" || {
			echo_error "Failed to clone repository"
			safe_exit 1
		}
	else
		current_dir=$(pwd)
		cd "$target" || {
			echo_error "Failed to cd into repository"
			safe_exit 1
		}
		git pull || {
			echo_error "Failed to pull repository"
			safe_exit 1
		}
		git fetch --all || {
			echo_error "Failed to fetch repository"
			safe_exit 1
		}
		cd "$current_dir" || {
			echo_error "Failed to cd into repository"
			safe_exit 1
		}
		return 0
	fi
}

locate_neovim() {
	p=$(which nvim)
	if [ -z "$p" ]; then
		echo_error "Neovim not found"
		safe_exit 1
	fi
	nvim_path=$p
}

check_cmd() {
	if ! command -v "$1" &>/dev/null; then
		echo_error "$1 not found"
		safe_exit 1
	fi
}
check_cmd_opt() {
	if ! command -v "$1" &>/dev/null; then
		echo_warning "$1 not found"
		return 1
	fi
}

locate_vscode_config() {
	if [ ! -d "$HOME/.config/Code/User" ]; then
		echo_error "VSCode config not found"
		safe_exit 1
	fi
}

check_deps() {
	check_cmd "code"
	check_cmd "git"
	check_cmd "nvim"
	check_cmd_opt "fzf"
	check_cmd_opt "rg"
}

install_ext() {
	"$clone_path"/manage_extensions.sh i
}

init() {
	echo_info "Checking dependencies"
	run_with_spinner check_deps
	echo_info "Dependencies found"

	echo_info "Locating VSCode config"
	run_with_spinner locate_vscode_config
	echo_success "VSCode config found"

	echo_info "Locating neovim"
	run_with_spinner locate_neovim
	echo_success "Neovim found at $nvim_path"

	echo_info "Cloning repository"
	check_repo "$clone_path"
	echo_success "Repository cloned successfully at $clone_path"
}

get_user_input() {
	echo_warning "$1"
	read -p "y/n: " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		return 0
	else
		return 1
	fi
}

create_symlink() {
	filename=$1
	ln -sf "$clone_path/$filename" "$default_vscode_config/$filename" || {
		echo_error "Failed to create symbolic link for $filename"
		safe_exit 1
	}
}

create_symlink_with_backup() {
	filename=$1
	if [ -f "$default_vscode_config/$filename" ]; then
		mv "$default_vscode_config/$filename" "$default_vscode_config/$filename.bak"
	fi
	create_symlink "$filename"
}

ask_extensions() {
	echo_info "Do you want to install extensions from the repository?"
	read -p "y/n: " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		install_extensions
	fi
}

ask_config() {
	if get_user_input "Do you want to save the current config?"; then
		create_symlink_with_backup "settings.json"
	fi
}

ask_keybinds() {
	if get_user_input "Do you want to save the current keybindings?"; then
		create_symlink_with_backup "keybindings.json"
	fi
}

apply_nvim_vscode() {
	local repo_name="vscode-nvim"
	local nvim_path="/run/current-system/sw/bin/nvim"
	local nvim_exec_setting="vscode-neovim.neovimExecutablePaths.linux"
	local nvim_appname_setting="vscode-neovim.NVIM_APPNAME"
	local settings_file="$default_vscode_config/settings.json"

	if [ ! -f "$settings_file" ]; then
		echo "{}" >"$settings_file"
	fi

	sed -i "s|\"$nvim_exec_setting\": \".*\"|\"$nvim_exec_setting\": \"$nvim_path\"|" "$settings_file"
	sed -i "s|\"$nvim_appname_setting\": \".*\"|\"$nvim_appname_setting\": \"$repo_name\"|" "$settings_file"
}

ask_apply_nvim_vscode() {
	if get_user_input "Do you want to apply neovim settings to vscode?"; then
		apply_nvim_vscode
	fi
}

echo_help() {
	echo -e " 
	This is a script to easily apply my vscode settings\n\ "
	echo -e "Usage:\n\ "
	echo -e "./install.s"
	echo_success "\e[32m[option]\e[0m\n\ "

}

#	================ main ================
cd "$(dirname "$0")" || {
	safe_exit
}

cd "$clone_path" || {
	echo_error "Failed to cd into repository"
	safe_exit 1
}

if [ "$#" -eq 0 ]; then
	echo_help
	safe_exit 0
fi

_all=false
_ext=false
_conf=false
_kb=false
_nv=false

while (("$#")); do
	case "$1" in
	a | all)
		echo_info "Applying all settings"
		_all=true
		shift
		;;
	h | help)
		echo_help
		safe_exit 0
		;;
	e | x | extensions)
		echo_info "Applying extensions"
		_ext=true
		shift
		;;
	c | config)
		echo_info "Applying config"
		_conf=true
		shift
		;;
	k | keybinds)
		echo_info "Applying keybinds"
		_kb=true
		shift
		;;
	n | v | nvim)
		echo_info "Applying neovim settings"
		_nv=true
		shift
		;;
	*)
		echo_error "Unknown option: $1"
		echo_help
		safe_exit 1
		;;
	esac
done
init

if $_all; then
	_ext=true
	_conf=true
	_kb=true
	_nv=true
fi

if $_ext; then
	install_ext
fi

if $_conf; then
	ask_config
fi

if $_kb; then
	ask_keybinds
fi

if $_nv; then
	ask_apply_nvim_vscode
fi

safe_exit 0
