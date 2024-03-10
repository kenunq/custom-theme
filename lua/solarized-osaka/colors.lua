local util = require("solarized-osaka.util")
local hslutil = require("solarized-osaka.hsl")
local hsl = hslutil.hslToHex

local M = {}

---@class Palette
M.default = {
  none = "NONE",

  base04 = "#FF00D5",
  base03 = "#FF0000",
  base02 = "#8E8E8E",
  base01 = "#043700",
  base00 = "#F39A9A",
  -- base0 = hsl( 186, 8, 55 ),
  base0 = "#54086B",
  -- base1 = hsl( 180, 7, 60 ),
  base1 = "#236B08",
  base2 = "#84E3FF",
  base3 = "#BE84FF",
  base4 = "#FF8484",
  yellow = "#0089FF",
  yellow100 = "#0089FF",
  yellow300 = "#0089FF",
  yellow500 = "#0089FF",
  yellow700 = "#0089FF",
  yellow900 = "#0089FF",
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
  magenta = "#DE00FF",
  magenta100 = "#DE00FF",
  magenta300 = "#DE00FF",
  magenta500 = "#DE00FF",
  magenta700 = "#DE00FF",
  magenta900 = "#DE00FF",
  violet = "#000000",
  violet100 = "#000000",
  violet300 = "#000000",
  violet500 = "#000000",
  violet700 = "#000000",
  violet900 = "#000000",
  blue = "#373980",
  blue100 = "#373980",
  blue300 = "#373980",
  blue500 = "#373980",
  blue700 = "#373980",
  blue900 = "#373980",
  cyan = "#FFFFFF",
  cyan100 = "#FFFFFF",
  cyan300 = "#FFFFFF",
  cyan500 = "#FFFFFF",
  cyan700 = "#FFFFFF",
  cyan900 = "#FFFFFF",
  green = "#FFA200",
  green100 = "#FFA200",
  green300 = "#FFA200",
  green500 = "#FFA200",
  green700 = "#FFA200",
  green900 = "#FFA200",

  bg = "#372E66",
  bg_highlight = "#B0A8DB",
  fg = "#B0A8DB",
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
