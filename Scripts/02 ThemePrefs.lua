local function OptionNameString(str)
	return THEME:GetString('OptionNames',str)
end

local Prefs =
{
	ExResult =
	{
		Default = false,
		Choices = { OptionNameString('Off'), OptionNameString('On') },
		Values = { false, true }
	},
	TStyle =
	{
		Default = 2,
		Choices = { "Single", "Versus", "Double" },
		Values = { 1, 2, 3 }
	},
}

ThemePrefs.InitAll(Prefs)