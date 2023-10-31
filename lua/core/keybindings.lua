local bind = vim.keymap.set


if vim.g.vscode then
  vim.g.mapleader = '<Tab>'
else
  vim.g.mapleader = ' '
end

vim.opt.langmap = 'ΑA,ΒB,ΨC,ΔD,ΕE,ΦF,ΓG,ΗH,ΙI,ΞJ,ΚK,ΛL,ΜM,ΝN,ΟO,ΠP,QQ,ΡR,ΣS,ΤT,'
  .. 'ΘU,ΩV,WW,ΧX,ΥY,ΖZ,αa,βb,ψc,δd,εe,φf,γg,ηh,ιi,ξj,κk,λl,μm,νn,οo,πp,qq,ρr,'
  .. 'σs,τt,θu,ωv,ςw,χx,υy,ζz'

-- Unbind 'K'
bind('n', 'K', '<NOP>')

-- Stay in indent mode after indenting text
bind('v', '<', '<gv')
bind('v', '>', '>gv')

-- Move text up and down
bind('x', 'J', ":move '>+1<CR>gv")
bind('x', 'K', ":move '<-2<CR>gv")

-- Clear highlights and prints
bind('n', '<LEADER>n', '<CMD>noh<CR><cmd>echo ""<CR>')

-- Copy path to clipboard
bind('n', '<LEADER>yf', '<CMD>lua vim.fn.setreg("+", vim.fn.expand("%:."))<CR>')
bind('n', '<LEADER>yl', '<CMD>lua vim.fn.setreg("+", vim.fn.expand("%:.") .. ":" .. vim.fn.line("."))<CR>')

