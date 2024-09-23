#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

#	================ lib ================
echo_help() {
	echo -e "
	Usage:\n\
	./manage_extensions.sh \e[32m[option]\e[0m\n\

	Please use one of the following options:\n\
	- '\e[32msave\e[0m' or '\e[32ms\e[0m' to save the current extensions to a file\n\
	- '\e[32minstall\e[0m' or '\e[32mi\e[0m' to install extensions from the file


"
}

spinner=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')

spin() {
	local i=0
	while true; do
		i=$(((i + 1) % 10))
		printf "\r${spinner[$i]}"
		sleep .1
	done
}

save_extensions() {
	code --list-extensions | xargs -L 1 echo code --install-extension >extensions
}

install_extensions() {
	while IFS= read -r line; do
		spin &
		SPIN_PID=$!
		code --install-extension "$line" >/dev/null 2>&1 &
		kill $SPIN_PID
	done <extensions
}

#	================ main ================
case $1 in
save | s)
	save_extensions
	;;
install | i)
	install_extensions
	;;
help | h)
	echo_help
	;;
*)
	echo -e "\n\	\e[31mInvalid argument ' $1 '\e[0m"
	echo_help
	;;
esac
