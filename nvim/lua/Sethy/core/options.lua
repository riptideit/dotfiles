vim.cmd("let g:netrw_banner = 0")

-- line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- cursor line 
vim.opt.cursorline = false

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- cursor block 
vim.o.guicursor = 'n-v-c-sm-i-ci-ve:block'

-- UI
vim.opt.background = "dark"
vim.opt.scrolloff = 8
--vim.opt.signcolumn = "yes"

-- backup and undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true


-- misc
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.clipboard:append("unnamedplus")
vim.opt.mouse = "a"
vim.opt.hlsearch = true
vim.editorconfig = true

-- window splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- folding (for nvim-ufo)
vim.o.foldenable = true
vim.o.foldmethod = "manual"
vim.o.foldlevel = 99

-- idk options
vim.opt.sessionoptions = {
  "buffers",
  "curdir",
  "tabpages",
  "winsize",
  "help",
  "globals",
  "skiprtp",
  "folds",
  "localoptions"
}

-- luarock 
vim.g.python3_host_prog = os.getenv("HOME") .. "/.venvs/nvim/bin/python"

