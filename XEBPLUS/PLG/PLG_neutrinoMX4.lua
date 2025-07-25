if neuLang == nil then
    dofile("APPS/neutrinoLauncher/neutrinoLang.lua")
end

if NEUTRINO_EnableMX4 == true then
	PluginData = {};
	PluginData.Type = "LuaScript";
	PluginData.Category = 3;
	PluginData.Name = neuLang[50];
	PluginData.Description = neuLang[51];
	PluginData.Safe = true;
	PluginData.ValueA = "APPS/neutrinoLauncher/loadMX4.lua";
	PluginData.ValueB = "NONE";
	PluginData.ValueC = "NONE";
	if theXEBPlusVersion == "XEBPLUS-2022-09" then -- If using the XEB+ Xmas showcase, an external icon will be loaded
		PluginData.Icon = 96; -- Preventive, in case the game files' are missing
		if System.doesFileExist(System.currentDirectory().."THM/"..loadedTheme.."/ic_tool_neutrino_mx4.png") then
			Addnmx4Icon=#themeInUse+1
			themeInUse[Addnmx4Icon] = Graphics.loadImage(System.currentDirectory().."THM/"..loadedTheme.."/ic_tool_neutrino_mx4.png")
			PluginData.Icon = Addnmx4Icon;
		elseif System.doesFileExist(System.currentDirectory().."THM/"..loadedTheme.."/ic_media_mx4sio.png") then
			Addnmx4Icon=#themeInUse+1
			themeInUse[Addnmx4Icon] = Graphics.loadImage(System.currentDirectory().."THM/"..loadedTheme.."/ic_media_mx4sio.png")
			PluginData.Icon = Addnmx4Icon;
		elseif System.doesFileExist(System.currentDirectory().."APPS/neutrinoLauncher/image/ic_tool_neutrino_mx4.png") then
			Addnmx4Icon=#themeInUse+1
			themeInUse[Addnmx4Icon] = Graphics.loadImage(System.currentDirectory().."APPS/neutrinoLauncher/image/ic_tool_neutrino_mx4.png")
			PluginData.Icon = Addnmx4Icon;
		end
	else -- Else, the icon will be loaded from XEB+'s theme
		PluginData.Icon = 96;
	end
end
