local wezterm = require 'wezterm'

-- Determine tab color based on cwd/title patterns
local function get_tab_color(tab)
  local cwd = tab.active_pane.current_working_dir
  local title = tab.active_pane.title

  local path = cwd and tostring(cwd) or ""
  local full_text = (path .. " " .. title):lower()
  
  -- Debug: uncomment to see what's being matched
  -- wezterm.log_info("Matching: " .. full_text)


  if full_text:match("prod") then
    return "#650808"  -- red
  elseif full_text:match("argocd") then
    return "#743808"  -- orange
  elseif full_text:match("ansible") then
    return "#990099"  -- purple/lilac
  elseif full_text:match("tg%-") then
    return "#2255aa"  -- blue
  elseif full_text:match("infra") then
    return "#003300"  -- green
  elseif full_text:match("dev") then
    return "#8F790D"  -- yellow
  elseif full_text:match("cicd") then
    return "#331900"
  elseif full_text:match("m4a4%.local") then  -- check for actual local machine
    return "#4f5353"  -- teal/dark cyan
  end

  -- default: same as active_tab color
  return "#4f5353"  -- dark burgundy
end

-- Custom tab title formatting with color
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab.active_pane.title
  local color = get_tab_color(tab)
  
  local bg = color
  local fg = "#ffffff"
  
  -- Dim inactive tabs
  if not tab.is_active then
    fg = "#bbbbbb"  -- lighter text for inactive
  else
    title = title .. " 🕹"  -- add indicator for active tab
  end
  
  -- Pad title to minimum width
  local min_width = 20
  local padded_title = title
  if #title < min_width then
    local padding = math.floor((min_width - #title) / 2)
    padded_title = string.rep(" ", padding) .. title .. string.rep(" ", padding)
  end
  
  return {
    { Background = { Color = bg } },
    { Foreground = { Color = fg } },
    { Text = " " .. padded_title .. " " },
  }
end)

return {
  -- Update the config when changes are detected
  automatically_reload_config = true,

  -- Word selection взято из iTerm
  selection_word_boundary = [[‹›""''<>*`,;:|&»❯▶=@ 	{}[]()\"']],
  

  -- Fonts
  font = wezterm.font("Monaco"),
  font_size = 17.0,

  -- windows size
  initial_cols = 190,
  initial_rows = 34,
  -- Оформление окна и табов
window_frame = {
  font = wezterm.font({ family = "Monaco"}),
  font_size = 16.0, -- увеличенный шрифт для табов

  -- active_titlebar_bg = "#3a0a0a",  -- бордовый фон активной вкладки
  -- inactive_titlebar_bg = "#1e1e1e", -- тёмный фон неактивной
},

  use_fancy_tab_bar = false,

  color_scheme = "Default (dark) (terminal.sexy)",
  -- color_scheme = "Monokai Vivid",
  --  override the background color to be more black
  colors = {
    background = "#000000",
    tab_bar = {
      background = "#1e1e1e",
    },
  },
  window_background_opacity = 0.9,
  macos_window_background_blur = 0,


  -- Colors (из iTerm профиля)
  -- colors = {
  --   foreground = "#bbbbbb",
  --   background = "#000000",

  --   cursor_bg = "#bbbbbb",
  --   cursor_fg = "#ffffff",
  --   cursor_border = "#bbbbbb",

  --   selection_bg = "#a0a0a0",
  --   selection_fg = "#000000",

  --   ansi = {
  --     "#000000", -- black
  --     "#bb0000", -- red
  --     "#00bb00", -- green
  --     "#bbbb00", -- yellow
  --     "#0000bb", -- blue
  --     "#bb00bb", -- magenta
  --     "#00bbbb", -- cyan
  --     "#bbbbbb", -- white (light gray)
  --   },
  --   brights = {
  --     "#555555", -- bright black
  --     "#ff5555", -- bright red
  --     "#55ff55", -- bright green
  --     "#ffff55", -- bright yellow
  --     "#5555ff", -- bright blue
  --     "#ff55ff", -- bright magenta
  --     "#55ffff", -- bright cyan
  --     "#ffffff", -- bright white
  --   },
  --   tab_bar = {
  --     background = "#1e1e1e", -- whole tab bar background

  --     active_tab = {
  --       bg_color = "#444444",  -- active tab background
  --       fg_color = "#ffffff",  -- active tab text
  --       intensity = "Bold",
  --     },

  --     inactive_tab = {
  --       bg_color = "#1e1e1e",  -- inactive tab background
  --       fg_color = "#888888",  -- inactive tab text
  --     },

  --     inactive_tab_hover = {
  --       bg_color = "#2e2e2e",
  --       fg_color = "#cccccc",
  --       italic = true,
  --     },

  --     new_tab = {
  --       bg_color = "#1e1e1e",
  --       fg_color = "#00bbbb",
  --     },

  --     new_tab_hover = {
  --       bg_color = "#2e2e2e",
  --       fg_color = "#55ffff",
  --       italic = true,
  --     },
  --   }
  -- },

  -- Window
  -- window_background_opacity = 0.9,  -- ~10% прозрачность, как в iTerm
  -- macos_window_background_blur = 0, -- blur был выключен

  -- Tabs
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_max_width = 32,

  -- Shell (автоматически возьмёт zsh/oh-my-zsh)
  default_prog = { "/bin/zsh", "-l" },

  -- Увеличенный scrollback
  scrollback_lines = 50000,

  -- Пример горячих клавиш под iTerm-стильss
  keys = {
    {key="d", mods="CMD", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},
    {key="d", mods="CMD|SHIFT", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
    {key="t", mods="CMD", action=wezterm.action.SpawnCommandInNewTab{ cwd = os.getenv("HOME"), domain = "CurrentPaneDomain" }},
    { key = "LeftArrow",  mods="CMD", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "RightArrow", mods="CMD", action = wezterm.action.ActivateTabRelative(1)  },
    },
  default_cwd = os.getenv("HOME"),
}
