return {
  "simrat39/rust-tools.nvim",
  config = function()
    local rt = require("rust-tools")
    local mason_registry = require("mason-registry")

    local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
    local codelldb_path = codelldb_root .. "adapter/codelldb"
    local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"

    rt.setup({
      server = {
        on_attach = require("lazy.core.plugin").values(require("plugins.nvim-lspconfig"), "opts", false).on_attach,
        settings = {
          ["rust_analyzer"] = require("lazy.core.plugin").values(
            require("lazy.core.config").plugins["nvim-lspconfig"],
            "opts",
            false
          ).servers["rust_analyzer"],
        },
        root_dir = require("lspconfig.util").root_pattern("Cargo.toml"),
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            "cargo",
            "clippy",
            "--workspace",
            "--message-format=json",
            "--all-targets",
            "--all-features",
          },
        },
      },
      dap = { adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) },
    })

    require("which-key").register({
      K = { "<cmd>RustHoverActions<cr>", "Hover actions (Rust)" },
      ["<leader>"] = {
        c = {
          R = { "<cmd>RustCodeAction<cr>", "Code Action (Rust)" },
        },
        d = {
          r = { "<cmd>RustDebuggables<cr>", "Run Debuggables (Rust) " },
        },
      },
    })
  end,
}
