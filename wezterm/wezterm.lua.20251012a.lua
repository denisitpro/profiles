local wezterm = require 'wezterm'

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
  },

  use_fancy_tab_bar = true,

  color_scheme = "Default (dark) (terminal.sexy)",
  -- color_scheme = "Monokai Vivid",
  --  override the background color to be more black
  colors = {
    background = "#000000",
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

  -- Shell (автоматически возьмёт zsh/oh-my-zsh)
  default_prog = { "/bin/zsh", "-l" },

  -- Увеличенный scrollback
  scrollback_lines = 50000,

  -- Пример горячих клавиш под iTerm-стильss
  keys = {
    {key="d", mods="CMD", action=wezterm.action.SplitHorizontal{domain="CurrentPaneDomain"}},
    {key="d", mods="CMD|SHIFT", action=wezterm.action.SplitVertical{domain="CurrentPaneDomain"}},
    {key="t", mods="CMD", action=wezterm.action.SpawnCommandInNewTab{ cwd = os.getenv("HOME"), domain = "CurrentPaneDomain" }},
    { key = "LeftArrow",  mods = "CMD", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "RightArrow", mods = "CMD", action = wezterm.action.ActivateTabRelative(1)  },
    },
  default_cwd = os.getenv("HOME"),
}
