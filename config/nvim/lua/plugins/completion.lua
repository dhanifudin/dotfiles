return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset = "default",
        -- Tab: accept current item (emmet expansion), advance snippet, or indent
        ["<Tab>"]   = { "accept", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        trigger = {
          -- Trigger completion on emmet special characters so abbreviations
          -- like div.container>ul>li*3 show completions as you type
          show_on_trigger_character = true,
          show_on_insert_on_trigger_character = true,
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          lsp = {
            -- Demote emmet items so keyword LSP completions always rank above them.
            -- For pure emmet abbreviations (e.g. div.container>ul>li*3) emmet will
            -- still be the only/first item, so Tab expands it correctly.
            transform_items = function(_, items)
              for _, item in ipairs(items) do
                if item.client_name == "emmet_language_server" then
                  item.score_offset = (item.score_offset or 0) - 3
                end
              end
              return items
            end,
          },
        },
      },
      signature = { enabled = true },
    },
  },
}
