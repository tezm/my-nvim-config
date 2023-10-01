-- Add any options here
-- List of options: https://neovim.io/doc/user/quickref.html#Q_op
-- or :help options
---------------------------------------------------------------------------------------------------------------------------------------------------------------
local opt = vim.opt                         -- vim option alias

opt.backup = false                          -- keep backup file after overwriting a file
opt.clipboard = "unnamedplus"               -- use the clipboard as the unnamed register
opt.cmdheight = 1                           -- number of lines to use for the command-line
opt.completeopt = { "menuone", "noselect" } -- A comma-separated list of options for Insert mode completion
opt.conceallevel = 0                        -- whether concealable text is shown or hidden
opt.cursorline = true                       -- highlight the screen line of the cursor
opt.expandtab = true                        -- use spaces when <Tab> is inserted
opt.fileencoding = "utf-8"                  -- the encoding written to a file
opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
opt.hlsearch = true                         -- highlight all matches on previous search pattern
opt.ignorecase = true                       -- ignore case in search patterns
opt.iskeyword:append "-"
opt.mouse = "a"                             -- enable the use of mouse clicks
opt.number = true                           -- print the line number in front of each line
opt.numberwidth = 4                         -- number of columns used for the line number
opt.pumheight = 10                          -- maximum number of items to show in the popup menu
opt.relativenumber = true                   -- show relative line number in front of each line
opt.scrolloff = 8                           -- minimum nr. of lines above and below cursor
opt.shiftwidth = 2                          -- number of spaces to use for (auto)indent step
opt.shortmess:append "c"                    -- list of flags, reduce length of messages
opt.showmode = true                         -- message on status line to show current mode
opt.showtabline = 2                         -- tells when the tab pages line is displayed
opt.sidescrolloff = 8                       -- min. nr. of columns to left and right of cursor
opt.signcolumn = "yes"                      -- when and how to display the sign column
opt.smartcase = true                        -- no ignore case when pattern has uppercase
opt.smartindent = true                      -- smart autoindenting for C programs
opt.splitbelow = true                       -- new window from split is below the current one
opt.splitright = true                       -- new window is put right of the current one
opt.swapfile = false                        -- whether to use a swapfile for a buffer
opt.tabstop = 2                             -- number of spaces that <Tab> in file uses
opt.termguicolors = true                    -- set term gui colors (most terminals support this)
opt.timeoutlen = 1000                       -- time out time in milliseconds
opt.undofile = true                         -- save undo information in a file
opt.updatetime = 300                        -- faster completion (4000ms default)
opt.whichwrap:append "<,>,[,],h,l"
opt.wrap = false                            -- long lines wrap and continue on the next line
opt.writebackup = false                     -- make a backup before overwriting a file

vim.wo.fillchars = "eob: "                  -- empty lines below the end of a buffer
vim.g.python3_host_prog = "/usr/bin/python3"
--vim.g.clipboard = {
--  name = "WslClipboard",
--  copy = {
--    ["+"] = "clip.exe",
--    ["*"] = "clip.exe",
--  },
--  paste = {
--    ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r",""))',
--    ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r",""))',
--  },
--  cache_enabled = true,
--}
