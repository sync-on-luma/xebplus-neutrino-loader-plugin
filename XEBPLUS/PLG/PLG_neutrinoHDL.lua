if neuLang == nil then
    dofile("APPS/neutrinoLauncher/neutrinoLang.lua")
end

if NEUTRINO_EnableHDL == true then
	PluginData = {};
	PluginData.Type = "LuaScript";
	PluginData.Category = 3;
	PluginData.Name = neuLang[90];
	PluginData.Description = neuLang[91];
	PluginData.Safe = true;
	PluginData.ValueA = "APPS/neutrinoLauncher/loadHDL.lua";
	PluginData.ValueB = "NONE";
	PluginData.ValueC = "NONE";
	if theXEBPlusVersion == "XEBPLUS-2022-09" then -- If using the XEB+ Xmas showcase, an external icon will be loaded
		PluginData.Icon = 88; -- Preventive, in case the game files' are missing
		if System.doesFileExist(System.currentDirectory().."THM/"..loadedTheme.."/ic_tool_neutrino_hdl.png") then
			AddnhdlIcon=#themeInUse+1
			themeInUse[AddnhdlIcon] = Graphics.loadImage(System.currentDirectory().."THM/"..loadedTheme.."/ic_tool_neutrino_hdl.png")
			PluginData.Icon = AddnhdlIcon;
		elseif System.doesFileExist(System.currentDirectory().."THM/"..loadedTheme.."/ic_media_hdd_ide.png") then
			AddnhdlIcon=#themeInUse+1
			themeInUse[AddnhdlIcon] = Graphics.loadImage(System.currentDirectory().."THM/"..loadedTheme.."/ic_media_hdd_ide.png")
			PluginData.Icon = AddnhdlIcon;
		elseif System.doesFileExist(System.currentDirectory().."APPS/neutrinoLauncher/image/ic_tool_neutrino_hdl.png") then
			AddnhdlIcon=#themeInUse+1
			themeInUse[AddnhdlIcon] = Graphics.loadImage(System.currentDirectory().."APPS/neutrinoLauncher/image/ic_tool_neutrino_hdl.png")
			PluginData.Icon = AddnhdlIcon;
		end
	else -- Else, the icon will be loaded from XEB+'s theme
		PluginData.Icon = 88;
	end
end
