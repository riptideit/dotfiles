return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- transparent floats everywhere
    vim.o.winblend = 20
    vim.o.pumblend = 12
    local function set_float_bg()
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    end
    set_float_bg()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_float_bg })

    require("noice").setup({
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
        format = {
          cmdline     = { pattern = "^:",  icon = "",  lang = "vim" },
          search_down = { kind = "search", pattern = "^/",  icon = " ", lang = "regex" },
          search_up   = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter      = { pattern = "^:%s*!", icon = "$",   lang = "bash" },
          lua         = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
        },
      },

      -- we still enable the popupmenu UI, but layout is controlled by the preset + views below
      popupmenu = {
        enabled = true,
        backend = "nui",
        kind_icons = {},
      },

      messages = { enabled = false },
      notify   = { enabled = false },

      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"]               = true,
          ["cmp.entry.get_documentation"]                 = true,
        },
      },

      -- 🔧 this preset places the cmdline and its popup together (like your screenshot)
      presets = {
        command_palette = true,  -- positions cmdline + popupmenu together
        -- bottom_search = true,  -- optional: classic /? at the bottom
      },

      views = {
        cmdline_popup = {
          border = { style = "single", padding = { 0, 1 } },
          win_options = {
            winblend = 20,
            winhighlight = "Normal:NormalFloat,NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
        -- NOTE: use cmdline_popupmenu (not the generic `popupmenu` key) so it renders under the cmdline
        cmdline_popupmenu = {
          relative = "editor",
          size     = { width = 60, height = 10 },
          border   = { style = "single", padding = { 0, 1 } },
          win_options = {
            winblend = 12,
            winhighlight = "Normal:NormalFloat,NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          },
        },
      },
    })

    -- keep border/selection visible; backgrounds stay transparent
    vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#fffef7", bg = "none" })
    vim.api.nvim_set_hl(0, "NoicePopupmenuSelected",  { bg = "#1e1e2e", fg = "#fffef7" })
  end,
}

