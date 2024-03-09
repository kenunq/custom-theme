local util = require("solarized-osaka.util")
local hslutil = require("solarized-osaka.hsl")
local hsl = hslutil.hslToHex

local M = {}

---@class Palette
M.default = {
  none = "NONE",

  base04 = "#00FF80",
  base03 = "#00FF80",
  base02 = "#00FF80",
  base01 = "#00FF80",
  base00 = "#00FF80",
  -- base0 = hsl( 186, 8, 55 ),
  base0 = "#00FF80",
  -- base1 = hsl( 180, 7, 60 ),
  base1 = "#00FF80",
  base2 = "#00FF80",
  base3 = "#00FF80",
  base4 = "#00FF80",
  yellow = "#00FF80",
  yellow100 = "#00FF80",
  yellow300 = "#00FF80",
  yellow500 = "#00FF80",
  yellow700 = "#00FF80",
  yellow900 = "#00FF80",
  orange = "#00FF80",
  orange100 = "#00FF80",
  orange300 = "#00FF80",
  orange500 = "#00FF80",
  orange700 = "#00FF80",
  orange900 = "#00FF80",
  red = "#00FF80",
  red100 = "#00FF80",
  red300 = "#00FF80",
  red500 = "#00FF80",
  red700 = "00FF80",
  red900 = "#00FF80",
  magenta = hsl(331, 64, 52),
  magenta100 = hsl(331, 100, 73),
  magenta300 = hsl(331, 86, 64),
  magenta500 = hsl(331, 64, 52),
  magenta700 = hsl(331, 64, 42),
  magenta900 = hsl(331, 65, 20),
  violet = hsl(237, 43, 60),
  violet100 = hsl(236, 100, 90),
  violet300 = hsl(237, 69, 77),
  violet500 = hsl(237, 43, 60),
  violet700 = hsl(237, 43, 50),
  violet900 = hsl(237, 42, 25),
  blue = hsl(205, 69, 49),
  blue100 = hsl(205, 100, 83),
  blue300 = hsl(205, 90, 62),
  blue500 = hsl(205, 69, 49),
  blue700 = hsl(205, 70, 35),
  blue900 = hsl(205, 69, 20),
  cyan = hsl(175, 59, 40),
  cyan100 = hsl(176, 100, 86),
  cyan300 = hsl(175, 85, 55),
  cyan500 = hsl(175, 59, 40),
  cyan700 = hsl(182, 59, 25),
  cyan900 = hsl(183, 58, 15),
  green = hsl(68, 100, 30),
  green100 = hsl(90, 100, 84),
  green300 = hsl(76, 100, 49),
  green500 = hsl(68, 100, 30),
  green700 = hsl(68, 100, 20),
  green900 = hsl(68, 100, 10),

  bg = hsl(15, 100, 6),
  bg_highlight = hsl(192, 100, 11),
  fg = hsl(186, 8, 55),
}

---@return ColorScheme
function M.setup(opts)
  opts = opts or {}
  local config = require("solarized-osaka.config")

  -- local style = config.is_day() and config.options.light_style or config.options.style
  local style = "default"
  local palette = M[style] or {}
  if type(palette) == "function" then
    palette = palette()
  end

  -- Color Palette
  ---@class ColorScheme: Palette
  local colors = vim.tbl_deep_extend("force", vim.deepcopy(M.default), palette)

  util.bg = colors.bg
  util.day_brightness = config.options.day_brightness

  colors.black = util.darken(colors.bg, 0.8, "#000000")
  colors.border = colors.black

  -- Popups and statusline always get a dark background
  colors.bg_popup = colors.base04
  colors.bg_statusline = "#BA528A"

  -- Sidebar and Floats are configurable
  colors.bg_sidebar = config.options.styles.sidebars == "transparent" and colors.none
    or config.options.styles.sidebars == "dark" and colors.base04
    or colors.bg

  colors.bg_float = config.options.styles.floats == "transparent" and colors.none
    or config.options.styles.floats == "dark" and colors.base04
    or colors.bg

  -- colors.fg_float = config.options.styles.floats == "dark" and colors.base01 or colors.fg
  colors.fg_float = colors.fg

  colors.error = colors.red500
  colors.warning = colors.yellow500
  colors.info = colors.blue500
  colors.hint = colors.cyan500

  config.options.on_colors(colors)
  if opts.transform and config.is_day() then
    util.invert_colors(colors)
  end

  return colors
end

return M
