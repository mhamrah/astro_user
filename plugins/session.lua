return {
  {
    "Shatur/neovim-session-manager",
    event = "BufWritePost",
    lazy = false,
    cmd = { "SessionManager", "VimEnter" },
    opts = {
      autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
    },
  },
}
