return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',

  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },

  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    -- require('mason-nvim-dap').setup_handlers()

    -- Basic debugging keymaps, feel free to change to your liking!
    --
    --
    --#region
    --
    --
    local function store_last_action(func)
      func()
      _G.last_action = func
    end

    WK = require("which-key")
    WK.register({ d = { name = "Debug", } }, { prefix = "<leader>" })
    vim.keymap.set('n', '<leader>dc', function() store_last_action(dap.continue) end, { desc = "Continue" })
    vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = "Terminate" })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = "Step into" })
    vim.keymap.set('n', '<leader>dv', dap.step_over, { desc = "Step over" })
    vim.keymap.set('n', '<leader>du', dap.step_out, { desc = "Step out" })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set('n', '<leader>dl', dap.list_breakpoints, { desc = "List breakpoints" })
    vim.keymap.set('n', '<leader>dr', dap.clear_breakpoints, { desc = "Remove breakpoint(s)" })

    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end,
    { desc = "Set breakpoint" })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      icons = {
        expanded = '▾',
        collapsed = '▸',
        current_frame = '*',
      },
      -- remove these so that the default symbols are used too.
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
        },
        vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'Error' })
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    dap.adapters.python = {
      type = 'executable',
      command = 'python',
      args = { '-m', 'debugpy.adapter' },
    }
    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          return '/usr/bin/python'
        end,
      },
    }

    -- Install golang specific config
    require('dap-go').setup()
  end,
}
