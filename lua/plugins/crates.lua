return {
  "saecki/crates.nvim",
  event = { "BufRead Cargo.toml" },
  tag = "stable",
  dependencies = {
    "plenary.nvim",
  },
  config = function(_, opts)
    local crates = require("crates")
    crates.setup(opts)
    require("which-key").register({
      r = {
        c = {
          name = "Creates",
          t = { crates.toggle, "Toggle crates" },
          r = { crates.reload, "Reload crates" },
          v = { crates.show_versions_popup, "Show versions popup" },
          f = { crates.show_features_popup, "Show features popup" },
          d = { crates.show_dependencies_popup, "Show dependencies popup" },
          u = { crates.update_crate, "Update crate" },
          a = { crates.update_all_crates, "Update all crates" },
          U = { crates.upgrade_crate, "Upgrade crate" },
          A = { crates.upgrade_all_crates, "Upgrage all crates" },
          e = { crates.expand_plain_crate_to_inline_table, "Expand plain crate to inline table" },
          E = { crates.extract_crate_into_table, "Extrace crate into table" },
          H = { crates.open_homepage, "Open crate homepage" },
          R = { crates.open_repository, "Open crate repository" },
          D = { crates.open_documentation, "Open crate documentation" },
          C = { crates.open_crates_io, "Open crates.io" },
        },
      },
    })
  end,
}
