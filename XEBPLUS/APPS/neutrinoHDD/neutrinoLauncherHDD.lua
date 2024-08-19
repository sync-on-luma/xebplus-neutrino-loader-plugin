--------------------------------------------------------
-- NEUTRINO LAUNCHER HDD
--------------------------------------------------------
GoToSubMenuIcon(actualCat,actualOption,true)
XEBKeepInSubMenu=true
XEBKeepInContextMenu=false
function NEUTRINO_DebugLog(message)	
	log = io.open("debug.txt", "a")
	if message == nil then
		message = "nil"
	end
	io.output(log)
	io.write(message)
	io.write("  ")
	io.close(log)
end
if System.doesFileExist("CFG/neutrinoHDD.cfg") then
    ContextMenu_TempFile = io.open("CFG/neutrinoHDD.cfg", "r")
    NEUTRINO_Settings = (ContextMenu_TempFile:read())
    io.close(ContextMenu_TempFile)
else
    NEUTRINO_Settings = ""
end
if string.match(NEUTRINO_Settings, "(.*)1(.*)") then
	NEUTRINO_DisableArt = true
else
	NEUTRINO_DisableArt = false
end
if string.match(NEUTRINO_Settings, "(.*)2(.*)") then
	NEUTRINO_DisableStatus = true
else
	NEUTRINO_DisableStatus = false
end
if string.match(NEUTRINO_Settings, "(.*)3(.*)") then
	NEUTRINO_DisableAnimate = true
	spinSpeed = 0
	imanoSpin=0
else
	NEUTRINO_DisableAnimate = false
	spinSpeed = 0.17
end

function NEUTRINO_LoadingText(Item)
	if NEUTRINO_DisableStatus == false then
		Font.ftPrint(fontSmall, 342, plusYValue+414, 11, 512, 64, Item..". . .", Color.new(255,255,255,128))
		Screen.waitVblankStart()
		Screen.flip()
	end
end
function NEUTRINO_PrepRecache()
	NEUTRINO_CachedStatus = false
	if System.doesFileExist(xebLua_AppWorkingPath..".cache/nobg.csv") then
		System.removeFile(xebLua_AppWorkingPath..".cache/nobg.csv")
	end
	if System.doesFileExist(xebLua_AppWorkingPath..".cache/nodisc.csv") then
		System.removeFile(xebLua_AppWorkingPath..".cache/nodisc.csv")
	end
end

NEUTRINO_LoadingText(neuLang[1])
if System.doesDirectoryExist(xebLua_AppWorkingPath..".cache") then
	if System.doesDirectoryExist(xebLua_AppWorkingPath..".cache/DISC") then goto Next else
		System.createDirectory(xebLua_AppWorkingPath..".cache/DISC")
		NEUTRINO_PrepRecache()
	end
	::Next::
	if System.doesDirectoryExist(xebLua_AppWorkingPath..".cache/BG") then goto Done else
		System.createDirectory(xebLua_AppWorkingPath..".cache/BG")
		NEUTRINO_PrepRecache()
	end
else
	System.createDirectory(xebLua_AppWorkingPath..".cache")
	System.createDirectory(xebLua_AppWorkingPath..".cache/DISC")
	System.createDirectory(xebLua_AppWorkingPath..".cache/BG")
	NEUTRINO_CachedStatus = false
end
::Done::
if System.doesFileExist("CFG/favorites.csv") then
	NEUTRINO_TempFile = io.open("CFG/favorites.csv", "r")
	NEUTRINO_FavoritesList = (NEUTRINO_TempFile:read())
	io.close(NEUTRINO_TempFile)
else
	NEUTRINO_FavoritsesList = ""
end

themeInUse[-90] = Graphics.loadImage(xebLua_AppWorkingPath.."image/bgfallback.png")
themeInUse[-91] = Graphics.loadImage(xebLua_AppWorkingPath.."image/dropshadow.png")
if buttonSettings == "X" then
    themeInUse[-92] = Graphics.loadImage(xebLua_AppWorkingPath..NEUTRINO_Control1)
elseif buttonSettings == "O" then
    themeInUse[-92] = Graphics.loadImage(xebLua_AppWorkingPath..NEUTRINO_Control2)
end
themeInUse[-93] = Graphics.loadImage(xebLua_AppWorkingPath.."image/select.png")
themeInUse[-94] = Graphics.loadImage(xebLua_AppWorkingPath.."image/box.png")
themeInUse[-95] = Graphics.loadImage(xebLua_AppWorkingPath.."image/button.png")
themeInUse[-96] = Graphics.loadImage(xebLua_AppWorkingPath.."image/triangle.png")

function NEUTRINO_DrawItem(NEUTRINO_TempFavorite, NEUTRINO_TempIcon, NEUTRINO_TempX, NEUTRINO_TempY, NEUTRINO_TempFaded, NEUTRINO_TempName, NEUTRINO_TempMedia)
	if NEUTRINO_TempIcon == 0 or NEUTRINO_Scrolling == true then
		if NEUTRINO_TempMedia == "DVD" then
			NEUTRINO_SetIcon = themeInUse[126]
		elseif NEUTRINO_TempMedia == "CD" then
			NEUTRINO_SetIcon = themeInUse[125]
		end
	else
		NEUTRINO_SetIcon = themeInUse[NEUTRINO_TempIcon]
	end
	if NEUTRINO_TempFavorite == true then
		NEUTRINO_TempFavorite = "  \226\128\162  "..neuLang[2]
	else
		NEUTRINO_TempFavorite =""
	end
	if NEUTRINO_TempFaded then
		if NEUTRINO_TempName ~= "" then
			if NEUTRINO_SetIcon == themeInUse[NEUTRINO_TempIcon] then
				Graphics.drawImageExtended(NEUTRINO_SetIcon, NEUTRINO_TempX+32, plusYValue+NEUTRINO_TempY+32, 0, 0,  64, 64, 42, 42, 0, columnsFade)
			else
				Graphics.drawImage(NEUTRINO_SetIcon, NEUTRINO_TempX, plusYValue+NEUTRINO_TempY, columnsFade)
			end
			Font.ftPrint(fontSmall, NEUTRINO_TempX+70, plusYValue+NEUTRINO_TempY+32, 0, 512, 64, "PlayStation 2 "..NEUTRINO_TempMedia.."-ROM"..NEUTRINO_TempFavorite, baseColorFaded)
		end
		Font.ftPrint(fontBig, NEUTRINO_TempX+69, plusYValue+NEUTRINO_TempY+16, 0, 512, 64, NEUTRINO_TempName, baseColorFaded)
	else
		if NEUTRINO_TempName ~= "" then
			if NEUTRINO_SetIcon == themeInUse[NEUTRINO_TempIcon] then
				Graphics.drawImageExtended(NEUTRINO_SetIcon, NEUTRINO_TempX+32, plusYValue+NEUTRINO_TempY+32, 0, 0,  64, 64, 42, 42, imanoSpin, 255)
			else
				Graphics.drawImage(NEUTRINO_SetIcon, NEUTRINO_TempX, plusYValue+NEUTRINO_TempY)
			end
			Font.ftPrint(fontSmall, NEUTRINO_TempX+70, plusYValue+NEUTRINO_TempY+32, 0, 512, 64, "PlayStation 2 "..NEUTRINO_TempMedia.."-ROM"..NEUTRINO_TempFavorite, baseColorFull)
		end
		Font.ftPrint(fontBig, NEUTRINO_TempX+69, plusYValue+NEUTRINO_TempY+16, 0, 512, 64, NEUTRINO_TempName, baseColorFull)
	end
end

function NEUTRINO_DrawItemFrame(NEUTRINO_TempFavorite, NEUTRINO_TempIcon, NEUTRINO_TempX, NEUTRINO_TempY, NEUTRINO_TempFaded, NEUTRINO_TempName, NEUTRINO_TempMedia, NEUTRINO_TempTheFrame, NEUTRINO_TempTheColorA, NEUTRINO_TempTheColorB)
	if NEUTRINO_TempIcon == 0 or NEUTRINO_Scrolling == true  then
		if NEUTRINO_TempMedia == "DVD" then
			NEUTRINO_SetIcon = themeInUse[126]
		elseif NEUTRINO_TempMedia == "CD" then
			NEUTRINO_SetIcon = themeInUse[125]
		end
	else
		NEUTRINO_SetIcon = themeInUse[NEUTRINO_TempIcon]
	end
	if NEUTRINO_TempFavorite == true then
		NEUTRINO_TempFavorite = neuLang[2]
	else
		NEUTRINO_TempFavorite =""
	end
	if NEUTRINO_TempName ~= "" then
		if NEUTRINO_TempFaded == true then
			TempAlpha = NEUTRINO_SpriteGetAnimationAlphaMin(NEUTRINO_TempTheFrame)
		elseif NEUTRINO_TempFaded == false then
			TempAlpha = NEUTRINO_SpriteGetAnimationAlphaMinMax(NEUTRINO_TempTheFrame)
		elseif NEUTRINO_TempFaded == 2 then
			TempAlpha = NEUTRINO_SpriteGetAnimationAlphaMax(NEUTRINO_TempTheFrame)
		elseif NEUTRINO_TempFaded == 3 then
			TempAlpha = NEUTRINO_SpriteGetAnimationAlphaMaxFade(NEUTRINO_TempTheFrame)
		end
		if NEUTRINO_SetIcon == themeInUse[NEUTRINO_TempIcon] then
			Graphics.drawImageExtended(NEUTRINO_SetIcon, NEUTRINO_TempX+32, plusYValue+NEUTRINO_TempY+32, 0, 0,  64, 64, 42, 42, 0, TempAlpha)
		else
			Graphics.drawImage(NEUTRINO_SetIcon, NEUTRINO_TempX, plusYValue+NEUTRINO_TempY, TempAlpha)
		end
		
		Font.ftPrint(fontSmall, NEUTRINO_TempX+70, plusYValue+NEUTRINO_TempY+32, 0, 512, 64, "PlayStation 2 "..NEUTRINO_TempMedia.."-ROM"..NEUTRINO_TempFavorite, NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_TempTheFrame,NEUTRINO_TempTheColorA,NEUTRINO_TempTheColorB))
	end
	Font.ftPrint(fontBig, NEUTRINO_TempX+69, plusYValue+NEUTRINO_TempY+16, 0, 512, 64, NEUTRINO_TempName, NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_TempTheFrame,NEUTRINO_TempTheColorA,NEUTRINO_TempTheColorB))
end

function NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_TempFrame,NEUTRINO_TempColorA,NEUTRINO_TempColorB)
	NEUTRINO_TempColorAA=Color.getA(NEUTRINO_TempColorA);
	NEUTRINO_TempColorBA=Color.getA(NEUTRINO_TempColorB);
	NEUTRINO_TempColorAR=Color.getR(NEUTRINO_TempColorA);
	NEUTRINO_TempColorBR=Color.getR(NEUTRINO_TempColorB);
	NEUTRINO_TempColorAG=Color.getG(NEUTRINO_TempColorA);
	NEUTRINO_TempColorBG=Color.getG(NEUTRINO_TempColorB);
	NEUTRINO_TempColorAB=Color.getB(NEUTRINO_TempColorA);
	NEUTRINO_TempColorBB=Color.getB(NEUTRINO_TempColorB);
	NEUTRINO_TempAlphaC=NEUTRINO_TempColorAA-NEUTRINO_TempColorBA;
	NEUTRINO_TempAlphaC=NEUTRINO_TempAlphaC/4;
	NEUTRINO_TempAlphaC=NEUTRINO_TempFrame*NEUTRINO_TempAlphaC;
	NEUTRINO_TempAlphaC=NEUTRINO_TempColorBA+NEUTRINO_TempAlphaC
	NEUTRINO_TempNextColorA=XEBMathRound(NEUTRINO_TempAlphaC);
	NEUTRINO_TempAlphaC=NEUTRINO_TempColorAR-NEUTRINO_TempColorBR;
	NEUTRINO_TempAlphaC=NEUTRINO_TempAlphaC/4;
	NEUTRINO_TempAlphaC=NEUTRINO_TempFrame*NEUTRINO_TempAlphaC;
	NEUTRINO_TempAlphaC=NEUTRINO_TempColorBR+NEUTRINO_TempAlphaC
	NEUTRINO_TempNextColorR=XEBMathRound(NEUTRINO_TempAlphaC);
	NEUTRINO_TempAlphaC=NEUTRINO_TempColorAG-NEUTRINO_TempColorBG;
	NEUTRINO_TempAlphaC=NEUTRINO_TempAlphaC/4;
	NEUTRINO_TempAlphaC=NEUTRINO_TempFrame*NEUTRINO_TempAlphaC;
	NEUTRINO_TempAlphaC=NEUTRINO_TempColorBG+NEUTRINO_TempAlphaC
	NEUTRINO_TempNextColorG=XEBMathRound(NEUTRINO_TempAlphaC);
	NEUTRINO_TempAlphaC=NEUTRINO_TempColorAB-NEUTRINO_TempColorBB;
	NEUTRINO_TempAlphaC=NEUTRINO_TempAlphaC/4;
	NEUTRINO_TempAlphaC=NEUTRINO_TempFrame*NEUTRINO_TempAlphaC;
	NEUTRINO_TempAlphaC=NEUTRINO_TempColorBB+NEUTRINO_TempAlphaC
	NEUTRINO_TempNextColorB=XEBMathRound(NEUTRINO_TempAlphaC);
	NEUTRINO_TempNewColor=Color.new(NEUTRINO_TempNextColorR,NEUTRINO_TempNextColorG,NEUTRINO_TempNextColorB,NEUTRINO_TempNextColorA);
	return NEUTRINO_TempNewColor;
end

function NEUTRINO_SpriteGetAnimationAlphaMin(NEUTRINO_TempFrame)
	NEUTRINO_TempAlpha=columnsFade;
	NEUTRINO_TempAlpha=NEUTRINO_TempAlpha/4;
	NEUTRINO_TempAlpha=NEUTRINO_TempFrame*NEUTRINO_TempAlpha;
	NEUTRINO_TempAlpha=XEBMathRound(NEUTRINO_TempAlpha);
	return NEUTRINO_TempAlpha;
end

function NEUTRINO_SpriteGetAnimationAlphaMax(NEUTRINO_TempFrame)
	NEUTRINO_TempAlpha=255;
	NEUTRINO_TempAlpha=NEUTRINO_TempAlpha-columnsFade
	NEUTRINO_TempAlpha=NEUTRINO_TempAlpha/4;
	NEUTRINO_TempAlpha=NEUTRINO_TempFrame*NEUTRINO_TempAlpha;
	NEUTRINO_TempAlpha=columnsFade+NEUTRINO_TempAlpha
	NEUTRINO_TempAlpha=XEBMathRound(NEUTRINO_TempAlpha);
	return NEUTRINO_TempAlpha;
end

function NEUTRINO_SpriteGetAnimationAlphaMaxFade(NEUTRINO_TempFrame)
	NEUTRINO_TempAlpha=columnsFade;
	NEUTRINO_TempAlpha=NEUTRINO_TempAlpha-255
	NEUTRINO_TempAlpha=NEUTRINO_TempAlpha/4;
	NEUTRINO_TempAlpha=NEUTRINO_TempFrame*NEUTRINO_TempAlpha;
	NEUTRINO_TempAlpha=255+NEUTRINO_TempAlpha
	NEUTRINO_TempAlpha=XEBMathRound(NEUTRINO_TempAlpha);
	return NEUTRINO_TempAlpha;
end

function NEUTRINO_SpriteGetAnimationAlphaMinMax(NEUTRINO_TempFrame)
	if NEUTRINO_TempFrame == 4 then
		NEUTRINO_TempAlpha=255;
	else
		NEUTRINO_TempAlpha=NEUTRINO_TempFrame*64
	end
	return NEUTRINO_TempAlpha;
end
NEUTRINO_Debug = "debug"
NEUTRINO_Scrolling = false
NEUTRINO_ShowHelp = false

NEUTRINO_ColorFullZero=Color.new(Color.getR(baseColorFull),Color.getG(baseColorFull),Color.getB(baseColorFull),0)
NEUTRINO_ColorFadedZero=Color.new(Color.getR(baseColorFaded),Color.getG(baseColorFaded),Color.getB(baseColorFaded),0)

NEUTRINO_IsThereAnError = false
NEUTRINO_FoundGames=false
NEUTRINO_GamesTotal = 0
NEUTRINO_FavoritesTotal = 0
NEUTRINO_Games = {};
NEUTRINO_Favorites = {};
NEUTRINO_TitlePrefix = {};
NEUTRINO_TitlePrefix[1] = "SLES"; --3243
NEUTRINO_TitlePrefix[2] = "SLUS"; --2430
NEUTRINO_TitlePrefix[3] = "SLPM"; --717
NEUTRINO_TitlePrefix[4] = "SLPS"; --579
NEUTRINO_TitlePrefix[5] = "SCES"; --564
NEUTRINO_TitlePrefix[6] = "SCUS"; --268
NEUTRINO_TitlePrefix[7] = "SCPS"; --96
NEUTRINO_TitlePrefix[8] = "SLKA"; --65
NEUTRINO_TitlePrefix[9] = "SCAJ"; --42
NEUTRINO_TitlePrefix[10] = "SCKA"; --26
NEUTRINO_TitlePrefix[11] = "PBPX"; --13
NEUTRINO_TitlePrefix[12] = "SLAJ"; --13
NEUTRINO_TitlePrefix[13] = "SCCS"; --6
NEUTRINO_TitlePrefix[14] = "SLED"; --3
NEUTRINO_TitlePrefix[15] = "TCPS"; --3
NEUTRINO_TitlePrefix[16] = "SKAJ"; --1
NEUTRINO_TitlePrefix[17] = "SRPM";
NEUTRINO_TitlePrefix[18] = "PSXC";
NEUTRINO_TitlePrefix[19] = "MARF";

NEUTRINO_CurrentList = NEUTRINO_Games
NEUTRINO_CachedCount = 0
NEUTRINO_TitleIdCount = 0
NEUTRINO_NBgCount = 0
NEUTRINO_NDiscCount = 0
NEUTRINO_Timer = 0

function NEUTRINO_GetTitleId()
	for NEUTRINO_i = 1, #NEUTRINO_TitlePrefix do
		if string.match(NEUTRINO_Games[NEUTRINO_GamesTotal].Name, NEUTRINO_TitlePrefix[NEUTRINO_i]) then
			a, b = string.match(NEUTRINO_Games[NEUTRINO_GamesTotal].Name, "(.*)"..NEUTRINO_TitlePrefix[NEUTRINO_i].."(.*)") 
			a = string.sub(string.gsub(string.sub(b,1,8), "[%D]+", ""), 1, 5)
			NEUTRINO_Games[NEUTRINO_GamesTotal].TitleId = NEUTRINO_TitlePrefix[NEUTRINO_i].."_"..string.sub(a, 1, 3).."."..string.sub(a, 4, 5)
			NEUTRINO_TitleIdCount = NEUTRINO_TitleIdCount + 1
			break
		elseif NEUTRINO_i == #NEUTRINO_TitlePrefix then
			NEUTRINO_Games[NEUTRINO_GamesTotal].TitleId = ""
		end
	end
end

function NEUTRINO_GetFavorites(Index)
	if NEUTRINO_FavoritesList ~= "" and NEUTRINO_FavoritesList ~= nil then
		for NEUTRINO_i in string.gmatch(NEUTRINO_FavoritesList, "[^,]+") do
			NEUTRINO_i = string.gsub(NEUTRINO_i, "#c", ",")
			if NEUTRINO_i == NEUTRINO_Games[Index].Name then
				NEUTRINO_FavoritesTotal = NEUTRINO_FavoritesTotal+1
				NEUTRINO_Favorites[NEUTRINO_FavoritesTotal] = {};
				NEUTRINO_Favorites[NEUTRINO_FavoritesTotal].Name = NEUTRINO_Games[Index].Name
				NEUTRINO_Favorites[NEUTRINO_FavoritesTotal].Folder = NEUTRINO_Games[Index].Folder
				NEUTRINO_Favorites[NEUTRINO_FavoritesTotal].Extension = NEUTRINO_Games[Index].Extension
				NEUTRINO_Favorites[NEUTRINO_FavoritesTotal].Media = NEUTRINO_Games[Index].Media
				NEUTRINO_Favorites[NEUTRINO_FavoritesTotal].TitleId = NEUTRINO_Games[Index].TitleId
				NEUTRINO_Favorites[NEUTRINO_FavoritesTotal].Favorite = true
				NEUTRINO_Favorites[NEUTRINO_FavoritesTotal].Link = Index
				NEUTRINO_Games[Index].Favorite = true
				NEUTRINO_Games[Index].Link = NEUTRINO_FavoritesTotal
				break
			else
				NEUTRINO_Games[Index].Favorite = false
				NEUTRINO_Games[Index].Link = 0
			end
		end
	else

		NEUTRINO_Games[Index].Favorite = false
		NEUTRINO_Games[Index].Link = 0
	end
end

function NEUTRINO_CacheArt(Index)
	if System.doesDirectoryExist(xebLua_AppWorkingPath..".cache") and NEUTRINO_DisableArt == false then
		if NEUTRINO_CachedStatus == false then
			NEUTRINO_Debug = "chaced"
			Screen.clear()
			thmDrawBKG()
			--Font.ftPrint(fontBig, 280, plusYValue+390, 11, 620, 64, NEUTRINO_Debug, baseColorFull)
			Font.ftPrint(fontBig, 420, plusYValue+256, 11, 512, 64, neuLang[3]..NEUTRINO_CachedCount..neuLang[4], Color.new(255,255,255,128))
			Screen.flip()
			if NEUTRINO_Games[Index].TitleId ~= "" then
				new_disc = xebLua_AppWorkingPath..".cache/DISC/"..NEUTRINO_Games[Index].TitleId..".png"
				if System.doesFileExist(new_disc) then goto disc else
					if System.doesFileExist("mass:/XEBPLUS/GME/ART/"..NEUTRINO_Games[Index].TitleId.."_ICO.png") then
						old_disc = "mass:/XEBPLUS/GME/ART/"..NEUTRINO_Games[Index].TitleId.."_ICO.png"
						System.copyFile(old_disc, new_disc)
					else
						NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/nodisc.csv", "a")
						io.output(NEUTRINO_TempFile)
						io.write(NEUTRINO_Games[Index].TitleId..",")
						io.close(NEUTRINO_TempFile)
						NEUTRINO_Games[Index].Icon = "default"
					end
				end
				::disc::
				new_bg = xebLua_AppWorkingPath..".cache/BG/"..NEUTRINO_Games[Index].TitleId..".png"
				if System.doesFileExist(new_bg) then goto bg else
					if System.doesFileExist("mass:/XEBPLUS/GME/ART/"..NEUTRINO_Games[Index].TitleId.."_BG.png") then
						old_bg = "mass:/XEBPLUS/GME/ART/"..NEUTRINO_Games[Index].TitleId.."_BG.png"
						System.copyFile(old_bg, new_bg)
					else
						NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/nobg.csv", "a")
						io.output(NEUTRINO_TempFile)
						io.write(NEUTRINO_Games[Index].TitleId..",")
						io.close(NEUTRINO_TempFile)
						NEUTRINO_Games[Index].BackGround = "default"
					end
				end
				::bg::
			end
			NEUTRINO_CachedCount = NEUTRINO_CachedCount + 1
			
		elseif NEUTRINO_CachedStatus == true then
			NEUTRINO_Debug = "chaced"
			for NEUTRINO_i in string.gmatch(NEUTRINO_NoDisc, "[^,]+") do
				if NEUTRINO_i == NEUTRINO_Games[Index].TitleId then
					NEUTRINO_Games[Index].Icon = "default"
					NEUTRINO_NoDisc = string.sub(NEUTRINO_NoDisc, 13)
					break
				end
			end
			for NEUTRINO_i in string.gmatch(NEUTRINO_NoBg, "[^,]+") do
				if NEUTRINO_i == NEUTRINO_Games[Index].TitleId then
					NEUTRINO_Games[Index].BackGround = "default"
					NEUTRINO_NoBg = string.sub(NEUTRINO_NoBg, 13)
					break
				end
			end
		end
		
		if NEUTRINO_Games[Index].TitleId == "" then
				NEUTRINO_Games[Index].Icon = "default"
				NEUTRINO_Games[Index].BackGround = "default"
		else
			if NEUTRINO_Games[Index].Icon ~= "default" then
				NEUTRINO_Games[Index].Icon = xebLua_AppWorkingPath..".cache/DISC/"..NEUTRINO_Games[Index].TitleId..".png"
			else
				NEUTRINO_NDiscCount = NEUTRINO_NDiscCount + 1
			end
			if NEUTRINO_Games[Index].BackGround ~= "default" then
				NEUTRINO_Games[Index].BackGround = xebLua_AppWorkingPath..".cache/BG/"..NEUTRINO_Games[Index].TitleId..".png"
			else
				NEUTRINO_NBgCount = NEUTRINO_NBgCount + 1
			end
		end
	elseif NEUTRINO_DisableArt == true then
		NEUTRINO_Games[Index].Icon = "default"
		NEUTRINO_Games[Index].BackGround = "default"
	else
		Screen.clear()
		thmDrawBKG()
		Font.ftPrint(fontBig, 352, plusYValue+256, 11, 612, 64, "Error: cannot find cache folder!", Color.new(255,255,255,128))
		Screen.waitVblankStart()
		Screen.flip()
		NEUTRINO_Games[Index].Icon = "default"
		NEUTRINO_Games[Index].BackGround = "default"
	end
	
	if NEUTRINO_Games[Index].Link > 0 then
		NEUTRINO_Favorites[NEUTRINO_Games[Index].Link].Icon = NEUTRINO_Games[Index].Icon
		NEUTRINO_Favorites[NEUTRINO_Games[Index].Link].BackGround = NEUTRINO_Games[Index].BackGround
	end
end
--"mass:/DVD/" for hardware, System.currentDirectory().."DVD/" for emulation
NEUTRINO_LocationPrefix="mass:/DVD/"
--NEUTRINO_LocationPrefix=System.currentDirectory().."DVD/"

if System.doesDirectoryExist(NEUTRINO_LocationPrefix) then
	NEUTRINO_ListDirectory = System.listDirectory(NEUTRINO_LocationPrefix)
	for NEUTRINO_i = 1, #NEUTRINO_ListDirectory do
	--not NEUTRINO_ListDirectory[NEUTRINO_i].directory and
		if string.sub(NEUTRINO_ListDirectory[NEUTRINO_i].name,string.len(NEUTRINO_ListDirectory[NEUTRINO_i].name)-3,string.len(NEUTRINO_ListDirectory[NEUTRINO_i].name)) == ".iso" or string.sub(NEUTRINO_ListDirectory[NEUTRINO_i].name,string.len(NEUTRINO_ListDirectory[NEUTRINO_i].name)-3,string.len(NEUTRINO_ListDirectory[NEUTRINO_i].name)) == ".ISO" then
			NEUTRINO_GamesTotal = NEUTRINO_GamesTotal+1
			NEUTRINO_Games[NEUTRINO_GamesTotal] = {};
			NEUTRINO_Games[NEUTRINO_GamesTotal].Name = string.sub(NEUTRINO_ListDirectory[NEUTRINO_i].name,1,string.len(NEUTRINO_ListDirectory[NEUTRINO_i].name)-4);
			NEUTRINO_Games[NEUTRINO_GamesTotal].Folder = "DVD";
			NEUTRINO_Games[NEUTRINO_GamesTotal].Extension = "iso";
			NEUTRINO_Games[NEUTRINO_GamesTotal].Media = "dvd";
			NEUTRINO_GetTitleId()
		end
	end
end

--"mass:/CD/" for hardware, System.currentDirectory().."CD/" for emulation
NEUTRINO_LocationPrefix="mass:/CD/"
--NEUTRINO_LocationPrefix=System.currentDirectory().."CD/"

if System.doesDirectoryExist(NEUTRINO_LocationPrefix) then
	NEUTRINO_ListDirectory = System.listDirectory(NEUTRINO_LocationPrefix)
	for NEUTRINO_i = 1, #NEUTRINO_ListDirectory do
		if string.sub(NEUTRINO_ListDirectory[NEUTRINO_i].name,string.len(NEUTRINO_ListDirectory[NEUTRINO_i].name)-3,string.len(NEUTRINO_ListDirectory[NEUTRINO_i].name)) == ".iso" or string.sub(NEUTRINO_ListDirectory[NEUTRINO_i].name,string.len(NEUTRINO_ListDirectory[NEUTRINO_i].name)-3,string.len(NEUTRINO_ListDirectory[NEUTRINO_i].name)) == ".ISO" then
			NEUTRINO_GamesTotal = NEUTRINO_GamesTotal+1
			NEUTRINO_Games[NEUTRINO_GamesTotal] = {};
			NEUTRINO_Games[NEUTRINO_GamesTotal].Name = string.sub(NEUTRINO_ListDirectory[NEUTRINO_i].name,1,string.len(NEUTRINO_ListDirectory[NEUTRINO_i].name)-4);
			NEUTRINO_Games[NEUTRINO_GamesTotal].Folder = "CD";
			NEUTRINO_Games[NEUTRINO_GamesTotal].Extension = "iso";
			NEUTRINO_Games[NEUTRINO_GamesTotal].Media = "cd";
			NEUTRINO_GetTitleId()
		end
	end
end

function NEUTRINO_LoadIcon(firstOffest, lastOffset)
	for NEUTRINO_i = NEUTRINO_SelectedItem+firstOffest, NEUTRINO_SelectedItem+lastOffset do
		
		if NEUTRINO_CurrentList[NEUTRINO_i].Icon ~= "default"and NEUTRINO_i >= 1 and NEUTRINO_i <= NEUTRINO_CurrentTotal() then
			if themeInUse[NEUTRINO_CurrentList[NEUTRINO_i].IconSlot] > 0 then
				Graphics.freeImage(themeInUse[NEUTRINO_CurrentList[NEUTRINO_i].IconSlot])
				themeInUse[NEUTRINO_CurrentList[NEUTRINO_i].IconSlot] = 0
			end
			themeInUse[NEUTRINO_CurrentList[NEUTRINO_i].IconSlot] = Graphics.loadImage(NEUTRINO_CurrentList[NEUTRINO_i].Icon)
		end
	end
end

function NEUTRINO_CreateConfig(createGames, createArt)
	if createGames == true then
		NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/lasttotal.cfg", "w")
		io.output(NEUTRINO_TempFile) 
		io.write(NEUTRINO_GamesTotal)
		io.close(NEUTRINO_TempFile)
		NEUTRINO_SelectedItem = 1
	end
	if createArt == true then
		NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/lastart.cfg", "w")
		io.output(NEUTRINO_TempFile) 
		io.write(NEUTRINO_ArtTotal)
		io.close(NEUTRINO_TempFile)
	end
end
function NEUTRINO_CurrentTotal()
	if NEUTRINO_CurrentList == NEUTRINO_Games then
		return NEUTRINO_GamesTotal
	elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
		return NEUTRINO_FavoritesTotal
	end
end

function NEUTRINO_InitList()
	for NEUTRINO_i = -7, 0 do
		NEUTRINO_CurrentList[NEUTRINO_i] = {};
		NEUTRINO_CurrentList[NEUTRINO_i].Name = "";
		NEUTRINO_CurrentList[NEUTRINO_i].Folder = "";
		NEUTRINO_CurrentList[NEUTRINO_i].Extension = "";
		NEUTRINO_CurrentList[NEUTRINO_i].Media = "";
	end
	for NEUTRINO_i = NEUTRINO_CurrentTotal()+1, NEUTRINO_CurrentTotal()+7 do
		NEUTRINO_CurrentList[NEUTRINO_i] = {};
		NEUTRINO_CurrentList[NEUTRINO_i].Name = "";
		NEUTRINO_CurrentList[NEUTRINO_i].Folder = "";
		NEUTRINO_CurrentList[NEUTRINO_i].Extension = "";
		NEUTRINO_CurrentList[NEUTRINO_i].Media = "";
	end

	NEUTRINO_CurrentSlot = -100
	for NEUTRINO_i = 1, NEUTRINO_CurrentTotal() do
		NEUTRINO_CurrentSlot = NEUTRINO_CurrentSlot - 1 
		if NEUTRINO_CurrentSlot == -111 then
			NEUTRINO_CurrentSlot = -100
		end
		
		if NEUTRINO_CurrentList[NEUTRINO_i].Icon == "default" then
			NEUTRINO_CurrentList[NEUTRINO_i].IconSlot = 0
		else
			NEUTRINO_CurrentList[NEUTRINO_i].IconSlot = NEUTRINO_CurrentSlot
			themeInUse[NEUTRINO_CurrentList[NEUTRINO_i].IconSlot] = 0
		end
	end
	NEUTRINO_OldItem = NEUTRINO_SelectedItem
	NEUTRINO_LoadIcon(-6, 5)
end

if NEUTRINO_CurrentTotal() == 0 then
	NEUTRINO_IsThereAnError = true
end

function NEUTRINO_ReadNoArt()
	if System.doesFileExist(xebLua_AppWorkingPath..".cache/nobg.csv") then
		NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/nobg.csv")
		NEUTRINO_NoBg = (NEUTRINO_TempFile:read())
		io.close(NEUTRINO_TempFile)
	else
		NEUTRINO_NoBg = ""
	end
	if System.doesFileExist(xebLua_AppWorkingPath..".cache/nodisc.csv") then
		NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/nodisc.csv")
		NEUTRINO_NoDisc = (NEUTRINO_TempFile:read())
		io.close(NEUTRINO_TempFile)
	else
		NEUTRINO_NoDisc = ""
	end
end

if not NEUTRINO_IsThereAnError then
	table.sort(NEUTRINO_Games, function (NEUTRINO_TempTabA, NEUTRINO_TempTabB) return NEUTRINO_TempTabA.Name < NEUTRINO_TempTabB.Name end)
	NEUTRINO_LoadingText(neuLang[46])
	NEUTRINO_DiscFolder = System.listDirectory(xebLua_AppWorkingPath..".cache/DISC/")
	NEUTRINO_BgFolder = System.listDirectory(xebLua_AppWorkingPath..".cache/BG/")
	NEUTRINO_ArtTotal = #NEUTRINO_DiscFolder + #NEUTRINO_BgFolder
	if System.doesFileExist(xebLua_AppWorkingPath..".cache/lasttotal.cfg") and System.doesFileExist(xebLua_AppWorkingPath..".cache/lastgame.cfg") then
		NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/lasttotal.cfg", "r")
		tempTotal = tonumber(NEUTRINO_TempFile:read())
		io.close(NEUTRINO_TempFile)
		if NEUTRINO_GamesTotal == tempTotal then
			NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/lastgame.cfg", "r")
			NEUTRINO_SelectedItem = tonumber(NEUTRINO_TempFile:read())
			io.close(NEUTRINO_TempFile)
			if System.doesFileExist(xebLua_AppWorkingPath..".cache/lastart.cfg") then
				NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/lastart.cfg", "r")
				tempTotal = tonumber(NEUTRINO_TempFile:read())
				io.close(NEUTRINO_TempFile)
				if NEUTRINO_ArtTotal == tempTotal then
					NEUTRINO_CachedStatus = true
				else
					NEUTRINO_CreateConfig(false, true)
					NEUTRINO_PrepRecache()
				end
			else
				NEUTRINO_CreateConfig(false, true)
				NEUTRINO_PrepRecache()
			end
		else
			NEUTRINO_CreateConfig(true, true)
			NEUTRINO_PrepRecache()
		end
	else
		NEUTRINO_CreateConfig(true, true)
		NEUTRINO_PrepRecache()
	end
	if NEUTRINO_CachedStatus == true then
		NEUTRINO_ReadNoArt()
	end
	for	NEUTRINO_i = 1, NEUTRINO_GamesTotal do
		NEUTRINO_GetFavorites(NEUTRINO_i)
		NEUTRINO_CacheArt(NEUTRINO_i)
	end
	NEUTRINO_CurrentList = NEUTRINO_Games
	NEUTRINO_LinkedList = NEUTRINO_Favorites
	if #NEUTRINO_DiscFolder + NEUTRINO_NDiscCount > NEUTRINO_TitleIdCount then
		for NEUTRINO_n = 1, #NEUTRINO_DiscFolder do
			Screen.clear()
			thmDrawBKG()
			Font.ftPrint(fontBig, 420, plusYValue+200, 11, 512, 64, neuLang[5], Color.new(255,255,255,128))
			Screen.flip()
			NEUTRINO_TempFile = NEUTRINO_DiscFolder[NEUTRINO_n].name
			titleMatch = false
			for NEUTRINO_i = 1, NEUTRINO_GamesTotal do
				if NEUTRINO_Games[NEUTRINO_i].TitleId == string.sub(NEUTRINO_TempFile, 1, string.len(NEUTRINO_TempFile)-4) then
				titleMatch = true
				end
			end
			if titleMatch == false then
				System.removeFile(xebLua_AppWorkingPath..".cache/DISC/"..NEUTRINO_TempFile)
				NEUTRINO_ArtTotal = NEUTRINO_ArtTotal - 1
				if NEUTRINO_ArtTotal == NEUTRINO_TitleIdCount then
					break
				end
			end
		end
		NEUTRINO_CreateConfig(false, true)
		NEUTRINO_LoadingText(neuLang[6])
	end
	if #NEUTRINO_BgFolder + NEUTRINO_NBgCount > NEUTRINO_TitleIdCount then
		for NEUTRINO_n = 1, #NEUTRINO_BgFolder do
			Screen.clear()
			thmDrawBKG()
			Font.ftPrint(fontBig, 420, plusYValue+200, 11, 512, 64, neuLang[45], Color.new(255,255,255,128))
			Screen.flip()
			NEUTRINO_TempFile = NEUTRINO_BgFolder[NEUTRINO_n].name
			titleMatch = false
			for NEUTRINO_i = 1, NEUTRINO_GamesTotal do
				if NEUTRINO_Games[NEUTRINO_i].TitleId == string.sub(NEUTRINO_TempFile, 1, string.len(NEUTRINO_TempFile)-4) then 
				titleMatch = true
				end
			end
			if titleMatch == false then
				System.removeFile(xebLua_AppWorkingPath..".cache/BG/"..NEUTRINO_TempFile)
				NEUTRINO_ArtTotal = NEUTRINO_ArtTotal - 1
				if NEUTRINO_ArtTotal == NEUTRINO_TitleIdCount then
					break
				end
			end
		end
		NEUTRINO_CreateConfig(false, true)
		NEUTRINO_LoadingText(neuLang[6])
	end
	NEUTRINO_InitList()
end

for NEUTRINO_i = 1, 3 do
	pad = Pads.get()
	Screen.clear()
	if backgroundFilter then
		Graphics.drawImageExtended(themeInUse[-1], 352, plusYValue+240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
	else
		Graphics.drawImage(themeInUse[-1], 0, plusYValue+0)
	end
	thmDrawBKG()
	DrawSubMenu(actualCat,actualOption,true)
	if NEUTRINO_IsThereAnError then
		Font.ftPrint(fontBig, 152, plusYValue+222, 0, 512, 64, xebLang[35], NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_i,baseColorFull,NEUTRINO_ColorFullZero))
		Font.ftPrint(fontSmall, 153, plusYValue+243, 0, 512, 64, neuLang[35], NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_i,baseColorFull,NEUTRINO_ColorFullZero))
	else
		--NEUTRINO_DebugLog("1")
		NEUTRINO_ItemPosition = -5
		for NEUTRINO_iB = NEUTRINO_SelectedItem-6, NEUTRINO_SelectedItem+5 do
			NEUTRINO_iB_Y = NEUTRINO_ItemPosition*71
			if NEUTRINO_iB == NEUTRINO_SelectedItem then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, 206, false, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder, NEUTRINO_i, baseColorFull, NEUTRINO_ColorFullZero)
			else
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, NEUTRINO_iB_Y+135, true, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder, NEUTRINO_i, baseColorFaded, NEUTRINO_ColorFadedZero)
			end
			NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+1
		end
	end
	NEUTRINO_DebugLog("5")
	spinDisc()
	thmDrawBKGOL()
	Screen.waitVblankStart()
	oldpad = pad;
	Screen.flip()
	NEUTRINO_DebugLog("6")
end

function NEUTRINO_UpdateFavorites()
	if System.doesFileExist("CFG/favorites.csv") then
		NEUTRINO_TempFile = io.open("CFG/favorites.csv", "r")
		NEUTRINO_FavoritesList = (NEUTRINO_TempFile:read())
		io.close(NEUTRINO_TempFile)
	else
		NEUTRINO_FavoritesList = ""
	end
	NEUTRINO_NewFavorites = ""
	RemoveFavorite = false
	for NEUTRINO_i in string.gmatch(NEUTRINO_FavoritesList, "[^,]+") do
		if NEUTRINO_i ~= string.gsub(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name, ",", "#c") then
			NEUTRINO_NewFavorites = NEUTRINO_NewFavorites..NEUTRINO_i..","
		else
			RemoveFavorite = true
		end
	end
	if RemoveFavorite == true then 
		NEUTRINO_LoadingText(neuLang[7])
		if NEUTRINO_NewFavorites == "" then 
			System.removeFile("CFG/favorites.csv")
		else
			NEUTRINO_TempFile = io.open("CFG/favorites.csv", "w")
			io.output(NEUTRINO_TempFile)
			io.write(NEUTRINO_NewFavorites)
			io.close(NEUTRINO_TempFile)
		end
		NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Favorite = false
		NEUTRINO_LinkedList[NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Link].Favorite = false
		NEUTRINO_LinkedList[NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Link].Link = 0 
		if NEUTRINO_CurrentList == NEUTRINO_Favorites then
			table.remove(NEUTRINO_Favorites, NEUTRINO_SelectedItem)
			if NEUTRINO_SelectedItem == NEUTRINO_FavoritesTotal then
				NEUTRINO_SelectedItem = NEUTRINO_SelectedItem - 1
			end
			NEUTRINO_Timer = 0
		else
			table.remove(NEUTRINO_Favorites, NEUTRINO_Games[NEUTRINO_SelectedItem].Link)
		end
		NEUTRINO_FavoritesTotal = NEUTRINO_FavoritesTotal - 1
		if NEUTRINO_FavoritesTotal > 0 then
			for NEUTRINO_i = NEUTRINO_SelectedItem,  NEUTRINO_GamesTotal do
				if NEUTRINO_Games[NEUTRINO_i].Link > 0 then
					NEUTRINO_Games[NEUTRINO_i].Link = NEUTRINO_Games[NEUTRINO_i].Link - 1
				end 
			end
		end
	else
		NEUTRINO_LoadingText(neuLang[8])
		NEUTRINO_TempFile = io.open("CFG/favorites.csv", "a")
		io.output(NEUTRINO_TempFile)
		io.write(string.gsub(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name, ",", "#c")..",")
		io.close(NEUTRINO_TempFile)
		
		NEUTRINO_NewFavorite = {};
		NEUTRINO_NewFavorite.Name = NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name
		NEUTRINO_NewFavorite.Folder = NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder
		NEUTRINO_NewFavorite.Extension = NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Extension
		NEUTRINO_NewFavorite.Media = NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Media
		NEUTRINO_NewFavorite.TitleId = NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId
		NEUTRINO_NewFavorite.Icon = NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Icon
		NEUTRINO_NewFavorite.BackGround = NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround
		NEUTRINO_NewFavorite.Favorite = true
		NEUTRINO_NewFavorite.Link = NEUTRINO_SelectedItem
		for NEUTRINO_i = 1, NEUTRINO_FavoritesTotal do
			if NEUTRINO_NewFavorite.Name < NEUTRINO_Favorites[NEUTRINO_i].Name then
				table.insert(NEUTRINO_Favorites, NEUTRINO_i, NEUTRINO_NewFavorite)
				NEUTRINO_Games[NEUTRINO_SelectedItem].Link = NEUTRINO_i
				for NEUTRINO_f = NEUTRINO_i+1, NEUTRINO_FavoritesTotal do
					NEUTRINO_Games[NEUTRINO_Favorites[NEUTRINO_f].Link].Link = NEUTRINO_Games[NEUTRINO_Favorites[NEUTRINO_f].Link].Link + 1
				end
				break
			elseif NEUTRINO_i == NEUTRINO_FavoritesTotal then
				table.insert(NEUTRINO_Favorites, NEUTRINO_i + 1, NEUTRINO_NewFavorite)
				NEUTRINO_Games[NEUTRINO_SelectedItem].Link = NEUTRINO_i + 1
			end
		end
		if NEUTRINO_FavoritesTotal == 0 then
			table.insert(NEUTRINO_Favorites, 1, NEUTRINO_NewFavorite)
			NEUTRINO_Games[NEUTRINO_SelectedItem].Link = 1
		end
		NEUTRINO_Games[NEUTRINO_SelectedItem].Favorite = true
		NEUTRINO_FavoritesTotal = NEUTRINO_FavoritesTotal + 1
		if NEUTRINO_CurrentList == NEUTRINO_Favorites then
			NEUTRINO_LoadingText(neuLang[13])
			NEUTRINO_LoadIcon(-6, 5)
		end
	end
	NEUTRINO_FavoritesSelected = 1
end

NEUTRINO_HoldingUp=99
NEUTRINO_HoldingUpDash=0
NEUTRINO_HoldingDown=99
NEUTRINO_HoldingDownDash=0

function NEUTRINO_AnimateUp(speed)
	if NEUTRINO_Scrolling == false then
		NEUTRINO_LoadIcon(-7, -7)
	end
	spinDisc()
	thmDrawBKGOL()
	Screen.waitVblankStart()
	oldpad = pad;
	Screen.flip()
	for NEUTRINO_Move = 1, 3 do
		pad = Pads.get()
		Screen.clear()
		if backgroundFilter then
			Graphics.drawImageExtended(themeInUse[-1], 352, plusYValue+240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
		else
			Graphics.drawImage(themeInUse[-1], 0, plusYValue+0)
		end
		thmDrawBKG()
		Graphics.drawImage(themeInUse[-94], NEUTRINO_BoxPos, plusYValue+22)
		if NEUTRINO_CurrentList == NEUTRINO_Games then
			Font.ftPrint(fontMid, NEUTRINO_HeaderPos, plusYValue+45, 0, 400, 64, neuLang[10].." - "..NEUTRINO_SelectedItem..neuLang[9]..NEUTRINO_GamesTotal, baseColorFull)
		elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
			Font.ftPrint(fontXET, 495, plusYValue+45, 0, 400, 64, neuLang[11]..NEUTRINO_SelectedItem..neuLang[9]..NEUTRINO_FavoritesTotal, baseColorFull)
		end
		Graphics.drawImage(themeInUse[-95], 500, plusYValue+400)
		Graphics.drawImage(themeInUse[-93], 506, plusYValue+400)
		Font.ftPrint(fontSmall, 543, plusYValue+405, 0, 400, 64, neuLang[12], baseColorFull)
		DrawSubMenu(actualCat,actualOption,true)
		NEUTRINO_PositionUp = XEBMathRound(NEUTRINO_Move * 17.75)
		NEUTRINO_ItemPosition = -5
		for NEUTRINO_iB = NEUTRINO_SelectedItem-6, NEUTRINO_SelectedItem+5 do
			NEUTRINO_iB_Y = NEUTRINO_ItemPosition*71
			if NEUTRINO_iB == NEUTRINO_SelectedItem then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, NEUTRINO_iB_Y+135+NEUTRINO_PositionUp, 3, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder, NEUTRINO_Move, baseColorFaded, baseColorFull)
			elseif NEUTRINO_iB == NEUTRINO_SelectedItem-1 then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, NEUTRINO_iB_Y+135+NEUTRINO_PositionUp, 2, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder, NEUTRINO_Move, baseColorFull, baseColorFaded)
			else
				NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, NEUTRINO_iB_Y+135+NEUTRINO_PositionUp, true, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder)
			end
			NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+speed
		end
		if not Pads.check(pad, PAD_UP) then
			NEUTRINO_HoldingUp=99
			NEUTRINO_HoldingUpDash=0
		end
		if NEUTRINO_Move ~= 3 then
			spinDisc()
			thmDrawBKGOL()
			Screen.waitVblankStart()
			oldpad = pad;
			Screen.flip()
		end
	end
end
function NEUTRINO_AnimateDown(speed)
	if NEUTRINO_Scrolling == false then
		NEUTRINO_LoadIcon(6, 6)
	end
	spinDisc()
	thmDrawBKGOL()
	Screen.waitVblankStart()
	oldpad = pad;
	Screen.flip()
	for NEUTRINO_Move = 1, 3 do
		NEUTRINO_MoveBack=4-NEUTRINO_Move
		pad = Pads.get()
		Screen.clear()
		if backgroundFilter then
			Graphics.drawImageExtended(themeInUse[-1], 352, plusYValue+240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
		else
			Graphics.drawImage(themeInUse[-1], 0, plusYValue+0)
		end
		Graphics.drawImage(themeInUse[-94], NEUTRINO_BoxPos, plusYValue+22)
		if NEUTRINO_CurrentList == NEUTRINO_Games then
			Font.ftPrint(fontMid, NEUTRINO_HeaderPos, plusYValue+45, 0, 400, 64, neuLang[10].." - "..NEUTRINO_SelectedItem..neuLang[9]..NEUTRINO_GamesTotal, baseColorFull)
		elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
			Font.ftPrint(fontXET, 495, plusYValue+45, 0, 400, 64, neuLang[11]..NEUTRINO_SelectedItem..neuLang[9]..NEUTRINO_FavoritesTotal, baseColorFull)
		end
		Graphics.drawImage(themeInUse[-95], 500, plusYValue+400)
		Graphics.drawImage(themeInUse[-93], 506, plusYValue+400)
		Font.ftPrint(fontSmall, 543, plusYValue+405, 0, 400, 64, neuLang[12], baseColorFull)
		thmDrawBKG()
		DrawSubMenu(actualCat,actualOption,true)
		NEUTRINO_PositionDown = XEBMathRound(NEUTRINO_Move * 17.75)
		NEUTRINO_ItemPosition = -5
		for NEUTRINO_iB = NEUTRINO_SelectedItem-6, NEUTRINO_SelectedItem+5 do
			NEUTRINO_iB_Y = NEUTRINO_ItemPosition*71
			if NEUTRINO_iB == NEUTRINO_SelectedItem then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, NEUTRINO_iB_Y+135-NEUTRINO_PositionDown, 2, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder, NEUTRINO_MoveBack, baseColorFull, baseColorFaded)
			elseif NEUTRINO_iB == NEUTRINO_SelectedItem+1 then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, NEUTRINO_iB_Y+135-NEUTRINO_PositionDown, 3, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder, NEUTRINO_MoveBack, baseColorFaded, baseColorFull)
			else
				NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, NEUTRINO_iB_Y+135-NEUTRINO_PositionDown, true, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder)
			end
			NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+speed
			
		end
		if not Pads.check(oldpad, PAD_DOWN) then
			NEUTRINO_HoldingDown=99
			NEUTRINO_HoldingDownDash=0
		end
		if not Pads.check(pad, PAD_DOWN) then
			NEUTRINO_HoldingDown=99
			NEUTRINO_HoldingDownDash=0
		end
		if NEUTRINO_Move ~= 3 then
			spinDisc()
			thmDrawBKGOL()
			Screen.waitVblankStart()
			oldpad = pad;
			Screen.flip()
		end
	end
end
function NEUTRINO_SaveLast()
	NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/lastgame.cfg", "w")
	io.output(NEUTRINO_TempFile)
	if NEUTRINO_CurrentList == NEUTRINO_Games then
		io.write(NEUTRINO_SelectedItem)
	elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
		io.write(NEUTRINO_Favorites[NEUTRINO_SelectedItem].Link)
	end
	io.close(NEUTRINO_TempFile)
end

function NEUTRINO_DrawUnderlay()
	if  NEUTRINO_Timer >= 9 and NEUTRINO_Scrolling == false then
		if NEUTRINO_Timer >= 9 then 
			NEUTRINO_Timer = 9
		end
		if themeInUse[-90] > 0 and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround ~= "default" then
			Graphics.drawImageExtended(themeInUse[-90], 352, plusYValue+240, 0, 0, 640, 480, 704, 480, 0, 255)
			Graphics.drawImage(themeInUse[-91], 152, 186)
		end
	end
	
	NEUTRINO_ItemPosition = -5
	for NEUTRINO_iB = NEUTRINO_SelectedItem-6, NEUTRINO_SelectedItem+5 do
		NEUTRINO_iB_Y = NEUTRINO_ItemPosition*71
		if NEUTRINO_iB == NEUTRINO_SelectedItem then
			NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, 206, false, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder)
		else
			NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, NEUTRINO_iB_Y+135, true, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder)
		end
		--Font.ftPrint(fontBig, 280, plusYValue+390, 11, 620, 64, NEUTRINO_Debug, baseColorFull)
		NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+1
	end
	
	Graphics.drawImage(themeInUse[-94], NEUTRINO_BoxPos, plusYValue+22)
	if NEUTRINO_CurrentList == NEUTRINO_Games then
		Font.ftPrint(fontMid, NEUTRINO_HeaderPos, plusYValue+45, 0, 400, 64, neuLang[10].." - "..NEUTRINO_SelectedItem..neuLang[9]..NEUTRINO_GamesTotal, baseColorFull)
	elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
		Font.ftPrint(fontXET, 495, plusYValue+45, 0, 400, 64, neuLang[11]..NEUTRINO_SelectedItem..neuLang[9]..NEUTRINO_FavoritesTotal, baseColorFull)
	end
	Graphics.drawImage(themeInUse[-95], 500, plusYValue+400)
	Graphics.drawImage(themeInUse[-93], 506, plusYValue+400)
	Font.ftPrint(fontSmall, 543, plusYValue+405, 0, 400, 64, neuLang[12], baseColorFull)
end

function NEUTRINO_DrawMenu()
	if backgroundFilter then
		Graphics.drawImageExtended(themeInUse[-1], 352, plusYValue+240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
	else
		Graphics.drawImage(themeInUse[-1], 0, plusYValue+0)
	end
	thmDrawBKG()
	if NEUTRINO_IsThereAnError == false then
		if NEUTRINO_SelectedItem == NEUTRINO_OldItem then
			NEUTRINO_Timer = NEUTRINO_Timer+1
		else
			NEUTRINO_Timer = 0
			if themeInUse[-90] > 0 and NEUTRINO_CurrentList[NEUTRINO_OldItem].BackGround ~= "default" then
				Graphics.freeImage(themeInUse[-90])
				themeInUse[-90] = 0
				if NEUTRINO_DisableAnimate == false then
					spinSpeed = 0.17
				end
			end
		end
	
		NEUTRINO_DrawUnderlay()
		
		while NEUTRINO_ShowHelp == true do
			pad = Pads.get()
			NEUTRINO_DrawUnderlay()
			Graphics.drawImageExtended(themeInUse[-92], 352, plusYValue+240, 0, 0, 640, 480, 704, 480, 0, 255)
			Screen.waitVblankStart()
			Screen.flip()
			if Pads.check(pad, PAD_CANCEL) and not Pads.check(oldpad, PAD_CANCEL) or Pads.check(pad, PAD_SELECT) and not Pads.check(oldpad, PAD_SELECT) then
				NEUTRINO_ShowHelp = false
			end
			oldpad = pad;
		end
		
		if NEUTRINO_Scrolling == false then
			if NEUTRINO_Timer == 7 and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround ~= "default" then
				NEUTRINO_LoadingText(neuLang[13])
				themeInUse[-90] = Graphics.loadImage(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround)
				if NEUTRINO_DisableAnimate == false then
					spinSpeed = 0.34
				end
			end
			NEUTRINO_OldItem=NEUTRINO_SelectedItem
		end
	end
end

function ContextMenu_ReadSettings(Settings)
	if string.match(Settings, "(.*)logo(.*)") then
		ContextMenu_Logo = " -logo"
		ContextMenu[3].Name = "\194\172  "..neuLang[14]
	else
		ContextMenu_Logo = ""
		ContextMenu[3].Name = "     "..neuLang[14]
	end
	if string.match(Settings, "(.*)dbc(.*)") then
		ContextMenu_Colors = " -dbc"
		ContextMenu[4].Name = "\194\172  "..neuLang[15]
	else
		ContextMenu_Colors = ""
		ContextMenu[4].Name = "     "..neuLang[15]
	end
	if string.match(Settings, "(.*)1(.*)") then
		ContextMenu_Accurate = "1"
		ContextMenu[5].Name = "\194\172  "..neuLang[16]
	else
		ContextMenu_Accurate = ""
		ContextMenu[5].Name = "     "..neuLang[16]
	end
	if string.match(Settings, "(.*)2(.*)") then
		ContextMenu_Sync = "2"
		ContextMenu[6].Name = "\194\172  "..neuLang[17]
	else
		ContextMenu_Sync = ""
		ContextMenu[6].Name = "     "..neuLang[17]
	end
	if string.match(Settings, "(.*)3(.*)") then
		ContextMenu_Unhook = "3"
		ContextMenu[7].Name = "\194\172  "..neuLang[18]
	else
		ContextMenu_Unhook = ""
		ContextMenu[7].Name = "     "..neuLang[18]
	end
	if string.match(Settings, "(.*)5(.*)") then
		ContextMenu_Emulate = "5"
		ContextMenu[8].Name = "\194\172  "..neuLang[19]
	else
		ContextMenu_Emulate = ""
		ContextMenu[8].Name = "     "..neuLang[19]
	end
end
ContextMenu_FirstRun = true
function NEUTRINO_ContextMenu()
	pad = Pads.get()
	if ContextMenu_FirstRun == true then
		ContextMenu_HasMoved = 0
		ContextMenu_SelectedItem = 1
		ContextMenu_UpdateFavorties = false
		ContextMenu_ReloadArt = false
		ContextMenu={};
		ContextMenu[1] = {};
		ContextMenu[2] = {};
		ContextMenu[3] = {};
		ContextMenu[4] = {};
		ContextMenu[5] = {};
		ContextMenu[6] = {};
		ContextMenu[7] = {};
		ContextMenu[8] = {};
		ContextMenu[9] = {};
		ContextMenu[1].Description = neuLang[20]
		ContextMenu[2].Description = neuLang[21]
		ContextMenu[3].Description = neuLang[22]
		ContextMenu[4].Description = neuLang[23]
		ContextMenu[5].Description = neuLang[24]
		ContextMenu[6].Description = neuLang[25]
		ContextMenu[7].Description = neuLang[26]
		ContextMenu[8].Description = neuLang[27] 
		ContextMenu[9].Description = neuLang[28]
		if NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId == "" or NEUTRINO_CurrentList == NEUTRINO_Favorites then
			ContextMenu_AllItems = 8
		else
			ContextMenu_AllItems = 9
		end
		
		if System.doesFileExist("mass:/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder.."/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg") then
			NEUTRINO_TempFile = io.open("mass:/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder.."/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg", r)
			ContextMenu_LocalSettings = (NEUTRINO_TempFile:read())
			io.close(NEUTRINO_TempFile)
		else
			ContextMenu_LocalSettings = 0
		end
		if System.doesFileExist("CFG/neutrinoLaunchOptions.cfg") then
			NEUTRINO_TempFile = io.open("CFG/neutrinoLaunchOptions.cfg", "r")
			ContextMenu_GlobalSettings = (NEUTRINO_TempFile:read())
			io.close(NEUTRINO_TempFile)
		else
			ContextMenu_GlobalSettings = ""
		end
		if	NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Favorite == true then
			ContextMenu[1].Name = neuLang[29]
		else
			ContextMenu[1].Name = neuLang[30]
		end
		if ContextMenu_LocalSettings ~= 0 then
			ContextMenu[2].Name = neuLang[31]
			ContextMenu_Global = false
			ContextMenu_ReadSettings(ContextMenu_LocalSettings)
		else
			ContextMenu[2].Name = neuLang[32]
			ContextMenu_Global = true
			ContextMenu_ReadSettings(ContextMenu_GlobalSettings)
		end
		ContextMenu[9].Name = neuLang[33]
		ContextMenu_FirstRun = false
		
		if ContextMenu_Accurate..ContextMenu_Sync..ContextMenu_Unhook..ContextMenu_Emulate == "" then
				ContextMenu_Disable = "0"
			else
				ContextMenu_Disable = ""
			end
		end

	if ContextMenu_HasMoved == 0 then
		for move = 1, 10 do
			Screen.clear()
			NEUTRINO_DrawMenu()
			
			movec=310-move*31
			Graphics.drawImageExtended(themeInUse[-3], 352, 240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 25)
			----------------------------------------------------------------------------
			Graphics.drawImageExtended(themeInUse[-5], 549+movec, 240, 0, 0, 325, 480, 325, 480, 0, 255)
			TempY=8+ContextMenu_SelectedItem*24
			Graphics.drawImageExtended(themeInUse[-4], 549+movec, TempY, 0, 0, 310, 22, 310, 22, 0, 255)
			for ItemToDraw = 1,ContextMenu_AllItems do
				TempY=ItemToDraw*24
				Font.ftPrint(fontSmall, 408+movec, plusYValue+TempY, 0, 400, 64, ContextMenu[ItemToDraw].Name, baseColorFull)
			end
			Font.ftPrint(fontSmall, 408+movec, plusYValue+380, 0, 512, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
			----------------------------------------------------------------------------]]
			Screen.waitVblankStart()
			Screen.flip()
		end
		ContextMenu_HasMoved = 1
	end
	if ContextMenu_HasMoved ~= 2 then
		if backgroundFilter then
			Graphics.drawImageExtended(themeInUse[-3], 352, 240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 250)
		else
			Graphics.drawImage(themeInUse[-3], 0, plusYValue+0)
		end
		----------------------------------------------------------------------------
		Graphics.drawImageExtended(themeInUse[-5], 549, 240, 0, 0, 325, 480, 325, 480, 0, 255)
		TempY=8+ContextMenu_SelectedItem*24
		Graphics.drawImageExtended(themeInUse[-4], 549, TempY, 0, 0, 310, 22, 310, 22, 0, 255)
		for ItemToDraw = 1,ContextMenu_AllItems do
			TempY=ItemToDraw*24
			Font.ftPrint(fontSmall, 408, plusYValue+TempY, 0, 400, 64, ContextMenu[ItemToDraw].Name, baseColorFull)
		end
		Font.ftPrint(fontSmall, 408, plusYValue+380, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
		----------------------------------------------------------------------------
		if Pads.check(pad, PAD_ACCEPT) and not Pads.check(oldpad, PAD_ACCEPT) then
			if ContextMenu_SelectedItem == 1 then
				if NEUTRINO_CurrentList == NEUTRINO_Favorites then
					if	NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Favorite == true then
						ContextMenu[1].Name = neuLang[29]
					elseif NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Favorite == false then
						ContextMenu[1].Name = neuLang[30]
					end
					ContextMenu_UpdateFavorties = true
					ContextMenu_HasMoved = 2
				else
					NEUTRINO_UpdateFavorites()
					if	NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Favorite == true then
						ContextMenu[1].Name = neuLang[29]
					elseif NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Favorite == false then
						ContextMenu[1].Name = neuLang[30]
					end
				end
			elseif ContextMenu_SelectedItem == 2 then
				if ContextMenu_Global == false then
					ContextMenu_ReadSettings(ContextMenu_GlobalSettings)
					ContextMenu[2].Name = neuLang[32]
					ContextMenu_Global = true
				elseif ContextMenu_Global == true then
					if ContextMenu_LocalSettings ~= 0 then
						ContextMenu_ReadSettings(ContextMenu_LocalSettings)
					end
					ContextMenu[2].Name = neuLang[31]
					ContextMenu_Global = false
				end
			elseif ContextMenu_SelectedItem == 3 then
				if ContextMenu_Logo == "" then
					ContextMenu[3].Name = "\194\172  "..neuLang[14]
					ContextMenu_Logo = " -logo"
				else
					ContextMenu[3].Name = "     "..neuLang[14]
					ContextMenu_Logo = ""
				end
			elseif ContextMenu_SelectedItem == 4 then
				if ContextMenu_Colors == "" then
					ContextMenu[4].Name = "\194\172  "..neuLang[15]
					ContextMenu_Colors = " -dbc"
				else
					ContextMenu[4].Name = "     "..neuLang[15]
					ContextMenu_Colors = ""
				end
			elseif ContextMenu_SelectedItem == 5 then
				if ContextMenu_Accurate == "" then
					ContextMenu[5].Name = "\194\172  "..neuLang[16]
					ContextMenu_Accurate = "1"
				else
					ContextMenu[5].Name = "     "..neuLang[16]
					ContextMenu_Accurate = ""
				end
			elseif ContextMenu_SelectedItem == 6 then
				if ContextMenu_Sync == "" then
					ContextMenu[6].Name = "\194\172  "..neuLang[17]
					ContextMenu_Sync = "2"
				else
					ContextMenu[6].Name = "     "..neuLang[17]
					ContextMenu_Sync = ""
				end
			elseif ContextMenu_SelectedItem == 7 then
				if ContextMenu_Unhook == "" then
					ContextMenu[7].Name = "\194\172  "..neuLang[18]
					ContextMenu_Unhook = "3"
				else
					ContextMenu[7].Name = "     "..neuLang[18]
					ContextMenu_Unhook = ""
				end
			elseif ContextMenu_SelectedItem == 8 then
				if ContextMenu_Emulate == "" then
					ContextMenu[8].Name = "\194\172  "..neuLang[19]
					ContextMenu_Emulate = "5"
				else
					ContextMenu[8].Name = "     "..neuLang[19]
					ContextMenu_Emulate = ""
				end
			elseif ContextMenu_SelectedItem == 9 then
				if NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId ~= "" then
					NEUTRINO_CachedCount = 0
					System.removeFile(xebLua_AppWorkingPath..".cache/DISC/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId..".png")
					System.removeFile(xebLua_AppWorkingPath..".cache/BG/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId..".png")
					NEUTRINO_Games[NEUTRINO_SelectedItem].Icon = ""
					NEUTRINO_Games[NEUTRINO_SelectedItem].BackGround = ""
					NEUTRINO_ReadNoArt()
					NEUTRINO_NewDiscs = ""
					NEUTRINO_NewBgs = ""
					for NEUTRINO_i in string.gmatch(NEUTRINO_NoDisc, "[^,]+") do
						if NEUTRINO_i ~= NEUTRINO_Games[NEUTRINO_SelectedItem].TitleId then
							NEUTRINO_NewDiscs = NEUTRINO_NewDiscs..NEUTRINO_i..","
						else
							RemoveDisc = true
						end
					end
					for NEUTRINO_i in string.gmatch(NEUTRINO_NoBg, "[^,]+") do
						if NEUTRINO_i ~= NEUTRINO_Games[NEUTRINO_SelectedItem].TitleId then
							NEUTRINO_NewBgs = NEUTRINO_NewBgs..NEUTRINO_i..","
						else
							RemoveBg = true
						end
					end
					if RemoveDisc == true then
						if NEUTRINO_NewDiscs == "" or NEUTRINO_NewDiscs == nil then
							System.removeFile(xebLua_AppWorkingPath..".cache/nodisc.csv")
						else
							NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/nodisc.csv", "w")
							io.output(NEUTRINO_TempFile)
							io.write(NEUTRINO_NewDiscs)
							io.close(NEUTRINO_TempFile)
						end
					end
					if RemoveBg == true then
						if NEUTRINO_NewBgs == "" or NEUTRINO_NewBgs == nil then 
							System.removeFile(xebLua_AppWorkingPath..".cache/nobg.csv")
						else
							NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/nobg.csv", "w")
							io.output(NEUTRINO_TempFile)
							io.write(NEUTRINO_NewBgs)
							io.close(NEUTRINO_TempFile)
						end
					end
					NEUTRINO_CachedStatus = false 
					NEUTRINO_CacheArt(NEUTRINO_SelectedItem)
					NEUTRINO_CachedStatus = true
					ContextMenu_ReloadArt = true
					NEUTRINO_ArtTotal = #NEUTRINO_DiscFolder + #NEUTRINO_BgFolder
					NEUTRINO_TempFile = io.open(xebLua_AppWorkingPath..".cache/lastart.cfg", "w")
					io.output(NEUTRINO_TempFile) 
					io.write(NEUTRINO_ArtTotal)
					io.close(NEUTRINO_TempFile)
				end
			end
			if ContextMenu_Accurate..ContextMenu_Sync..ContextMenu_Unhook..ContextMenu_Emulate == "" then
				ContextMenu_Disable = "0"
			else
				ContextMenu_Disable = ""
			end
		end
    end
    if ContextMenu_HasMoved == 2 then
		if backgroundFilter then
			Graphics.drawImageExtended(themeInUse[-3], 352, 240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 250)
		else
			Graphics.drawImage(themeInUse[-3], 0, plusYValue+0)
		end
		
		----------------------------------------------------------------------------
		Graphics.drawImageExtended(themeInUse[-5], 549, 240, 0, 0, 325, 480, 325, 480, 0, 255)
		TempY=8+ContextMenu_SelectedItem*24
		Graphics.drawImageExtended(themeInUse[-4], 549, TempY, 0, 0, 310, 22, 310, 22, 0, 255)
		for ItemToDraw = 1,ContextMenu_AllItems do
			TempY=ItemToDraw*24
			Font.ftPrint(fontSmall, 408, plusYValue+TempY, 0, 400, 64, ContextMenu[ItemToDraw].Name, baseColorFull)
		end
		Font.ftPrint(fontSmall, 408, plusYValue+380, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
		----------------------------------------------------------------------------   
		
		ContextMenu_NewSettings = "-gc="..ContextMenu_Disable
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Accurate
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Sync
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Unhook
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Emulate
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Colors
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Logo
		
		if ContextMenu_Global == false and ContextMenu_NewSettings ~= ContextMenu_LocalSettings and ContextMenu_UpdateFavorties == false then
			NEUTRINO_LoadingText(neuLang[34])
			NEUTRINO_TempFile = io.open("mass:/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder.."/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg", "w")
			io.output(NEUTRINO_TempFile)
			io.write(ContextMenu_NewSettings)
			io.close(NEUTRINO_TempFile)
		elseif ContextMenu_Global == true then
			NEUTRINO_LoadingText(neuLang[34])
			if ContextMenu_NewSettings ~= ContextMenu_GlobalSettings then
				NEUTRINO_TempFile = io.open("CFG/neutrinoLaunchOptions.cfg", "w")
				io.output(NEUTRINO_TempFile)
				io.write(ContextMenu_NewSettings)
				io.close(NEUTRINO_TempFile)
			end
			if ContextMenu_LocalSettings ~= 0 then
				System.removeFile("mass:/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder.."/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg")
			end
		end

		for move = 1, 10 do
			Screen.clear()
			NEUTRINO_DrawMenu()
			movec=move*31
			Graphics.drawImageExtended(themeInUse[-3], 352, 240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 300/move)
			----------------------------------------------------------------------------
			Graphics.drawImageExtended(themeInUse[-5], 549+movec, 240, 0, 0, 325, 480, 325, 480, 0, 255)
			TempY=8+ContextMenu_SelectedItem*24
			Graphics.drawImageExtended(themeInUse[-4], 549+movec, TempY, 0, 0, 310, 22, 310, 22, 0, 255)
			for ItemToDraw = 1,ContextMenu_AllItems do
				TempY=ItemToDraw*24
				Font.ftPrint(fontSmall, 408+movec, plusYValue+TempY, 0, 400, 64, ContextMenu[ItemToDraw].Name, baseColorFull)
			end
			Font.ftPrint(fontSmall, 408+movec, plusYValue+380, 0, 512, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
			----------------------------------------------------------------------------]]
			Screen.waitVblankStart()
			Screen.flip()
		end
		ContextMenu_HasMoved = 3
		XEBKeepInContextMenu = false
		
		if ContextMenu_UpdateFavorties == true then
			NEUTRINO_UpdateFavorites()
			NEUTRINO_Timer = 0
		end 
		if ContextMenu_ReloadArt == true then
			NEUTRINO_LoadingText(neuLang[13])
			if themeInUse[-90] > 0 then
				Graphics.freeImage(themeInUse[-90])
			end
			if NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround ~= "default" then
				themeInUse[-90] = Graphics.loadImage(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround)
			end 
			NEUTRINO_LoadIcon(-6, 5)
			if themeInUse[-90] > 0 and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround ~= "default" then
				Graphics.drawImageExtended(themeInUse[-90], 352, plusYValue+240, 0, 0, 640, 480, 704, 480, 0, 255)
			end
		end
		ContextMenu_FirstRun = true
	end
    
	 if Pads.check(pad, PAD_UP) and not Pads.check(oldpad, PAD_UP) then
        if ContextMenu_SelectedItem > 1 then
            ContextMenu_SelectedItem=ContextMenu_SelectedItem-1
        end
    elseif Pads.check(pad, PAD_DOWN) and not Pads.check(oldpad, PAD_DOWN) then
        if ContextMenu_SelectedItem < ContextMenu_AllItems then
            ContextMenu_SelectedItem=ContextMenu_SelectedItem+1
        end
    elseif Pads.check(pad, PAD_CANCEL) and not Pads.check(oldpad, PAD_CANCEL) or Pads.check(pad, PAD_SQUARE) and not Pads.check(oldpad, PAD_SQUARE) or Pads.check(pad, PAD_LEFT) and not Pads.check(oldpad, PAD_LEFT)then
        ContextMenu_HasMoved = 2
	end
	Screen.waitVblankStart()
	oldpad = pad;
	Screen.flip()
end 

while XEBKeepInSubMenu do
	pad = Pads.get()
	Screen.clear()
	if NEUTRINO_CurrentTotal() == 0 then
		NEUTRINO_IsThereAnError = true
	else
		NEUTRINO_IsThereAnError = false
	end
	NEUTRINO_DrawMenu()
	DrawSubMenu(actualCat,actualOption,true)
	if NEUTRINO_IsThereAnError then
		if NEUTRINO_CurrentList == NEUTRINO_Games then
			Font.ftPrint(fontBig, 152, plusYValue+222, 0, 512, 64, xebLang[35], baseColorFull)
			Font.ftPrint(fontSmall, 153, plusYValue+243, 0, 512, 64, neuLang[35], baseColorFull)
		elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
			Font.ftPrint(fontBig, 152, plusYValue+222, 0, 512, 64, xebLang[35], baseColorFull)
			Font.ftPrint(fontSmall, 153, plusYValue+243, 0, 512, 64, neuLang[47], baseColorFull)
			Graphics.drawImage(themeInUse[-95], 500, plusYValue+400)
			Graphics.drawImage(themeInUse[-96], 506, plusYValue+400)
			Font.ftPrint(fontSmall, 543, plusYValue+405, 0, 400, 64, neuLang[10], baseColorFull)
		end
	else
		if XEBKeepInContextMenu == true then
			goto contexMenu
		end
		if NEUTRINO_ShowHelp == false then
		if Pads.check(pad, PAD_ACCEPT) and not Pads.check(oldpad, PAD_ACCEPT) then
			spinSpeed = 0.34
			for NEUTRINO_WaveByeBye = 1, 25 do
				Screen.clear()
				if backgroundFilter then
					Graphics.drawImageExtended(themeInUse[-1], 352, plusYValue+240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
				else
					Graphics.drawImage(themeInUse[-1], 0, plusYValue+0)
				end
				thmDrawBKG()
				DrawSubMenu(actualCat,actualOption,true)
				NEUTRINO_ItemPosition = -5
				for NEUTRINO_iB = NEUTRINO_SelectedItem-6, NEUTRINO_SelectedItem+5 do
					NEUTRINO_iB_Y = NEUTRINO_ItemPosition*71
					if NEUTRINO_iB ~= NEUTRINO_SelectedItem then
						NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, NEUTRINO_iB_Y+135, true, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder)
					end
					NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+1
				end
				spinDisc()
				thmDrawBKGOL()
				Graphics.drawRect(352, 240, 704, 480, Color.new(0,0,0,NEUTRINO_WaveByeBye*10))
				NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Favorite, NEUTRINO_CurrentList[NEUTRINO_SelectedItem].IconSlot, 152, 206, false, NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name, NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder)
				Screen.waitVblankStart()
				Screen.flip()
			end
			for NEUTRINO_WaveByeBye = 1, 25 do
				Screen.clear()
				NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Favorite, NEUTRINO_CurrentList[NEUTRINO_SelectedItem].IconSlot, 152, 206, false, NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name, NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder)
				Graphics.drawRect(352, 240, 704, 480, Color.new(0,0,0,NEUTRINO_WaveByeBye*10))
				Screen.waitVblankStart()
				Screen.flip()
			end
			for NEUTRINO_WaveByeBye = 1, 25 do
				Screen.clear()
				NEUTRINO_ColorToDraw=NEUTRINO_WaveByeBye*10
				NEUTRINO_ColorToDraw=255-NEUTRINO_ColorToDraw
				Font.ftPrint(fontBig, 352, plusYValue+223, 11, 512, 64, "neutrino", Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+240, 11, 512, 64, neuLang[36], Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+414, 11, 512, 64, neuLang[37], Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+427, 11, 512, 64, neuLang[38], Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+440, 11, 512, 64, neuLang[39], Color.new(255,255,255,128))
				Graphics.drawRect(352, 240, 704, 480, Color.new(0,0,0,NEUTRINO_ColorToDraw))
				Screen.waitVblankStart()
				Screen.flip()
			end
			for NEUTRINO_WaveByeBye = 1, 52 do
				Screen.clear()
				Font.ftPrint(fontBig, 352, plusYValue+223, 11, 512, 64, "neutrino", Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+240, 11, 512, 64, neuLang[36], Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+414, 11, 512, 64, neuLang[37], Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+427, 11, 512, 64, neuLang[38], Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+440, 11, 512, 64, neuLang[39], Color.new(255,255,255,128))
				Screen.waitVblankStart()
				Screen.flip()
			end
			for NEUTRINO_WaveByeBye = 1, 25 do
				Screen.clear()
				Font.ftPrint(fontBig, 352, plusYValue+223, 11, 512, 64, "neutrino", Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+240, 11, 512, 64, neuLang[36], Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+414, 11, 512, 64, neuLang[37], Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+427, 11, 512, 64, neuLang[38], Color.new(255,255,255,128))
				Font.ftPrint(fontSmall, 352, plusYValue+440, 11, 512, 64, neuLang[39], Color.new(255,255,255,128))
				Graphics.drawRect(352, 240, 704, 480, Color.new(0,0,0,NEUTRINO_WaveByeBye*10))
				Screen.waitVblankStart()
				Screen.flip()
			end
			for NEUTRINO_WaveByeBye = 1, 2 do
				Screen.clear()
				Screen.waitVblankStart()
				Screen.flip()
			end
			if NEUTRINO_LocationPrefix~=System.currentDirectory().."CD/" then
				if System.doesFileExist("mass:/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder.."/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg") then
					NEUTRINO_TempFile = io.open("mass:/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder.."/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg", "r")
					NEUTRINO_LaunchOptions = (NEUTRINO_TempFile:read())
					io.close(NEUTRINO_TempFile)
				elseif System.doesFileExist("CFG/neutrinoLaunchOptions.cfg") then
					NEUTRINO_TempFile = io.open("CFG/neutrinoLaunchOptions.cfg", "r")
					NEUTRINO_LaunchOptions = (NEUTRINO_TempFile:read())
					io.close(NEUTRINO_TempFile)
				else
					NEUTRINO_LaunchOptions = ""
					NEUTRINO_LoadingText(neuLang[40])
				end
				

				NEUTRINO_RadShellText = "fontsize 0.6\r\nload ioman.irx\r\nsleep 1\r\nrun neutrino.elf -bsd=ata -bsdfs=exfat \"-dvd=mass:"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder.."/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name.."."..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Extension.."\" -mt="..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Media.." "..NEUTRINO_LaunchOptions.."\r\n                                                                                                                                                                                                                                                                      "
				NEUTRINO_RadShellFile = System.openFile(xebLua_AppWorkingPath.."radshellmod.ios", FRDWR)
				System.removeFile(NEUTRINO_RadShellFile)
				System.closeFile(NEUTRINO_RadShellFile)
				NEUTRINO_RadShellFile = System.openFile(xebLua_AppWorkingPath.."radshellmod.ios", FCREATE)
				System.writeFile(NEUTRINO_RadShellFile, NEUTRINO_RadShellText, string.len(NEUTRINO_RadShellText))
				System.closeFile(NEUTRINO_RadShellFile)
			end
			NEUTRINO_SaveLast()
			LaunchELF(xebLua_AppWorkingPath.."radshellmod.elf", 0, "Default", false, 1)
		elseif Pads.check(pad, PAD_UP) then
			if not Pads.check(oldpad, PAD_UP) then
				if NEUTRINO_SelectedItem ~= 1 then
					NEUTRINO_HoldingUp=1;
					NEUTRINO_HoldingUpDash=NEUTRINO_HoldingUpDash+1;
					NEUTRINO_AnimateUp(1)
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem - 1
				elseif NEUTRINO_SelectedItem == 1 then
					NEUTRINO_SelectedItem = NEUTRINO_CurrentTotal()
					NEUTRINO_LoadIcon(-6, 0)
					NEUTRINO_AnimateUp(1)
					NEUTRINO_HoldingUp=1;
					NEUTRINO_HoldingUpDash=NEUTRINO_HoldingUpDash+1;
				end
			elseif NEUTRINO_HoldingUp==17 and Pads.check(oldpad, PAD_UP) then
				if NEUTRINO_SelectedItem ~= 1 then
					NEUTRINO_HoldingUp=1;
					NEUTRINO_HoldingUpDash=NEUTRINO_HoldingUpDash+1;
					NEUTRINO_AnimateUp(1)
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem - 1
				end
			elseif NEUTRINO_HoldingUpDash>1 and Pads.check(oldpad, PAD_UP) then
				if NEUTRINO_SelectedItem ~= 1 then
					NEUTRINO_HoldingUp=1;
					NEUTRINO_HoldingUpDash=NEUTRINO_HoldingUpDash+1;
					NEUTRINO_AnimateUp(1)
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem - 1
				end
			end
			NEUTRINO_HoldingUp=NEUTRINO_HoldingUp+1;
		elseif Pads.check(pad, PAD_DOWN) then
			if not Pads.check(oldpad, PAD_DOWN) then
				if NEUTRINO_SelectedItem ~= NEUTRINO_CurrentTotal() then
					NEUTRINO_HoldingDown=1;
					NEUTRINO_HoldingDownDash=NEUTRINO_HoldingDownDash+1;
					NEUTRINO_AnimateDown(1)
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem + 1
				elseif NEUTRINO_SelectedItem == NEUTRINO_CurrentTotal() then
					NEUTRINO_SelectedItem = 1
					NEUTRINO_LoadIcon(0, 6)
					NEUTRINO_AnimateDown(1)
					NEUTRINO_HoldingDown=1;
					NEUTRINO_HoldingDownDash=NEUTRINO_HoldingDownDash+1;
				end
			elseif NEUTRINO_HoldingDown==17 and Pads.check(oldpad, PAD_DOWN) then
				if NEUTRINO_SelectedItem ~= NEUTRINO_CurrentTotal() then
					NEUTRINO_HoldingDown=1;
					NEUTRINO_HoldingDownDash=NEUTRINO_HoldingDownDash+1;
					NEUTRINO_AnimateDown(1)
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem + 1
				end
			elseif NEUTRINO_HoldingDownDash>1 and Pads.check(oldpad, PAD_DOWN) then
				if NEUTRINO_SelectedItem ~= NEUTRINO_CurrentTotal() then
					NEUTRINO_HoldingDown=1;
					NEUTRINO_HoldingDownDash=NEUTRINO_HoldingDownDash+1;
					NEUTRINO_AnimateDown(1)
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem + 1
				end
			end
			NEUTRINO_HoldingDown=NEUTRINO_HoldingDown+1;
		
		elseif Pads.check(pad, PAD_L1) and not Pads.check(pad, PAD_R1) and not Pads.check(oldpad, PAD_R1) then
			NEUTRINO_Scrolling = true
			AnimateCount = 0
			if NEUTRINO_SelectedItem == 1 then
				if not Pads.check(oldpad, PAD_L1) then
					NEUTRINO_SelectedItem = NEUTRINO_CurrentTotal()
					NEUTRINO_LoadIcon(-6, 0)
					NEUTRINO_Scrolling = false
					NEUTRINO_AnimateUp(1)
					goto L1End
				end
				NEUTRINO_SelectedItem = 1
				if NEUTRINO_SelectedItem ~= NEUTRINO_OldItem then
					NEUTRINO_LoadingText(neuLang[6])
					NEUTRINO_LoadIcon(0, 5)
				end
				NEUTRINO_Scrolling = false
			elseif (NEUTRINO_SelectedItem - 10) < 1 then
				AnimateCount = math.abs(1 - NEUTRINO_SelectedItem)
			else
				AnimateCount = 10
			end
			if AnimateCount > 0 then
				for i = AnimateCount,1,-1 do
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem - 1
					if i % 2 == 0 then
						NEUTRINO_AnimateUp(2)
					end
					if i == 1 and not Pads.check(pad, PAD_L1) then
						NEUTRINO_LoadingText(neuLang[6])
						NEUTRINO_LoadIcon(-6, 5)
						NEUTRINO_Scrolling = false
					end
				end
			end
			::L1End::
		elseif Pads.check(pad, PAD_R1) and not Pads.check(pad, PAD_L1) and not Pads.check(oldpad, PAD_L1 )then
			NEUTRINO_Scrolling = true
			AnimateCount = 0
			if NEUTRINO_SelectedItem == NEUTRINO_CurrentTotal() then
				if not Pads.check(oldpad, PAD_R1) then
					NEUTRINO_SelectedItem = 1
					NEUTRINO_LoadingText(neuLang[6])
					NEUTRINO_LoadIcon(0, 5)
					NEUTRINO_Scrolling = false
					NEUTRINO_AnimateDown(1)
					goto R1End
				end
				NEUTRINO_SelectedItem = NEUTRINO_CurrentTotal()
				if NEUTRINO_SelectedItem ~= NEUTRINO_OldItem then
					NEUTRINO_LoadingText(neuLang[6])
					NEUTRINO_LoadIcon(-6, 0)
				end
				NEUTRINO_Scrolling = false
			elseif (NEUTRINO_SelectedItem + 10) > NEUTRINO_CurrentTotal() then
				AnimateCount = NEUTRINO_CurrentTotal() - NEUTRINO_SelectedItem
			else
				AnimateCount = 10
			end
			if AnimateCount > 0 then
				for i = AnimateCount,1,-1 do
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem + 1
					if i % 2 == 0 then
						NEUTRINO_AnimateDown(2)
					end
					if i == 1 and not Pads.check(pad, PAD_R1) then
						NEUTRINO_LoadingText(neuLang[6])
						NEUTRINO_LoadIcon(-6, 5)
						NEUTRINO_Scrolling = false
					end
				end
			end
			::R1End::
		elseif Pads.check(pad, PAD_L2) and not Pads.check(oldpad, PAD_L2) then
			currentLetter = string.sub(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name, 1, 1)
			newLetter = currentLetter
			i = NEUTRINO_SelectedItem
			while newLetter == currentLetter and i > 0 do
				i = i - 1
				newLetter = string.sub(NEUTRINO_CurrentList[i].Name, 1, 1)
			end
			currentLetter = newLetter
			while newLetter == currentLetter and i > 0 do
				i = i - 1
				newLetter = string.sub(NEUTRINO_CurrentList[i].Name, 1, 1)
			end
			NEUTRINO_SelectedItem = i + 1
			NEUTRINO_LoadingText(neuLang[6])
			NEUTRINO_LoadIcon(-6, 5)
		elseif Pads.check(pad, PAD_R2) and not Pads.check(oldpad, PAD_R2) then
			currentLetter = string.sub(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name, 1, 1)
			newLetter = currentLetter
			i = NEUTRINO_SelectedItem
			while newLetter == currentLetter and i < NEUTRINO_CurrentTotal() do
				i = i + 1
				newLetter = string.sub(NEUTRINO_CurrentList[i].Name, 1, 1)
			end
			NEUTRINO_SelectedItem = i
			NEUTRINO_LoadingText(neuLang[6])
			NEUTRINO_LoadIcon(-6, 5)
		elseif Pads.check(pad, PAD_L3) and not Pads.check(oldpad, PAD_L3) then
			if NEUTRINO_SelectedItem ~= 1 then
				NEUTRINO_SelectedItem = 1
				NEUTRINO_LoadingText(neuLang[6])
				NEUTRINO_LoadIcon(-6, 5)
			end
		elseif Pads.check(pad, PAD_R3) and not Pads.check(oldpad, PAD_R3) then
			if NEUTRINO_SelectedItem ~= NEUTRINO_CurrentTotal() then
				NEUTRINO_SelectedItem = NEUTRINO_CurrentTotal()
				NEUTRINO_LoadingText(neuLang[6])
				NEUTRINO_LoadIcon(-6, 5)
			end
		elseif  Pads.check(pad, PAD_SQUARE) and not Pads.check(oldpad, PAD_SQUARE)then
			XEBKeepInContextMenu = true
			ContextMenu_HasMoved = 0
		end
		end
	end
	if Pads.check(pad, PAD_CANCEL) and not Pads.check(oldpad, PAD_CANCEL) or Pads.check(pad, PAD_LEFT) and not Pads.check(oldpad, PAD_LEFT) then
		if NEUTRINO_ShowHelp == false then
			if NEUTRINO_IsThereAnError == false then
				NEUTRINO_LoadingText(neuLang[34])
				NEUTRINO_SaveLast()
			end
			XEBKeepInSubMenu=false
		end
	elseif Pads.check(pad, PAD_TRIANGLE) and not Pads.check(oldpad, PAD_TRIANGLE) then
			if themeInUse[-90] > 0 and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround ~= "default" and NEUTRINO_IsThereAnError == false then
				Graphics.freeImage(themeInUse[-90])
			end
			if NEUTRINO_CurrentList == NEUTRINO_Games then
				NEUTRINO_GamesSelected = NEUTRINO_SelectedItem
				NEUTRINO_CurrentList = NEUTRINO_Favorites
				NEUTRINO_LinkedList = NEUTRINO_Games
				if NEUTRINO_FavoritesSelected then
					NEUTRINO_SelectedItem = NEUTRINO_FavoritesSelected
				else
					NEUTRINO_SelectedItem = 1
				end
				NEUTRINO_LoadingText(neuLang[41])
			elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
				NEUTRINO_FavoritesSelected = NEUTRINO_SelectedItem
				NEUTRINO_CurrentList = NEUTRINO_Games
				NEUTRINO_LinkedList = NEUTRINO_Favorites
				if NEUTRINO_GamesSelected then
					NEUTRINO_SelectedItem = NEUTRINO_GamesSelected
				else
					NEUTRINO_SelectedItem = 1
				end
				NEUTRINO_LoadingText(neuLang[42])
			end
			NEUTRINO_InitList()
			NEUTRINO_LoadingText(neuLang[6])
			NEUTRINO_Timer = 0
	elseif  Pads.check(pad, PAD_SELECT) and not Pads.check(oldpad, PAD_SELECT)then
		if NEUTRINO_ShowHelp == false then
			NEUTRINO_ShowHelp = true
		end
	end
	spinDisc()
	thmDrawBKGOL()
	Screen.waitVblankStart()
	oldpad = pad;
	Screen.flip()
	
	::contexMenu::
	if XEBKeepInContextMenu == true then
		NEUTRINO_ContextMenu()
	end
end

for NEUTRINO_i = 1, 3 do
	pad = Pads.get()
	Screen.clear()
	if backgroundFilter then
		Graphics.drawImageExtended(themeInUse[-1], 352, plusYValue+240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
	else
		Graphics.drawImage(themeInUse[-1], 0, plusYValue+0)
	end
	thmDrawBKG()
	DrawSubMenu(actualCat,actualOption,true)
	NEUTRINO_ReverseFrame=4-NEUTRINO_i
	if NEUTRINO_IsThereAnError then
		Font.ftPrint(fontBig, 152, plusYValue+222, 0, 512, 64, xebLang[35], NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_ReverseFrame,baseColorFull,NEUTRINO_ColorFullZero))
		Font.ftPrint(fontSmall, 153, plusYValue+243, 0, 512, 64, neuLang[35], NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_ReverseFrame,baseColorFull,NEUTRINO_ColorFullZero))
	else
		NEUTRINO_ItemPosition = -5
		for NEUTRINO_iB = NEUTRINO_SelectedItem-6, NEUTRINO_SelectedItem+5 do
			NEUTRINO_iB_Y = NEUTRINO_ItemPosition*71
			if NEUTRINO_iB == NEUTRINO_SelectedItem then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, 206, false, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder, NEUTRINO_ReverseFrame, baseColorFull, NEUTRINO_ColorFullZero)
			else
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB].Favorite, NEUTRINO_CurrentList[NEUTRINO_iB].IconSlot, 152, NEUTRINO_iB_Y+135, true, NEUTRINO_CurrentList[NEUTRINO_iB].Name, NEUTRINO_CurrentList[NEUTRINO_iB].Folder, NEUTRINO_ReverseFrame, baseColorFaded, NEUTRINO_ColorFadedZero)
			end
			NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+1
		end
	end
	spinDisc()
	thmDrawBKGOL()
	Screen.waitVblankStart()
	oldpad = pad;
	Screen.flip()
end
for NEUTRINO_i = -90, -111 do
	if themeInUse[NEUTRINo_i] > 0 then
		Graphics.freeImage(themeInUse[NEUTRINO_i])
	end
end

BackFromSubMenuIcon(actualCat,actualOption,true)
pad = Pads.get()
Screen.clear()
if backgroundFilter then
	Graphics.drawImageExtended(themeInUse[-1], 352, plusYValue+240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
else
	Graphics.drawImage(themeInUse[-1], 0, plusYValue+0)
end
thmDrawBKG()
DrawInterface(actualCat,actualOption,true)
spinDisc()
spinSpeed = 0
imanoSpin=0
thmDrawBKGOL()
oldpad = pad;
