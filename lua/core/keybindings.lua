local bind = vim.keymap.set

if vim.g.vscode then
  vim.g.mapleader = "<Tab>"
else
  vim.g.mapleader = " "
end

-- Unbind 'K'
bind("n", "K", "<NOP>")

-- Stay in indent mode after indenting text
bind("v", "<", "<gv")
bind("v", ">", ">gv")

-- Clear highlights and prints
bind("n", "<LEADER>n", '<CMD>noh<CR><cmd>echo ""<CR>')

-- Copy path to clipboard
bind("n", "<LEADER>yf", '<CMD>lua vim.fn.setreg("+", vim.fn.expand("%:."))<CR>')
bind("n", "<LEADER>yl", '<CMD>lua vim.fn.setreg("+", vim.fn.expand("%:.") .. ":" .. vim.fn.line("."))<CR>')

-- vim.g.mapleader = '<S><Space>'

-- bind('n', '<LEADER><Tab>', '<CMD>call VSCodeNotify("whichkey.show")<CR>')
bind("n", "<Space>", '<CMD>call VSCodeNotify("whichkey.show")<CR>')
bind("x", "<Space>", '<CMD>call VSCodeNotify("whichkey.show")<CR>')

-- Search
-- bind('n', '<LEADER>ff', '<CMD>call VSCodeNotify("workbench.action.quickOpen")<CR>')
-- bind('n', '<LEADER>fw', '<CMD>call VSCodeNotify("workbench.action.findInFiles")<CR>')

-- Navigation
bind("n", "<C-j>", '<CMD>call VSCodeNotify("workbench.action.navigateDown")<CR>')
bind("x", "<C-j>", '<CMD>call VSCodeNotify("workbench.action.navigateDown")<CR>')
bind("n", "<C-k>", '<CMD>call VSCodeNotify("workbench.action.navigateUp")<CR>')
bind("x", "<C-k>", '<CMD>call VSCodeNotify("workbench.action.navigateUp")<CR>')
bind("n", "<C-h>", '<CMD>call VSCodeNotify("workbench.action.navigateLeft")<CR>')
bind("x", "<C-h>", '<CMD>call VSCodeNotify("workbench.action.navigateLeft")<CR>')
bind("n", "<C-l>", '<CMD>call VSCodeNotify("workbench.action.navigateRight")<CR>')
bind("x", "<C-l>", '<CMD>call VSCodeNotify("workbench.action.navigateRight")<CR>')

-- Active editor
-- bind("n", "<S-w>", '<CMD>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>')
-- bind('n', '<Tab>', '<CMD>call VSCodeNotify("workbench.action.nextEditor")<CR>')
-- bind('n', '<S-Tab>', '<CMD>call VSCodeNotify("workbench.action.previousEditor")<CR>')
-- bind("n", "<S-h>", '<CMD>call VSCodeNotify("workbench.action.moveEditorLeftInGroup")<CR>')
-- bind("n", "<S-l>", '<CMD>call VSCodeNotify("workbench.action.moveEditorRightInGroup")<CR>')
bind("n", "<S-h>", '<CMD>call VSCodeNotify("workbench.action.previousEditorInGroup")<CR>')
bind("n", "<S-l>", '<CMD>call VSCodeNotify("workbench.action.nextEditorInGroup")<CR>')

-- Toggles
-- bind('n', '<LEADER>e', '<CMD>call VSCodeNotify("workbench.action.toggleSidebarVisibility")<CR>')

-- Hover
bind("n", "K", '<CMD>call VSCodeNotify("editor.action.showHover")<CR>')
-- bind('n', '<LEADER>k', '<CMD>call VSCodeNotify("editor.action.showHover")<CR>')

-- VSCode definitions/references
bind("n", "gd", '<CMD>call VSCodeNotify("editor.action.revealDefinition")<CR>')
bind("n", "gr", '<CMD>call VSCodeNotify("editor.action.goToReferences")<CR>')

bind("n", "]d", '<CMD>call VSCodeNotify("editor.action.marker.next")<CR>')
bind("n", "[d", '<CMD>call VSCodeNotify("editor.action.marker.prev")<CR>')

bind("n", "]b", '<CMD>call VSCodeNotify("workbench.action.nextEditor")<CR>')
bind("n", "[b", '<CMD>call VSCodeNotify("workbench.action.previousEditor")<CR>')

bind("n", "zi", '<CMD>call VSCodeNotify("editor.toggleFold")<CR>')

bind("n", "<C-g>", "<CMD> HopWord <CR>")
bind("n", "<leader>h", "<CMD> HopWord <CR>")

bind("n", "m", '<CMD>call VSCodeNotify("bookmarks.toggleLabeled")<CR>')
bind("n", "'", '<CMD>call VSCodeNotify("bookmarks.listFromAllFiles")<CR>')

bind("n", "]t", '<CMD>call VSCodeNotify("todo-tree.goToNext")<CR>')
bind("n", "[t", '<CMD>call VSCodeNotify("todo-tree.goToPrevious")<CR>')
