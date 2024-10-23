-- Default
    
local theme = {}

theme.globalFontId = 12187365977 -- Rubik
theme.rightToLeft = false -- for right-to-left languages or style preferences

theme.color = {
	black = Color3.fromRGB(0, 0, 0),
	white = Color3.fromRGB(255, 255, 255),
	blue = Color3.fromRGB(0, 115, 255),
	light_gray = Color3.fromRGB(200, 200, 200),
	dark_gray = Color3.fromRGB(31, 31, 31),
}

theme.font = {
	regular = Font.fromId(theme.globalFontId, Enum.FontWeight.Regular),
	semiBold = Font.fromId(theme.globalFontId, Enum.FontWeight.SemiBold),
	bold = Font.fromId(theme.globalFontId, Enum.FontWeight.Bold),
}

theme.ui_background_color = theme.color.black
theme.ui_titlebar_color = theme.color.black
theme.ui_titlebar_content_color = theme.color.white
theme.ui_stroke_color = theme.color.blue
theme.ui_button_background_color = theme.color.dark_gray
theme.ui_button_text_color = theme.color.white
theme.ui_button_tooltip_background_color = theme.color.black
theme.ui_button_tooltip_text_color = theme.color.white
theme.ui_divider_group_color = theme.color.white
theme.ui_button_slider_on_color = theme.color.blue
theme.ui_button_slider_off_color = theme.color.black
theme.ui_button_slider_circle_color = theme.color.light_gray
theme.ui_scrollbar_color = theme.color.white

return theme
