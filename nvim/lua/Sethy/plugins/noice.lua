return {
"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
        "MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("noice").setup({
			cmdline = {
				enabled = true,
				view = "cmdline_popup", -- Floating command line
				format = {
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
					search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
					filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
					lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
				},
			},
			popupmenu = {
				enabled = true,
				backend = "nui", -- Use nui backend for consistent floating UI
				kind_icons = {}, -- Use devicons
			},
			-- Disable other noice features if you don't want them
			messages = {
				enabled = false, -- Disable floating messages
			},
			notify = {
				enabled = false, -- Disable floating notifications
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- Custom styling to match your wilder theme
			views = {
				cmdline_popup = {
					border = {
						style = "single", -- Matches your wilder border
						padding = { 0, 1 },
					},
					filter_options = {},
					win_options = {
						winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder",
					},
				},
				popupmenu = {
					relative = "editor",
					position = {
						row = 8,
						col = "50%",
					},
					size = {
						width = 60,
						height = 10,
					},
					border = {
						style = "single", -- Matches your wilder style
						padding = { 0, 1 },
					},
					win_options = {
						winhighlight = { 
							Normal = "Normal", 
							FloatBorder = "DiagnosticInfo",
						},
					},
				},
			},
		})
		
		-- Custom highlight groups to match your wilder colors
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { bg = "#1E212B" })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#fffef7" })
		vim.api.nvim_set_hl(0, "NoicePopupmenu", { bg = "#1E212B" })
		vim.api.nvim_set_hl(0, "NoicePopupmenuSelected", { bg = "#1e1e2e", fg = "#fffef7" })
	end,
}
