-- HackTheBox VIM
-- return {
--   "audibleblink/hackthebox.vim",
--   priority = 1000,
--   config = function()
--     vim.cmd("colorscheme hackthebox")
--   end,
-- }

-- Iceberg
return {
  "cocopon/iceberg.vim",
  priority = 1000,
  config = function()
    -- vim.g.iceberg_transparent_background = "0.80"
    vim.cmd("colorscheme iceberg")
    -- Manual transparency overrides
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#5c6370" }) -- or any valid color
  end,
}

-- TokyoNight
-- return {
--   "folke/tokyonight.nvim",
--   priority = 1000,
--   config = function()
--     local transparent = false -- set to true if you would like to enable transparency

--     -- local bg = "#161821"
--     -- local bg_dark = "#161821"
--     -- local bg_highlight = "#1E2132"
--     -- local bg_search = "#C6C8D1"
--     -- local bg_visual = "#C6C8D1"
--     -- local fg = "#C6C8D1"
--     -- local fg_dark = "#C6C8D1"
--     -- local fg_gutter = "#C6C8D1"
--     -- local border = "#91ACD1"

--     require("tokyonight").setup({
--       style = "night",
--       transparent = transparent,
--       styles = {
--         sidebars = transparent and "transparent" or "dark",
--         floats = transparent and "transparent" or "dark",
--       },
--       -- on_colors = function(colors)
--         -- colors.bg = bg
--         -- colors.bg_dark = transparent and colors.none or bg_dark
--         -- colors.bg_float = transparent and colors.none or bg_dark
--         -- colors.bg_highlight = bg_highlight
--         -- colors.bg_popup = bg_dark
--         -- colors.bg_search = bg_search
--         -- colors.bg_sidebar = transparent and colors.none or bg_dark
--         -- colors.bg_statusline = transparent and colors.none or bg_dark
--         -- colors.bg_visual = bg_visual
--         -- colors.border = border
--         -- colors.fg = fg
--         -- colors.fg_dark = fg_dark
--         -- colors.fg_float = fg
--         -- colors.fg_gutter = fg_gutter
--         -- colors.fg_sidebar = fg_dark
--       -- end,
--     })

--     vim.cmd("colorscheme tokyonight")
--   end,
-- }
