if neuLang == nil then
    dofile("APPS/neutrinoLauncher/neutrinoLang.lua")
end

if NEUTRINO_EnableMMCE == true then
	PluginData = {};
	PluginData.Type = "LuaScript";
	PluginData.Category = 3;
	PluginData.Name = neuLang[83];
	PluginData.Description = neuLang[84];
	PluginData.Safe = true;
	PluginData.ValueA = "APPS/neutrinoLauncher/loadMMCE.lua";
	PluginData.ValueB = "NONE";
	PluginData.ValueC = "NONE";
	if theXEBPlusVersion == "XEBPLUS-2022-09" then -- If using the XEB+ Xmas showcase, an external icon will be loaded
		PluginData.Icon = 96; -- Preventive, in case the game files' are missing
		if System.doesFileExist(System.currentDirectory().."THM/"..loadedTheme.."/ic_tool_neutrino_mmce.png") then
			AddIcon=#themeInUse+1
			themeInUse[AddIcon] = Graphics.loadImage(System.currentDirectory().."THM/"..loadedTheme.."/ic_tool_neutrino_mmce.png")
			PluginData.Icon = AddIcon;
		elseif System.doesFileExist(System.currentDirectory().."APPS/neutrinoLauncher/image/ic_tool_neutrino_mmce.png") then
			AddneutrinohdlIcon=#themeInUse+1
			themeInUse[AddneutrinohdlIcon] = Graphics.loadImage(System.currentDirectory().."APPS/neutrinoLauncher/image/ic_tool_neutrino_mmce.png")
			PluginData.Icon = AddneutrinohdlIcon;
		end
	else -- Else, the icon will be loaded from XEB+'s theme
		PluginData.Icon = 96;
	end
end
