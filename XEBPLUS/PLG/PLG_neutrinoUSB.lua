if neuLang == nil then
    dofile("APPS/neutrinoLauncher/neutrinoLang.lua")
end

if NEUTRINO_EnableUSB == true then
	PluginData = {};
	PluginData.Type = "LuaScript";
	PluginData.Category = 3;
	PluginData.Name = neuLang[48];
	PluginData.Description = neuLang[49];
	PluginData.Safe = true;
	PluginData.ValueA = "APPS/neutrinoLauncher/loadUSB.lua";
	PluginData.ValueB = "NONE";
	PluginData.ValueC = "NONE";
	if theXEBPlusVersion == "XEBPLUS-2022-09" then -- If using the XEB+ Xmas showcase, an external icon will be loaded
		PluginData.Icon = 114; -- Preventive, in case the game files' are missing
		if System.doesFileExist(System.currentDirectory().."THM/"..loadedTheme.."/ic_tool_neutrino_usb.png") then
			AddnusblIcon=#themeInUse+1
			themeInUse[AddnusblIcon] = Graphics.loadImage(System.currentDirectory().."THM/"..loadedTheme.."/ic_tool_neutrino_usb.png")
			PluginData.Icon = AddnusblIcon;
		elseif System.doesFileExist(System.currentDirectory().."THM/"..loadedTheme.."/ic_media_usb.png") then
			AddnusblIcon=#themeInUse+1
			themeInUse[AddnusblIcon] = Graphics.loadImage(System.currentDirectory().."THM/"..loadedTheme.."/ic_media_usb.png")
			PluginData.Icon = AddnusblIcon;
		elseif System.doesFileExist(System.currentDirectory().."APPS/neutrinoLauncher/image/ic_tool_neutrino_usb.png") then
			AddnusblIcon=#themeInUse+1
			themeInUse[AddnusblIcon] = Graphics.loadImage(System.currentDirectory().."APPS/neutrinoLauncher/image/ic_tool_neutrino_usb.png")
			PluginData.Icon = AddnusblIcon;
		end
	else -- Else, the icon will be loaded from XEB+'s theme
		PluginData.Icon = 114;
	end
end
