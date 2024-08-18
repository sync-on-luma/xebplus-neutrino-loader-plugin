nSetLang = {};
if XEBPlusLanguage == "en-US" then
    nSetLang[1] = "neutrino Launcher (HDD) Settings"
    nSetLang[2] = "Configure neutrino Launcher menu"
    nSetLang[3] = "Disable game specific artwork in menu."
    nSetLang[4] = "Disable loading and other messages\nthat appear at the bottom of the screen."
    nSetLang[5] = "Highlighted game's icon will not rotate."
    nSetLang[6] = "Refresh artwork cache next time the\n menu is launched."
    nSetLang[7] = "Delete and re-copy all cached files.\nWARNING: This can take a very long\ntime."
    nSetLang[8] = "Disable Artwork"
    nSetLang[9] = "Disable Status Messages"
    nSetLang[10] = "Disable Auto-Recache"
    nSetLang[11] = "Refresh Artwork Cache"
    nSetLang[12] = "Cache Refresh Queued"
    nSetLang[13] = "Rebuild Artwork Cache"
    nSetLang[14] = "Cache Rebuild Queued"
    nSetLang[15] = "Disable Icon Animation"
elseif XEBPlusLanguage == "es-419" then
    nSetLang[1] = "Configuración del lanzador neutrino (HDD)"
    nSetLang[2] = "Configurar el menú del lanzador de neutrino"
    nSetLang[3] = "Desactiva el arte específico del juego en\nel menú."
    nSetLang[4] = "Deshabilitar la carga y otros mensajes que\naparecen en la parte inferior de la pantalla."
    nSetLang[5] = "Desactiva la animación del icono de giro\ndel disco en el menú"
    nSetLang[6] = "Actualizar el caché de arte la próxima vez\nque se inicie el menú."
    nSetLang[7] = "Elimine y vuelva a copiar todos los\narchivos almacenados en caché.\nADVERTENCIA: Esto puede llevar mucho\ntiempo."
    nSetLang[8] = "Deshabilitar arte"
    nSetLang[9] = "Deshabilitar mensajes de estado"
    nSetLang[10] = "Deshabilitar la reconst. del caché automática"
    nSetLang[11] = "Actualizar caché de arte"
    nSetLang[12] = "Actualización de caché en cola"
    nSetLang[13] = "Reconstruir la caché de arte"
    nSetLang[14] = "Encolada la reconstrucción del caché"
    nSetLang[15] = "Desactivar animación de iconos"
elseif XEBPlusLanguage == "pt-BR" then
    nSetLang[1] = "Configurações do neutrino Launcher (HDD)"
    nSetLang[2] = "Configurar menu do neutrino Launcher"
    nSetLang[3] = "Desative a artwork específica do jogo\nno menu."
    nSetLang[4] = "Desative o carregamento e outras\nmensagens que apareçam na parte\ninferior do ecrã."
    nSetLang[5] = "Desative a animação do ícone  do\ndisco no menu"
    nSetLang[6] = "Atualize a cache de artwork na próxima\nvez que o menu for iniciado."
    nSetLang[7] = "Apague e copie novamente todos os\nficheiros em cache.\nAVISO: Isto pode levar muito tempo."
    nSetLang[8] = "Desativar artwork"
    nSetLang[9] = "Desativar mensagens de estado"
    nSetLang[10] = "Desativar o recache automático"
    nSetLang[11] = "Atualizar cache de artwork"
    nSetLang[12] = "Atualização de cache em espera..."
    nSetLang[13] = "Reconstruir cache de artwork"
    nSetLang[14] = "Reconstrução de cache em espera..."
    nSetLang[15] = "Desativar animação de ícones"
end

PluginData = {};
PluginData.Type = "LuaScript";
PluginData.Category = 6;
PluginData.Name = nSetLang[1];
PluginData.Description = nSetLang[2];
PluginData.Safe = true;
PluginData.ValueA = "APPS/neutrinoHDD/settings.lua";
PluginData.ValueB = "NONE";
PluginData.ValueC = "NONE";
if theXEBPlusVersion == "XEBPLUS-2022-09" then -- If using the XEB+ Xmas showcase, an external icon will be loaded
	PluginData.Icon = 70; -- Preventive, in case the game files' are missing
	if System.doesFileExist(System.currentDirectory().."APPS/neutrinoHDD/image/ic_set_neutrino_hdl.png") then
		AddneutrinosethdlIcon=#themeInUse+1
		themeInUse[AddneutrinosethdlIcon] = Graphics.loadImage(System.currentDirectory().."APPS/neutrinoHDD/image/ic_set_neutrino_hdl.png")
		PluginData.Icon = AddneutrinosethdlIcon;
	end
else -- Else, the icon will be loaded from XEB+'s theme
	PluginData.Icon = 70;
end
