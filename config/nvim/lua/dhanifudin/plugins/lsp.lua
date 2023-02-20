local status, nvim_lsp = pcall(require, "lspconfig")

if status then
	-- Mappings.
	-- See `:help vim.diagnostic.*` for documentation on any of the below functions
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<space>e", "vim.diagnostic.open_float()", opts)
	vim.keymap.set("n", "[d", "vim.diagnostic.goto_prev()", opts)
	vim.keymap.set("n", "]d", "vim.diagnostic.goto_next()", opts)
	vim.keymap.set("n", "<space>q", "vim.diagnostic.setloclist()", opts)

	-- Use an on_attach function to only map the following keys
	-- after the language server attaches to the current buffer
	local on_attach = function(_, bufnr)
		-- Enable completion triggered by <c-x><c-o>
		vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

		-- Mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local bufopts = { noremap = true, silent = true, buffer = bufnr }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
		-- vim.keymap.set(bufnr, 'n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, bufopts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
		-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, bufopts)
	end

	require("nvim-autopairs").setup({
		disable_filetype = { "TelescopePrompt", "vim" },
	})

	require("nvim-ts-autotag").setup()

	local cmp = require("cmp")

	local function replace_keys(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			end,
		},
		mapping = {
			["<Tab>"] = cmp.mapping(function(fallback)
				if vim.call("vsnip#available", 1) ~= 0 then
					vim.fn.feedkeys(replace_keys("<Plug>(vsnip-jump-next)"), "")
				elseif cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end, { "i", "s" }),

			["<S-Tab>"] = cmp.mapping(function(fallback)
				if vim.call("vsnip#available", -1) ~= 0 then
					vim.fn.feedkeys(replace_keys("<Plug>(vsnip-jump-prev)"), "")
				elseif cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
			["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
			["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
			["<C-c>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
			["<C-e>"] = cmp.mapping({
				i = cmp.mapping.abort(),
				c = cmp.mapping.close(),
			}),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "vsnip" }, -- For vsnip users.
			{ name = "buffer" },
			{ name = "path" },
		}),
	})

	-- `/` cmdline setup.
	cmp.setup.cmdline("/", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = "buffer" },
		},
	})

	-- `:` cmdline setup.
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
		}, {
			{
				name = "cmdline",
				option = {
					ignore_cmds = { "Man", "!" },
				},
			},
		}),
	})

	-- Setup lspconfig.
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	local servers = {
		"cssls",
		"dockerls",
		"gopls",
		"grammarly",
		"html",
		"intelephense",
		"jsonls",
		"pyright",
		"tsserver",
		"yamlls",
		"fortls",
	}

	for _, lsp in ipairs(servers) do
		nvim_lsp[lsp].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end

	local configs = require("lspconfig.configs")
	local util = require("lspconfig.util")

	if not configs.helm_ls then
		configs.helm_ls = {
			default_config = {
				cmd = { "helm_ls", "serve" },
				filetypes = { "helm" },
				root_dir = function(fname)
					return util.root_pattern("Chart.yaml")(fname)
				end,
				settings = {},
			},
		}
	end

	nvim_lsp.helm_ls.setup({
		filetypes = { "helm" },
		cmd = { "helm_ls", "serve" },
	})

	require("lspconfig").lua_ls.setup({
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})
end
