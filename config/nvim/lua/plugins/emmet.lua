return {
  -- Emmet support for HTML/CSS/JSX/TSX
  {
    "olrtg/nvim-emmet",
    ft = {
      "html",
      "css",
      "scss",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
    },
    config = function()
      vim.keymap.set({ "n", "v" }, "<leader>ce", require("nvim-emmet").wrap_with_abbreviation, {
        desc = "Emmet wrap with abbreviation",
      })
    end,
  },

  -- Configure emmet LSP with restricted trigger
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_language_server = {
          filetypes = {
            "css",
            "html",
            "javascript",
            "javascriptreact",
            "scss",
            "typescript",
            "typescriptreact",
            "vue",
            "svelte",
          },
        },
      },
    },
  },

  -- Deprioritize Emmet completions - keywords first, Emmet last
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    opts = function(_, opts)
      local cmp = require("cmp")
      local Kind = cmp.lsp.CompletionItemKind

      -- Filter out simple word-wrapping Emmet completions
      opts.sources = opts.sources or cmp.config.sources({
        { name = "nvim_lsp" },
      })

      -- Apply entry_filter to nvim_lsp source
      for _, source in ipairs(opts.sources) do
        if source.name == "nvim_lsp" then
          local original_filter = source.entry_filter
          source.entry_filter = function(entry, ctx)
            -- First apply original filter if exists
            if original_filter and not original_filter(entry, ctx) then
              return false
            end

            -- Get the completion item
            local item = entry:get_completion_item()

            -- Check if it's likely an Emmet completion wrapping a simple word
            if item.kind == Kind.Snippet or item.kind == Kind.Text then
              local text = item.insertText or item.label or ""
              local label = item.label or ""

              -- Filter out simple tag wrapping patterns like <return></return>
              -- But keep Emmet abbreviations like div.class, ul>li, etc.
              if text:match("^<[a-z]+>") and text:match("</[a-z]+>$") and not text:match("[.#>*+]") then
                -- This looks like a simple word wrapped in tags
                -- Check if the word matches what user is typing
                local word = text:match("^<([a-z]+)>")
                if word and ctx.cursor_before_line:lower():match(word) then
                  return false -- Filter it out
                end
              end
            end

            return true
          end
        end
      end

      -- Also add sorting comparator to deprioritize remaining Emmet items
      opts.sorting = opts.sorting or {}
      opts.sorting.comparators = {
        -- Custom comparator: Deprioritize Snippet/Text kind items
        function(entry1, entry2)
          local kind1 = entry1:get_kind()
          local kind2 = entry2:get_kind()

          local is_snippet1 = kind1 == Kind.Snippet or kind1 == Kind.Text
          local is_snippet2 = kind2 == Kind.Snippet or kind2 == Kind.Text

          if is_snippet1 and not is_snippet2 then
            return false
          elseif not is_snippet1 and is_snippet2 then
            return true
          end
        end,
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        cmp.config.compare.recently_used,
        cmp.config.compare.locality,
        cmp.config.compare.kind,
        cmp.config.compare.length,
        cmp.config.compare.order,
      }

      return opts
    end,
  },
}
