return {
	{
		"dundalek/lazy-lsp.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
			{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/nvim-cmp",
		},
		-- By default all available servers are set up. Exclude unwanted or misbehaving servers.
		excluded_servers = {
			"zk", -- Locally installed in configuration.nix
			"ccls", -- prefer clangd
			"denols", -- prefer eslint and ts_ls
			"docker_compose_language_service", -- yamlls should be enough?
			"flow", -- prefer eslint and ts_ls
			"ltex", -- grammar tool using too much CPU
			"quick_lint_js", -- prefer eslint and ts_ls
			"scry", -- archived on Jun 1, 2023
			"tailwindcss", -- associates with too many filetypes
			"biome", -- not mature enough to be default
			"oxlint", -- prefer eslint
		},
		-- Alternatively specify preferred servers for a filetype (others will be ignored).
		preferred_servers = {
			markdown = {},
			lua = { "lua_ls" },
			python = { "basedpyright", "ruff" },
		},
		prefer_local = true, -- Prefer locally installed servers over nix-shell
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.on_attach(function(client, bufnr)
				-- see :help lsp-zero-keybindings to learn the available actions
				lsp_zero.default_keymaps({
					buffer = bufnr,
					preserve_mappings = false,
				})
			end)

			require("lazy-lsp").setup({})
		end,
	},
	{
		"stevearc/conform.nvim",
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua" },
				},
				format_on_save = {
					-- These options will be passed to conform.format()
					timeout_ms = 500,
					lsp_format = "fallback",
				},
			})
		end,
	},
}
