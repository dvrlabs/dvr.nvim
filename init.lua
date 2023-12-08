--[[

=====================================================================
==================== DVR ============================================
=====================================================================

--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- Import all my plugins!
require('lazy').setup({ { import = 'plugins' } })

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- relativenumbers
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Hidden by default.
vim.o.showtabline = 0

-- Use with term to be able to exit 'insert' mode via ESC
vim.cmd([[:tnoremap <Esc> <C-\><C-n>]])

-- Split below by default, rather than on top.
vim.cmd([[:set sb]])

-- [[ Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`

WK = require("which-key")
--
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
WK.register({ ld = { name = "Diagnostics", } }, { prefix = "<leader>" })

-- Define the function for going to the next diagnostic
local function goto_next_diagnostic()
  vim.diagnostic.goto_next()
  _G.last_action = goto_next_diagnostic
end

-- Define the function for going to the previous diagnostic
local function goto_prev_diagnostic()
  vim.diagnostic.goto_prev()
  _G.last_action = goto_prev_diagnostic
end

-- Set your mappings using these functions
vim.keymap.set('n', '<leader>ldn', goto_next_diagnostic,
  { desc = "Go to next diagnostic message", noremap = true, silent = true })
vim.keymap.set('n', '<leader>ldp', goto_prev_diagnostic,
  { desc = "Go to previous diagnostic message", noremap = true, silent = true })

vim.keymap.set('n', ',', function() if _G.last_action then _G.last_action() end end,
  { desc = "Repeat last action", noremap = true, silent = true })



vim.keymap.set('n', '<leader>ldf', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>ldl', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Ui 'Toggle' keymaps
WK.register({ u = { name = "UI", } }, { prefix = "<leader>" })
vim.keymap.set('n', '<leader>ub', ':exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>',
  { noremap = true, silent = true, desc = "Background" })

vim.keymap.set('n', '<leader>ut', ':exec &showtabline==2? "set showtabline=0" : "set showtabline=2"<CR>',
  { noremap = true, silent = true, desc = "Tabline" })

vim.keymap.set('n', '<leader>uc', ':exec &conceallevel==3? "set conceallevel=0" : "set conceallevel=3"<CR>',
  { noremap = true, silent = true, desc = "Conceal" })

-- These now will navigate to bottom/top of buffer.
vim.keymap.set('n', 'J', 'L', { noremap = true, silent = true })
vim.keymap.set('n', 'K', 'H', { noremap = true, silent = true })

-- These are used to switch previous, next buffer.
vim.keymap.set('n', 'H', ':BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'L', ':BufferNext<CR>', { noremap = true, silent = true })

-- Simplify Left, right, down, up, window navigation.
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })

-- Simplify resizing windows
vim.keymap.set('n', '<Up>', '<C-w>+', { noremap = true, silent = true })
vim.keymap.set('n', '<Down>', '<C-w>-', { noremap = true, silent = true })
vim.keymap.set('n', '<Left>', '<C-w><', { noremap = true, silent = true })
vim.keymap.set('n', '<Right>', '<C-w>>', { noremap = true, silent = true })

-- Window Splits
vim.keymap.set('n', '<leader>v', '<C-w>v', { noremap = true, silent = true, desc = "V Split" })

-- Delete (Close) buffer
-- WK.register({ b = { name = "Buffer", } }, { prefix = "<leader>" })
vim.keymap.set('n', '<leader>c', ':BufferClose!<CR>', { desc = "Close Buffer", noremap = true, silent = true })

-- Close buffer and Quit Window. If you want to quit the window only, use :q manually
vim.keymap.set('n', '<leader>q', ':BufferClose!<CR>:q<CR>',
  { desc = "Quit by closing buffer and window.", silent = true })

-- Save, and then close the buffer. If you want to save only, use :w manually.
vim.keymap.set('n', '<leader>w', ':w<CR>:BufferClose!<CR>', { desc = "Write" })

-- File tree!
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = "Neotree", silent = true })

-- Repeat last macro with ',' instead of '@@'
-- vim.keymap.set('n', ',', '@@', {})

-- Open split open terminal and resize, enter insert mode to work in terminal.
vim.keymap.set('n', '<leader>t', ':split | resize 10 | term<CR>i', { desc = "Terminal", silent = true })

-- Noice
WK.register({ n = { name = "Noice", } }, { prefix = "<leader>" })
vim.keymap.set('n', '<leader>nh', ':NoiceHistory<CR>', { desc = "History", silent = true })
vim.keymap.set('n', '<leader>nd', ':NoiceDismiss<CR>', { desc = "Dismiss Messages", silent = true })

-- Open Package Manager
vim.keymap.set('n', '<leader>p', ':Lazy<CR>', { desc = "Package Manager", silent = true })

-- F5, execute code!
local execute_code = function()
  if vim.bo.filetype == "python" then
    local run_cmd = "python " .. vim.fn.expand('%:p')
    vim.cmd("split | resize 10 | term " .. run_cmd)
    vim.cmd("startinsert")
  end
end

vim.keymap.set('n', '<F5>', execute_code, {})

-- Search and replace
local substitute_prompt = function()
  --local find = vim.fn.input("Find: ")
  local find = vim.fn.expand("<cword>")
  vim.api.nvim_echo({ { 'Replacing: "' .. find .. '"', 'Highlight' } }, true, {})
  local replace = vim.fn.input("Replace: ")
  if replace == "" then
    vim.api.nvim_echo({ { 'Canceled Replace.', 'Highlight' } }, true, {})
    return
  end
  vim.cmd("silent! %s/" .. find .. "/" .. replace .. "/g")
  vim.api.nvim_echo({ { find .. ' --> ' .. replace, 'Highlight' } }, true, {})
end

vim.keymap.set('n', '<leader>r', substitute_prompt, { desc = "Replace word under cursor" })

-- Search and replace
local substitute_prompt_full = function()
  local find = vim.fn.input("Find: ")
  vim.api.nvim_echo({ { 'Replacing: "' .. find .. '"', 'Highlight' } }, true, {})
  local replace = vim.fn.input("Replace: ")
  if replace == "" then
    vim.api.nvim_echo({ { 'Canceled Replace.', 'Highlight' } }, true, {})
    return
  end
  vim.cmd("silent! %s/" .. find .. "/" .. replace .. "/g")
  vim.api.nvim_echo({ { find .. ' --> ' .. replace, 'Highlight' } }, true, {})
end

vim.keymap.set('n', '<leader>R', substitute_prompt_full, { desc = "Replace word defined" })

local function get_filename_from_path(full_path)
    return full_path:match("^.+/(.+)$") or full_path
end

local last_destination = ""
local scp_file = function()
  local file_path = vim.api.nvim_buf_get_name(0)

  -- Use the last destination as the default value in the prompt
  local prompt = "Destination: "
  if last_destination ~= "" then
    prompt = "Destination (" .. last_destination .. "): "
  end

  local destinationInput = vim.fn.input(prompt)
  local remote_path = destinationInput ~= "" and destinationInput or last_destination
  if remote_path == "" then
    print("No destination provided.")
    return
  end

  -- Store the provided destination for next time
  last_destination = remote_path

  remote_path = "remote_host:" .. remote_path

  local scp_command = string.format("scp %s %s >/dev/null 2>&1", file_path, remote_path)

  local proc = io.popen(scp_command, "w")
  if proc then
    proc:write("\n")
    proc:close()
    vim.api.nvim_echo({ { get_filename_from_path(file_path) .. ' --> ' .. remote_path, 'Highlight' } }, true, {})
  else
    vim.api.nvim_echo({ { 'Failed to start command' , 'Highlight' } }, true, {})
  end
end

vim.keymap.set('n', '<leader>b', scp_file, {desc = "Beam"})

local dispatch_remote_command = function()
  -- ln -s /etc/dropbear/authorized_keys ~/.ssh/authorized_keys
  local prompt = "Command: "
  local command = vim.fn.input(prompt)

  if command == "" then
    vim.api.nvim_echo({ { 'Canceled dispatch remote command.', 'Highlight' } }, true, {})
    return
  end

  local full_command = 'ssh -o PreferredAuthentications=publickey remote_host "source ~/.bashrc; ' .. command .. ' > /dev/null 2>&1 &"'

  local proc = io.popen(full_command, "w")
  if proc then
    proc:write("\n")
    proc:close()
  else
    vim.api.nvim_echo({ { 'Failed to start command' , 'Highlight' } }, true, {})
  end
  vim.api.nvim_echo({ { command .. ' -->  Remote' , 'Highlight' } }, true, {})
end

vim.keymap.set('n', '<leader>d', dispatch_remote_command, {desc = "Dispatch remote command"})

-- Custom command that will take a list from a text file, and open buffers for each list.
vim.cmd [[command OpenFileList let i=1 | while i <= line('$') | execute 'tabedit '.getline(i) | tabclose | let i += 1 | endwhile]]

-- This function will close a terminal automatically if it gets the exit 0 text
vim.api.nvim_create_autocmd('TextChangedT', {
  callback = function()
    local buffer_name = vim.api.nvim_buf_get_name(0)
    local buffer_table = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local buffer_text = table.concat(buffer_table, '\n')
    if string.find(buffer_text, "Process exited 0") then
      vim.api.nvim_input('<ESC>')
      local timer = vim.loop.new_timer()
      if timer then
        timer:start(100, 0, function()
          vim.schedule(function()
            vim.cmd("silent! bdelete" .. ' ' .. buffer_name .. '!')
          end)
        end)
      end
    end
  end,
  pattern = '*',
})

-- If buffers > 1, show the tabline.
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    local buf_count = vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 }))
    -- if there are more than one buffer, show the tabline, else hide it
    if buf_count > 1 then
      vim.o.showtabline = 2
    else
      vim.o.showtabline = 0
    end
  end,
  pattern = '*',
})

-- [[ VimLeavePre ]]
-- Stuff to do on exit.

-- Session stuff disabled for now, this leaves annoying session files everywhere.
-- vim.api.nvim_create_autocmd('VimLeavePre', {
--   callback = function()
--     vim.cmd([[:mksession! .session.vim]])
--   end,
--   pattern = '*',
-- })

-- Python based settings
-- For folding...
-- vim.api.nvim_create_autocmd('BufReadPost', {
--   callback = function()
--     vim.cmd([[:set foldlevel=2]])
--   end,
--   pattern = '*.py',
-- })

-- Quit nvim when current buffer become a no-name empty buffer
vim.api.nvim_create_autocmd('BufDelete', {
  callback = function()
    local buffer_name = vim.api.nvim_buf_get_name(0)
    if buffer_name == "" then
      vim.cmd([[:quit!]])
    end
  end,
  pattern = '*',
})


-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = 'Recently opened files' })

vim.keymap.set('n', '<leader><space>', ':BufferPick<CR>', { desc = 'Pick tab' })

vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Fuzzy search' })

WK.register({ s = { name = "Search", } }, { prefix = "<leader>" })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Files' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Help' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Word' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Grep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Diagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}



-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local lsp_map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  local silent_lsp_map = function(keys, func, desc)
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, silent = true })
  end

  WK.register({ l = { name = "LSP", } }, { prefix = "<leader>" })
  lsp_map('<leader>lr', vim.lsp.buf.rename, 'Rename')
  lsp_map('<leader>la', vim.lsp.buf.code_action, 'Action')

  WK.register({ lg = { name = "Goto", } }, { prefix = "<leader>" })
  lsp_map('<leader>lgd', vim.lsp.buf.definition, 'Goto Definition')
  lsp_map('<leader>lgD', vim.lsp.buf.declaration, 'Goto Declaration')
  lsp_map('<leader>lgr', require('telescope.builtin').lsp_references, 'Goto References')
  lsp_map('<leader>lgI', vim.lsp.buf.implementation, 'Goto Implementation')

  lsp_map('<leader>lt', vim.lsp.buf.type_definition, 'Type Definition')
  lsp_map('<leader>ls', require('telescope.builtin').lsp_document_symbols, '(Document) Symbols')
  lsp_map('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '(Workspace) Symbols')

  -- See `:help K` for why this keymap
  lsp_map('<leader>lk', vim.lsp.buf.hover, 'Hover Documentation')
  lsp_map('<leader>lK', vim.lsp.buf.signature_help, 'Signature Documentation')

  WK.register({ lw = { name = "Workspace", } }, { prefix = "<leader>" })
  lsp_map('<leader>lwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  lsp_map('<leader>lwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  lsp_map('<leader>lwl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format({ timeout_ms = 10000 })
  end, { desc = 'Format current buffer with LSP' })

  silent_lsp_map('<leader>lf', ":Format<CR>", 'Format')
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  pylsp = {
    plugins = {
      ruff = {
        -- Configure ruff by adding a pyproject.toml in the project root.
        -- See https://github.com/charliermarsh/ruff
        enabled = true,
        extendSelect = { "I" },
      },
    }
  },
  rust_analyzer = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
    clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- tsserver = {},
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
