local utils = require "astrocommunity.utils"
local events = require "neo-tree.events"
local function on_file_remove(args)
  local ts_clients = vim.lsp.get_active_clients { name = "tsserver" }
  for _, ts_client in ipairs(ts_clients) do
    ts_client.request("workspace/executeCommand", {
      command = "_typescript.applyRenameFile",
      arguments = {
        {
          sourceUri = vim.uri_from_fname(args.source),
          targetUri = vim.uri_from_fname(args.destination),
        },
      },
    })
  end
end

return {
  {
    "williamboman/mason.nvim",
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table or string "all".
      if not opts.ensure_installed then
        opts.ensure_installed = {}
      elseif opts.ensure_installed == "all" then
        return
      end
      -- Add the required file types to opts.ensure_installed.
      utils.list_insert_unique(opts.ensure_installed, { "javascript", "typescript", "tsx", "astro", "svelte" })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table.
      if not opts.ensure_installed then opts.ensure_installed = {} end
      -- Add tsserver to opts.ensure_installed using vim.list_extend.
      utils.list_insert_unique(opts.ensure_installed, { "tsserver", "astro", "svelte" })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      -- Ensure that opts.ensure_installed exists and is a table.
      if not opts.ensure_installed then opts.ensure_installed = {} end
      -- Add to opts.ensure_installed using vim.list_extend.
      utils.list_insert_unique(opts.ensure_installed, "prettierd")
    end,
  },
  {
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
    config = true,
    event = "BufRead package.json",
  },
  {
    "jose-elias-alvarez/typescript.nvim",
    init = function() utils.list_insert_unique(astronvim.lsp.skip_setup, "tsserver") end,
    ft = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
    },
    opts = function() return { server = require("astronvim.utils.lsp").config "tsserver" } end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      event_handlers = {
        {
          event = events.FILE_MOVED,
          handler = on_file_remove,
        },
        {
          event = events.FILE_RENAMED,
          handler = on_file_remove,
        },
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    ft = { "ts", "js", "tsx", "jsx" },
    enabled = true,
    dependencies = {
      {
        "mxsdev/nvim-dap-vscode-js",
        opts = {
          debugger_path = "/Users/mikehamrah/pdev/vscode-js-debug",
          --  debugger_cmd = { "js-debug-adapter" },
          adapters = { "pwa-node", "node-terminal", "pwa-chrome" },
        },
      },
    },
    config = function()
      local dap = require "dap"

      local attach_node = {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = function(...) return require("dap.utils").pick_process(...) end,
        cwd = "${workspaceFolder}",
      }

      dap.configurations.typescriptreact = {
        -- {
        --   name = "Chrome attach",
        --   type = "pwa-chrome",
        --   request = "attach",
        --   program = "${file}",
        --   cwd = vim.fn.getcwd(),
        --   sourceMaps = true,
        --   protocol = "inspector",
        --   port = 9222,
        --   webRoot = "${workspaceFolder}",
        -- },
        {
          name = "Chrome launch",
          type = "pwa-chrome",
          request = "launch",
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          port = 9222,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          -- program = '${file}',
          -- cwd = vim.fn.getcwd(),
          -- sourceMaps = true,
          protocol = "inspector",
          -- port = 9222,
          -- webRoot = '${workspaceFolder}',
        },
        {
          name = "Next.js: debug server-side",
          type = "pwa-node",
          request = "launch",
          command = "npm run dev",
        },
        {
          name = "Next.js: debug full stack",
          type = "pwa-node",
          request = "launch",
          console = "integratedTerminal",
          command = "npm run dev",
          serverReadyAction = {
            pattern = "started server on .+, url: (https?://.+)",
            uriFormat = "%s",
            action = "debugWithChrome",
          },
        },
        attach_node,
      }
    end,
  },
}
