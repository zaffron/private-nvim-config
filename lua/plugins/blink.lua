require("blink.cmp").setup({
  fuzzy = {
    prebuilt_binaries = {
      force_version = "v1.*",
    },
  },
  snippets = { preset = "default" },
  signature = { enabled = true },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "normal",
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
    providers = {
      cmdline = {
        min_keyword_length = 2,
      },
    },
  },
  keymap = {
    preset = "default",
  },
  cmdline = {
    enabled = true,
    completion = { menu = { auto_show = true } },
  },
  completion = {
    menu = {
      border = "none",
      scrolloff = 1,
      scrollbar = false,
      draw = {
        columns = {
          { "kind_icon" },
          { "label", "label_description", gap = 1 },
          { "kind" },
          { "source_name" },
        },
      },
    },
    documentation = {
      window = {
        border = "rounded",
        scrollbar = false,
      },
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },
})
