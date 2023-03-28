local utils = require "astrocommunity.utils"
return {
  -- {
  --   "jay-babu/mason-nvim-dap.nvim",
  --   opts = function(_, opts)
  --     -- Ensure that opts.ensure_installed exists and is a table.
  --     if not opts.ensure_installed then opts.ensure_installed = {} end
  --     -- Add to opts.ensure_installed using table.insert.
  --     utils.list_insert_unique(opts.ensure_installed, "chrome")
  --   end,
  -- },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "mxsdev/nvim-dap-vscode-js",
        -- opts = { debugger_path="/Users/mikehamrah/pdev/vscode-js-debug",  adapters = { "pwa-node", } },
        opts = { adapters = { "pwa-node", "pwa-chrome" } },
      },
    },

    config = function()
      local dap = require "dap"

      dap.configurations.typescriptreact = {
          	{
		          name = 'Chrome attach',
		          type = 'pwa-chrome',
		          request = 'attach',

		          program = '${file}',
		          cwd = vim.fn.getcwd(),
		          sourceMaps = true,
		          protocol = 'inspector',
		          port = 9222,
		          webRoot = '${workspaceFolder}',
	          },
	            	{
		          name = 'Chrome launch',
		          type = 'pwa-chrome',
		          request = 'launch',
              url = 'http://localhost:3000',
		          webRoot = '${workspaceFolder}',
		          port = 9222,
		          cwd = vim.fn.getcwd(),
		          sourceMaps = true,

		          -- program = '${file}',
		          -- cwd = vim.fn.getcwd(),
		          -- sourceMaps = true,
		          -- protocol = 'inspector',
		          -- port = 9222,
		          -- webRoot = '${workspaceFolder}',
	          }

          }
    end,
  },
}
