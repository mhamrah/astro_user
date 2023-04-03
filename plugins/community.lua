return {
  {
    -- Add the community repository of plugin specifications
    "AstroNvim/astrocommunity",
    -- example of imporing a plugin, comment out to use it or add your own
    -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

    { import = "astrocommunity.colorscheme.rose-pine" },

    { import = "astrocommunity.pack.bash" },
    { import = "astrocommunity.pack.go" },
    { import = "astrocommunity.pack.json" },
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.tailwindcss" },
    { import = "astrocommunity.pack.toml" },
    { import = "astrocommunity.pack.yaml" },

    -- { import = "astrocommunity.completion.copilot-lua-cmp" },
  },
}
