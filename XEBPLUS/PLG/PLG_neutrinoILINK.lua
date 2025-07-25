if neuLang == nil then
    dofile("APPS/neutrinoLauncher/neutrinoLang.lua")
end

if NEUTRINO_EnableILINK == true then
	PluginData = {};
	PluginData.Type = "LuaScript";
	PluginData.Category = 3;
	PluginData.Name = neuLang[75];
	PluginData.Description = neuLang[76];
	PluginData.Safe = true;
	PluginData.ValueA = "APPS/neutrinoLauncher/loadILINK.lua";
	PluginData.ValueB = "NONE";
	PluginData.ValueC = "NONE";
	if theXEBPlusVersion == "XEBPLUS-2022-09" then -- If using the XEB+ Xmas showcase, an external icon will be loaded
		PluginData.Icon = 120; -- Preventive, in case the game files' are missing
		if System.doesFileExist(System.currentDirectory().."THM/"..loadedTheme.."/ic_tool_neutrino_ilink.png") then
			AddnilinkIcon=#themeInUse+1
			themeInUse[AddnilinkIcon] = Graphics.loadImage(System.currentDirectory().."THM/"..loadedTheme.."/ic_tool_neutrino_ilink.png")
			PluginData.Icon = AddnilinkIcon;
		elseif System.doesFileExist(System.currentDirectory().."THM/"..loadedTheme.."/ic_media_ilink.png") then
			AddnilinkIcon=#themeInUse+1
			themeInUse[AddnilinkIcon] = Graphics.loadImage(System.currentDirectory().."THM/"..loadedTheme.."/ic_media_ilink.png")
			PluginData.Icon = AddnilinkIcon;
		elseif System.doesFileExist(System.currentDirectory().."APPS/neutrinoLauncher/image/ic_tool_neutrino_ilink.png") then
			AddnilinkIcon=#themeInUse+1
			themeInUse[AddnilinkIcon] = Graphics.loadImage(System.currentDirectory().."APPS/neutrinoLauncher/image/ic_tool_neutrino_ilink.png")
			PluginData.Icon = AddnilinkIcon;
		end
	else -- Else, the icon will be loaded from XEB+'s theme
		PluginData.Icon = 120;
	end
end
