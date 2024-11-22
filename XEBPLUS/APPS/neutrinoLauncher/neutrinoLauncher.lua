--------------------------------------------------------
-- NEUTRINO LAUNCHER
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
	io.write("\n")
	io.close(log)
end
if System.doesFileExist("CFG/neutrinoLauncher/menu.cfg") then
    ContextMenu_TempFile = io.open("CFG/neutrinoLauncher/menu.cfg", "r")
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
if string.match(NEUTRINO_Settings, "(.*)7(.*)") then
	NEUTRINO_DisableFade = true
	NEUTRINO_BgAlpha = 255
else
	NEUTRINO_DisableFade = false
	NEUTRINO_BgAlpha = 0
end
if string.match(NEUTRINO_Settings, "(.*)4(.*)") then
	NEUTRINO_ShowTitleId = false
else
	NEUTRINO_ShowTitleId = true
end
if string.match(NEUTRINO_Settings, "(.*)6(.*)") then
	NEUTRINO_ShowMedia = false
else
	NEUTRINO_ShowMedia = true
end

if NEUTRINO_ShowTitleId and NEUTRINO_ShowMedia then
	NEUTRINO_Seperator = "\226\128\162 "
else
	NEUTRINO_Seperator = ""
end

themeInUse[-90] = 0
NEUTRINO_OldItem = 0
NEUTRINO_Fade = "in"

function NEUTRINO_PrepDraw(NEUTRINO_TempGame)
	if NEUTRINO_ShowTitleId == false then
		NEUTRINO_TempTitleId = ""
	else
		NEUTRINO_TempTitleId = NEUTRINO_TempGame.TitleId
	end
	if NEUTRINO_TempGame.IconSlot == 0 or NEUTRINO_Scrolling == true then
		if NEUTRINO_TempGame.Folder == "DVD" then
			NEUTRINO_SetIcon = themeInUse[126]
		elseif NEUTRINO_TempGame.Folder == "CD" then
			NEUTRINO_SetIcon = themeInUse[125]
		end
	else
		NEUTRINO_SetIcon = themeInUse[NEUTRINO_TempGame.IconSlot]
	end
	if NEUTRINO_ShowMedia == false then
		NEUTRINO_TempMedia = ""
	else
		NEUTRINO_TempMedia = NEUTRINO_TempGame.Folder.."-ROM"
	end
	if NEUTRINO_TempGame.Favorite == true then
		--NEUTRINO_TempFavorite = "  \226\128\162  "..neuLang[2]
		NEUTRINO_TempName = "\226\128\162 "..NEUTRINO_TempGame.Name.." \226\128\162"
	else
		NEUTRINO_TempName = NEUTRINO_TempGame.Name
	end
end

function NEUTRINO_DrawItem(NEUTRINO_TempGame, NEUTRINO_TempX, NEUTRINO_TempY, NEUTRINO_TempFaded)
	NEUTRINO_PrepDraw(NEUTRINO_TempGame)

	if NEUTRINO_TempFaded then
		if NEUTRINO_TempName ~= "" then
			if NEUTRINO_SetIcon == themeInUse[NEUTRINO_TempGame.IconSlot] then
				Graphics.drawImageExtended(NEUTRINO_SetIcon, NEUTRINO_TempX+32, plusYValue+NEUTRINO_TempY+32, 0, 0,  64, 64, 42, 42, 0, columnsFade)
			else
				Graphics.drawImage(NEUTRINO_SetIcon, NEUTRINO_TempX, plusYValue+NEUTRINO_TempY, columnsFade)
			end
			Font.ftPrint(fontSmall, NEUTRINO_TempX+70, plusYValue+NEUTRINO_TempY+32, 0, 512, 64, NEUTRINO_TempTitleId.." "..NEUTRINO_Seperator.." "..NEUTRINO_TempMedia, baseColorFaded)
		end
		Font.ftPrint(fontBig, NEUTRINO_TempX+69, plusYValue+NEUTRINO_TempY+16, 0, 512, 64, NEUTRINO_TempName, baseColorFaded)
	else
		if NEUTRINO_TempName ~= "" then
			if NEUTRINO_SetIcon == themeInUse[NEUTRINO_TempGame.IconSlot] then
				Graphics.drawImageExtended(NEUTRINO_SetIcon, NEUTRINO_TempX+32, plusYValue+NEUTRINO_TempY+32, 0, 0,  64, 64, 42, 42, imanoSpin, 255)
			else
				Graphics.drawImage(NEUTRINO_SetIcon, NEUTRINO_TempX, plusYValue+NEUTRINO_TempY)
			end
			Font.ftPrint(fontSmall, NEUTRINO_TempX+70, plusYValue+NEUTRINO_TempY+32, 0, 512, 64, NEUTRINO_TempTitleId.." "..NEUTRINO_Seperator.." "..NEUTRINO_TempMedia, baseColorFull)
		end
		Font.ftPrint(fontBig, NEUTRINO_TempX+69, plusYValue+NEUTRINO_TempY+16, 0, 512, 64, NEUTRINO_TempName, baseColorFull)
	end
end

function NEUTRINO_DrawItemFrame(NEUTRINO_TempGame, NEUTRINO_TempX, NEUTRINO_TempY, NEUTRINO_TempFaded, NEUTRINO_TempTheFrame, NEUTRINO_TempTheColorA, NEUTRINO_TempTheColorB)
	NEUTRINO_PrepDraw(NEUTRINO_TempGame)

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
		if NEUTRINO_SetIcon == themeInUse[NEUTRINO_TempGame.IconSlot] then
			Graphics.drawImageExtended(NEUTRINO_SetIcon, NEUTRINO_TempX+32, plusYValue+NEUTRINO_TempY+32, 0, 0,  64, 64, 42, 42, 0, TempAlpha)
		else
			Graphics.drawImage(NEUTRINO_SetIcon, NEUTRINO_TempX, plusYValue+NEUTRINO_TempY, TempAlpha)
		end
		Font.ftPrint(fontSmall, NEUTRINO_TempX+70, plusYValue+NEUTRINO_TempY+32, 0, 512, 64, NEUTRINO_TempTitleId.." "..NEUTRINO_Seperator.." "..NEUTRINO_TempMedia, NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_TempTheFrame, NEUTRINO_TempTheColorA, NEUTRINO_TempTheColorB))
	end
	Font.ftPrint(fontBig, NEUTRINO_TempX+69, plusYValue+NEUTRINO_TempY+16, 0, 512, 64, NEUTRINO_TempName, NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_TempTheFrame,NEUTRINO_TempTheColorA,NEUTRINO_TempTheColorB))
end

function NEUTRINO_DrawUnderlay(Animate)
	if  NEUTRINO_Timer >= 9 and NEUTRINO_Scrolling == false then
		if NEUTRINO_Timer >= 14 then
			NEUTRINO_Timer = 14
		end
		if NEUTRINO_DisableFade == false and NEUTRINO_Fade == "in" and themeInUse[-90] > 0 and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround ~= "default" then
			if NEUTRINO_BgAlpha < 255 then
				NEUTRINO_BgAlpha = NEUTRINO_BgAlpha + 39.23
			else
				NEUTRINO_BgAlpha = 255
			end
		end
	end
	if themeInUse[-90] > 0 then
		Graphics.drawImageExtended(themeInUse[-90], 352, plusYValue+240, 0, 0, 640, 480, 704, 480, 0, NEUTRINO_BgAlpha)
		Graphics.drawImage(themeInUse[-91], 152, 186)

		if NEUTRINO_DisableFade == false and NEUTRINO_Fade == "out" and NEUTRINO_BgAlpha > 0 then
			NEUTRINO_BgAlpha = NEUTRINO_BgAlpha - 39.23
			if NEUTRINO_BgAlpha < 0 then
				NEUTRINO_BgAlpha = 0
				--if NEUTRINO_CurrentList[NEUTRINO_OldItem].BackGround ~= "default" then
					Graphics.freeImage(themeInUse[-90])
					themeInUse[-90] = 0
					if NEUTRINO_DisableAnimate == false then
						spinSpeed = 0.17
					end
				--end
			end
		elseif NEUTRINO_DisableFade == true and NEUTRINO_Fade == "out" then
			Graphics.freeImage(themeInUse[-90])
			themeInUse[-90] = 0
			if NEUTRINO_DisableAnimate == false then
				spinSpeed = 0.17
			end
		end
	end

	if Animate == false then
		NEUTRINO_ItemPosition = -5
		for NEUTRINO_iB = NEUTRINO_SelectedItem-6, NEUTRINO_SelectedItem+5 do
			NEUTRINO_iB_Y = NEUTRINO_ItemPosition*71
			if NEUTRINO_iB == NEUTRINO_SelectedItem then
				NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_iB], 152, 206, false)
			else
				NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_iB], 152, NEUTRINO_iB_Y+135, true)
			end
			NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+1
		end
	end
	thmDrawBKGOL()
	Graphics.drawImage(themeInUse[-94], NEUTRINO_BoxPos, plusYValue+22)
	if NEUTRINO_CurrentList == NEUTRINO_Games then
		Font.ftPrint(fontMid, NEUTRINO_HeaderPos, plusYValue+45, 0, 400, 64, neuLang[10].." - "..NEUTRINO_SelectedItem..neuLang[9]..NEUTRINO_GamesTotal, baseColorFull)
	elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
		Font.ftPrint(fontXET, 495, plusYValue+45, 0, 400, 64, neuLang[11]..NEUTRINO_SelectedItem..neuLang[9]..NEUTRINO_FavoritesTotal, baseColorFull)
	end
	Graphics.drawImage(themeInUse[-95], 500, plusYValue+400)
	Graphics.drawImage(themeInUse[-93], 506, plusYValue+400)
	Font.ftPrint(fontSmall, 543, plusYValue+405, 0, 400, 64, neuLang[12], baseColorFull)

	--if NEUTRINO_Debug ~= nil then
	--	Font.ftPrint(fontBig, 280, plusYValue+390, 11, 620, 64, NEUTRINO_Debug, baseColorFull)
	--end
end

function NEUTRINO_DrawMenu(Animate)
	if backgroundFilter then
		Graphics.drawImageExtended(themeInUse[-1], 352, plusYValue+240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
	else
		Graphics.drawImage(themeInUse[-1], 0, plusYValue+0)
	end
	thmDrawBKG()
	if not NEUTRINO_IsThereAnError then
		if NEUTRINO_SelectedItem == NEUTRINO_OldItem then
			NEUTRINO_Timer = NEUTRINO_Timer+1
		else
			NEUTRINO_Fade = "out"
			NEUTRINO_Timer = 0
		end

		NEUTRINO_DrawUnderlay(Animate)

		if NEUTRINO_Scrolling == false and NEUTRINO_HoldingUp > 1 and NEUTRINO_HoldingDown > 1 then
			if NEUTRINO_Timer == 7 and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround ~= "default" and themeInUse[-90] == 0 then
				NEUTRINO_LoadingText(false, neuLang[13])
				NEUTRINO_Fade = "in"
				themeInUse[-90] = Graphics.loadImage(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround)
				if NEUTRINO_DisableAnimate == false then
					spinSpeed = 0.34
				end
			elseif NEUTRINO_Timer == 7 then
				NEUTRINO_Fade = "in"
				NEUTRINO_Timer = 0
				themeInUse[-90] = 0
				if NEUTRINO_DisableAnimate == false then
					spinSpeed = 0.17
				end
			--elseif NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround == "default" and themeInUse[-90] == 0 then
				--NEUTRINO_Fade = "in"
			end
			NEUTRINO_OldItem=NEUTRINO_SelectedItem
		end

		while NEUTRINO_ShowHelp == true do
			pad = Pads.get()
			NEUTRINO_DrawUnderlay(false)
			Graphics.drawImageExtended(themeInUse[-92], 352, plusYValue+240, 0, 0, 640, 480, 704, 480, 0, 255)
			Screen.waitVblankStart()
			Screen.flip()
			if Pads.check(pad, PAD_CANCEL) and not Pads.check(oldpad, PAD_CANCEL) or Pads.check(pad, PAD_SELECT) and not Pads.check(oldpad, PAD_SELECT) then
				NEUTRINO_ShowHelp = false
			end
			oldpad = pad;
		end

	end
end

function NEUTRINO_LoadingText(Animate, Item)
	if NEUTRINO_DisableStatus == false then
		if XEBKeepInContextMenu == false then
			Screen.clear()
			if backgroundFilter then
			Graphics.drawImageExtended(themeInUse[-1], 352, plusYValue+240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
			else
				Graphics.drawImage(themeInUse[-1], 0, plusYValue+0)
			end
			thmDrawBKG()
			if NEUTRINO_Timer  then
				NEUTRINO_DrawUnderlay(Animate)
			else
				thmDrawBKGOL()
			end
			DrawSubMenu(actualCat,actualOption,true)
		end
		Font.ftPrint(fontSmall, 342, plusYValue+414, 11, 512, 64, Item..". . .", Color.new(255,255,255,128))
		spinDisc()
		Screen.waitVblankStart()
		Screen.flip()
	end
end

function NEUTRINO_PrepRecache()
	NEUTRINO_CachedStatus = false
	if System.doesFileExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nobg.csv") then
		System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nobg.csv")
	end
	if System.doesFileExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nodisc.csv") then
		System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nodisc.csv")
	end
end

NEUTRINO_LoadingText(false, neuLang[1])
if not System.doesDirectoryExist("mass:/XEBPLUS/CFG/neutrinoLauncher") then
	System.createDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher")
end
if System.doesDirectoryExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache") then
	if not System.doesDirectoryExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/DISC") then
		System.createDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/DISC")
		NEUTRINO_PrepRecache()
	end
	if not System.doesDirectoryExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/BG") then
		System.createDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/BG")
		NEUTRINO_PrepRecache()
	end
else
	System.createDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache")
	System.createDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/DISC")
	System.createDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/BG")
	NEUTRINO_CachedStatus = false
end
if not System.doesDirectoryExist(NEUTRINO_DataFolder) then
	System.createDirectory(NEUTRINO_DataFolder)
end
if not System.doesFileExist(NEUTRINO_DataFolder.."lastgame.cfg") then
	NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder.."lastgame.cfg", "w")
	io.output(NEUTRINO_TempFile)
	io.write(1)
	io.close(NEUTRINO_TempFile)
end
if System.doesFileExist("CFG/neutrinoLauncher/favorites.csv") then
	NEUTRINO_TempFile = io.open("CFG/neutrinoLauncher/favorites.csv", "r")
	NEUTRINO_FavoritesList = (NEUTRINO_TempFile:read())
	io.close(NEUTRINO_TempFile)
else
	NEUTRINO_FavoritesList = ""
end
if System.doesDirectoryExist("mass:/ART/") then
	NEUTRINO_ArtFolder = "mass:/ART/"
elseif System.doesDirectoryExist("mass:/XEBPLUS/GME/ART/") then
	NEUTRINO_ArtFolder = "mass:/XEBPLUS/GME/ART/"
else
	NEUTRINO_DisableArt = true
end

--themeInUse[-90] = Graphics.loadImage(xebLua_AppWorkingPath.."image/bgfallback.png")
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

NEUTRINO_CurrentList = NEUTRINO_Games
NEUTRINO_SelectedItem = 1
NEUTRINO_CachedCount = 0
NEUTRINO_TitleIdCount = 0
NEUTRINO_NBgCount = 0
NEUTRINO_NDiscCount = 0
NEUTRINO_newLetter = ""
NEUTRINO_currentLetter = " "

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

function NEUTRINO_DrawCacheStatus(Index)
	Screen.clear()
	thmDrawBKG()
	thmDrawBKGOL()
	DrawSubMenu(actualCat,actualOption,false)
	Font.ftPrint(fontBig, 420, plusYValue+256, 11, 512, 64, neuLang[3]..NEUTRINO_CachedCount..neuLang[4].."\n"..math.floor(((Index-1+DrawCount)*100)/NEUTRINO_GamesTotal)..neuLang[60], Color.new(255,255,255,128))
	Screen.waitVblankStart()
	Screen.flip()
	DrawCount = DrawCount + 0.125
end

function NEUTRINO_CacheArt(Index)
	if System.doesDirectoryExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache") and NEUTRINO_DisableArt == false then
		if NEUTRINO_CachedStatus == false then
			if not NEUTRINO_ArtList then
				NEUTRINO_LoadingText(false, neuLang[13])
				NEUTRINO_ArtList = System.listDirectory(NEUTRINO_ArtFolder)
			end

			DrawCount = 0
			if NEUTRINO_Games[Index].TitleId ~= "" then
				new_disc = "mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/DISC/"..NEUTRINO_Games[Index].TitleId..".png"
				NEUTRINO_DrawCacheStatus(Index)
				if not System.doesFileExist(new_disc) then
					NEUTRINO_DrawCacheStatus(Index)
					for i = 1, #NEUTRINO_ArtList do
						if NEUTRINO_ArtList[i].name == NEUTRINO_Games[Index].TitleId.."_ICO.png" then
							NEUTRINO_DrawCacheStatus(Index)
							old_disc = NEUTRINO_ArtFolder..NEUTRINO_Games[Index].TitleId.."_ICO.png"
							System.copyFile(old_disc, new_disc)
							break
						else
							old_disc = nil
						end
					end
					if old_disc == nil then
						NEUTRINO_DrawCacheStatus(Index)
						NEUTRINO_TempFile = io.open("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nodisc.csv", "a")
						io.output(NEUTRINO_TempFile)
						io.write(NEUTRINO_Games[Index].TitleId..",")
						io.close(NEUTRINO_TempFile)
						NEUTRINO_Games[Index].Icon = "default"
					end
				end
				NEUTRINO_DrawCacheStatus(Index)

				new_bg = "mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/BG/"..NEUTRINO_Games[Index].TitleId..".png"
				NEUTRINO_DrawCacheStatus(Index)
				if not System.doesFileExist(new_bg) then
					NEUTRINO_DrawCacheStatus(Index)
					for i = 1, #NEUTRINO_ArtList do
						if NEUTRINO_ArtList[i].name == NEUTRINO_Games[Index].TitleId.."_BG.png" then
							NEUTRINO_DrawCacheStatus(Index)
							old_bg = NEUTRINO_ArtFolder..NEUTRINO_Games[Index].TitleId.."_BG.png"
							System.copyFile(old_bg, new_bg)
							break
						else
							old_bg = nil
						end
					end
					if old_bg == nil then
						NEUTRINO_DrawCacheStatus(Index)
						NEUTRINO_TempFile = io.open("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nobg.csv", "a")
						io.output(NEUTRINO_TempFile)
						io.write(NEUTRINO_Games[Index].TitleId..",")
						io.close(NEUTRINO_TempFile)
						NEUTRINO_Games[Index].BackGround = "default"
					end
				end
				NEUTRINO_DrawCacheStatus(Index)

			end
			NEUTRINO_CachedCount = NEUTRINO_CachedCount + 1
			if NEUTRINO_CachedCount == NEUTRINO_GamesTotal then
				Screen.clear()
				thmDrawBKG()
				thmDrawBKGOL()
				DrawSubMenu(actualCat,actualOption,false)
				Font.ftPrint(fontBig, 420, plusYValue+256, 11, 512, 64, neuLang[3]..NEUTRINO_CachedCount..neuLang[4]..neuLang[61], Color.new(255,255,255,128))

				Screen.waitVblankStart()
				Screen.flip()
			end

		elseif NEUTRINO_CachedStatus == true then
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
				NEUTRINO_Games[Index].Icon = "mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/DISC/"..NEUTRINO_Games[Index].TitleId..".png"
			else
				NEUTRINO_NDiscCount = NEUTRINO_NDiscCount + 1
			end
			if NEUTRINO_Games[Index].BackGround ~= "default" then
				NEUTRINO_Games[Index].BackGround = "mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/BG/"..NEUTRINO_Games[Index].TitleId..".png"
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
		thmDrawBKGOL()
		Font.ftPrint(fontBig, 352, plusYValue+256, 11, 612, 64, neuLang[52], Color.new(255,255,255,128))
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

NEUTRINO_TempFile = nil
NEUTRINO_TempFile = io.open(NEUTRINO_ListFile, "r")
if NEUTRINO_TempFile then
	for line in NEUTRINO_TempFile:lines() do
		if line ~= "" and string.match(line, "(.*) (.*)")then
			line = string.gsub(line, "\x0D", "")
			NEUTRINO_GamesTotal = NEUTRINO_GamesTotal+1
			NEUTRINO_TitleIdCount = NEUTRINO_TitleIdCount + 1
			NEUTRINO_Games[NEUTRINO_GamesTotal] = {};
			NEUTRINO_Games[NEUTRINO_GamesTotal].TitleId = string.sub(line, 1, 11)
			line = string.gsub(line, NEUTRINO_Games[NEUTRINO_GamesTotal].TitleId.." ", "")
			NEUTRINO_Games[NEUTRINO_GamesTotal].Folder, line = string.match(line, "(.*)/(.*)")
			NEUTRINO_Games[NEUTRINO_GamesTotal].Folder = string.sub(NEUTRINO_Games[NEUTRINO_GamesTotal].Folder, 2, 4)
			NEUTRINO_Games[NEUTRINO_GamesTotal].Name = string.sub(line, 1, -5)
			NEUTRINO_Games[NEUTRINO_GamesTotal].Extension = string.sub(line, string.len(line)-2, string.len(line))
			NEUTRINO_Games[NEUTRINO_GamesTotal].Media = string.lower(NEUTRINO_Games[NEUTRINO_GamesTotal].Folder)

		elseif line ~= "" then
			NEUTRINO_NewHash = line
		end
	end
end

function NEUTRINO_LoadIcon(firstOffest, lastOffset)
	for NEUTRINO_i = NEUTRINO_SelectedItem+firstOffest, NEUTRINO_SelectedItem+lastOffset do
		if NEUTRINO_CurrentList[NEUTRINO_i].Icon ~= "default" and NEUTRINO_i >= 1 and NEUTRINO_i <= NEUTRINO_CurrentTotal()
		then
			if themeInUse[NEUTRINO_CurrentList[NEUTRINO_i].IconSlot] > 0 then
				Graphics.freeImage(themeInUse[NEUTRINO_CurrentList[NEUTRINO_i].IconSlot])
				themeInUse[NEUTRINO_CurrentList[NEUTRINO_i].IconSlot] = 0
			end
			themeInUse[NEUTRINO_CurrentList[NEUTRINO_i].IconSlot] = Graphics.loadImage(NEUTRINO_CurrentList[NEUTRINO_i].Icon)
		end
	end

end

function NEUTRINO_CreateHash()
	NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder.."hash", "w")
	io.output(NEUTRINO_TempFile)
	io.write(NEUTRINO_NewHash)
	io.close(NEUTRINO_TempFile)
end
function NEUTRINO_CreateArt()
	NEUTRINO_DiscFolder = System.listDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/DISC/")
	NEUTRINO_BgFolder = System.listDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/BG/")
	NEUTRINO_ArtTotal = #NEUTRINO_DiscFolder + #NEUTRINO_BgFolder
	NEUTRINO_TempFile = io.open("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/lastart.cfg", "w")
	io.output(NEUTRINO_TempFile)
	io.write(NEUTRINO_ArtTotal)
	io.close(NEUTRINO_TempFile)
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

if NEUTRINO_CurrentTotal() == 0 or NEUTRINO_NewHash == nil then
	NEUTRINO_IsThereAnError = true
end

function NEUTRINO_ReadNoArt()
	if System.doesFileExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nobg.csv") then
		NEUTRINO_TempFile = io.open("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nobg.csv")
		NEUTRINO_NoBg = (NEUTRINO_TempFile:read())
		io.close(NEUTRINO_TempFile)
	else
		NEUTRINO_NoBg = ""
	end
	if System.doesFileExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nodisc.csv") then
		NEUTRINO_TempFile = io.open("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nodisc.csv")
		NEUTRINO_NoDisc = (NEUTRINO_TempFile:read())
		io.close(NEUTRINO_TempFile)
	else
		NEUTRINO_NoDisc = ""
	end
end

if not NEUTRINO_IsThereAnError then
	table.sort(NEUTRINO_Games, function (NEUTRINO_TempTabA, NEUTRINO_TempTabB) return NEUTRINO_TempTabA.Name < NEUTRINO_TempTabB.Name end)
	NEUTRINO_LoadingText(false, neuLang[46])
	NEUTRINO_DiscFolder = System.listDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/DISC/")
	NEUTRINO_LoadingText(false, neuLang[46])
	NEUTRINO_BgFolder = System.listDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/BG/")
	NEUTRINO_LoadingText(false, neuLang[46])
	NEUTRINO_ArtTotal = #NEUTRINO_DiscFolder + #NEUTRINO_BgFolder
	NEUTRINO_LoadingText(false, neuLang[46])

	if System.doesFileExist(NEUTRINO_DataFolder.."hash") then
		NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder.."hash", "r")
		NEUTRINO_OldHash = NEUTRINO_TempFile:read()
		io.close(NEUTRINO_TempFile)
		NEUTRINO_LoadingText(false, neuLang[46])
		if NEUTRINO_NewHash == NEUTRINO_OldHash then
			NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder.."lastgame.cfg", "r")
			NEUTRINO_SelectedItem = tonumber(NEUTRINO_TempFile:read())
			io.close(NEUTRINO_TempFile)
			NEUTRINO_LoadingText(false, neuLang[46])
			if System.doesFileExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/lastart.cfg") then
				NEUTRINO_TempFile = io.open("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/lastart.cfg", "r")
				tempTotal = tonumber(NEUTRINO_TempFile:read())
				io.close(NEUTRINO_TempFile)
				if NEUTRINO_ArtTotal == tempTotal then
					NEUTRINO_CachedStatus = true
				else
					NEUTRINO_PrepRecache()
				end
			else
				NEUTRINO_PrepRecache()
			end
		else
			NEUTRINO_CreateHash()
			NEUTRINO_PrepRecache()
		end
	else
		NEUTRINO_CreateHash()
		NEUTRINO_PrepRecache()
	end
	NEUTRINO_LoadingText(false, neuLang[62])

	if NEUTRINO_CachedStatus == true then
		NEUTRINO_ReadNoArt()
	end

	NEUTRINO_LoadingText(false, neuLang[62])
	for	NEUTRINO_i = 1, NEUTRINO_GamesTotal do
		NEUTRINO_GetFavorites(NEUTRINO_i)
		NEUTRINO_CacheArt(NEUTRINO_i)
	end
	NEUTRINO_LoadingText(false, neuLang[62])
	NEUTRINO_CreateArt()

	NEUTRINO_CurrentList = NEUTRINO_Games
	NEUTRINO_LinkedList = NEUTRINO_Favorites
	NEUTRINO_LoadingText(false, neuLang[62])
	NEUTRINO_InitList()
	NEUTRINO_LoadingText(false, neuLang[62])
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
	thmDrawBKGOL()
	DrawSubMenu(actualCat,actualOption,true)
	if NEUTRINO_IsThereAnError then
		Font.ftPrint(fontBig, 152, plusYValue+222, 0, 512, 64, xebLang[35], NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_i,baseColorFull,NEUTRINO_ColorFullZero))
		Font.ftPrint(fontSmall, 153, plusYValue+243, 0, 512, 64, neuLang[35]..NEUTRINO_ListFile..neuLang[59], NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_i,baseColorFull,NEUTRINO_ColorFullZero))
	else
		NEUTRINO_ItemPosition = -5
		for NEUTRINO_iB = NEUTRINO_SelectedItem-6, NEUTRINO_SelectedItem+5 do
			NEUTRINO_iB_Y = NEUTRINO_ItemPosition*71
			if NEUTRINO_iB == NEUTRINO_SelectedItem then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB], 152, 206, false, NEUTRINO_i, baseColorFull, NEUTRINO_ColorFullZero)
			else
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB], 152, NEUTRINO_iB_Y+135, true, NEUTRINO_i, baseColorFaded, NEUTRINO_ColorFadedZero)
			end
			NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+1
		end
	end
	spinDisc()

	Screen.waitVblankStart()
	oldpad = pad;
	Screen.flip()
end

NEUTRINO_Timer = 0
function NEUTRINO_UpdateFavorites()
	if System.doesFileExist("CFG/neutrinoLauncher/favorites.csv") then
		NEUTRINO_TempFile = io.open("CFG/neutrinoLauncher/favorites.csv", "r")
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
		NEUTRINO_LoadingText(false, neuLang[7])
		if NEUTRINO_FavoritesTotal == 1 then
			System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/favorites.csv")
		else
			NEUTRINO_TempFile = io.open("CFG/neutrinoLauncher/favorites.csv", "w")
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
		NEUTRINO_LoadingText(false, neuLang[8])
		NEUTRINO_TempFile = io.open("CFG/neutrinoLauncher/favorites.csv", "a")
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
			NEUTRINO_LoadingText(false, neuLang[13])
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
	oldpad = pad;
	for NEUTRINO_Move = 1, 3 do
		pad = Pads.get()
		Screen.clear()
		NEUTRINO_DrawMenu(true)
		DrawSubMenu(actualCat,actualOption,true)
		NEUTRINO_PositionUp = XEBMathRound(NEUTRINO_Move * 17.75)
		NEUTRINO_ItemPosition = -5
		for NEUTRINO_iB = NEUTRINO_SelectedItem-6, NEUTRINO_SelectedItem+5 do
			NEUTRINO_iB_Y = NEUTRINO_ItemPosition*71
			if NEUTRINO_iB == NEUTRINO_SelectedItem then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB], 152, NEUTRINO_iB_Y+135+NEUTRINO_PositionUp, 3,   NEUTRINO_Move, baseColorFaded, baseColorFull)
			elseif NEUTRINO_iB == NEUTRINO_SelectedItem-1 then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB], 152, NEUTRINO_iB_Y+135+NEUTRINO_PositionUp, 2,   NEUTRINO_Move, baseColorFull, baseColorFaded)
			else
				NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_iB], 152, NEUTRINO_iB_Y+135+NEUTRINO_PositionUp, true)
			end
			NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+speed
		end
		if not Pads.check(pad, PAD_UP) then
			NEUTRINO_HoldingUp=99
			NEUTRINO_HoldingUpDash=0
		end
		if NEUTRINO_Move ~= 3 then
			spinDisc()

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
	oldpad = pad;
	for NEUTRINO_Move = 1, 3 do
		NEUTRINO_MoveBack=4-NEUTRINO_Move
		pad = Pads.get()
		Screen.clear()
		NEUTRINO_DrawMenu(true)
		DrawSubMenu(actualCat,actualOption,true)
		NEUTRINO_PositionDown = XEBMathRound(NEUTRINO_Move * 17.75)
		NEUTRINO_ItemPosition = -5
		for NEUTRINO_iB = NEUTRINO_SelectedItem-6, NEUTRINO_SelectedItem+5 do
			NEUTRINO_iB_Y = NEUTRINO_ItemPosition*71
			if NEUTRINO_iB == NEUTRINO_SelectedItem then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB], 152, NEUTRINO_iB_Y+135-NEUTRINO_PositionDown, 2,   NEUTRINO_MoveBack, baseColorFull, baseColorFaded)
			elseif NEUTRINO_iB == NEUTRINO_SelectedItem+1 then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB], 152, NEUTRINO_iB_Y+135-NEUTRINO_PositionDown, 3,   NEUTRINO_MoveBack, baseColorFaded, baseColorFull)
			else
				NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_iB], 152, NEUTRINO_iB_Y+135-NEUTRINO_PositionDown, true)
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

			Screen.waitVblankStart()
			oldpad = pad;
			Screen.flip()
		end
	end
end
function NEUTRINO_SaveLast()
	NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder.."lastgame.cfg", "w")
	io.output(NEUTRINO_TempFile)
	if NEUTRINO_CurrentList == NEUTRINO_Games then
		io.write(NEUTRINO_SelectedItem)
	elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
		io.write(NEUTRINO_Favorites[NEUTRINO_SelectedItem].Link)
	end
	io.close(NEUTRINO_TempFile)
end

function ContextMenu_ReadSettings(Settings)
	if string.match(Settings, "(.*)cheat(.*)") then
		ContextMenu_Cheat = "-cheat"
		ContextMenu[3].Name = "\194\172  "..neuLang[65]
	else
		ContextMenu_Cheat = ""
		ContextMenu[3].Name = "     "..neuLang[65]
	end
	if string.match(Settings, "(.*)logo(.*)") then
		ContextMenu_Logo = " -logo"
		ContextMenu[4].Name = "\194\172  "..neuLang[14]
	else
		ContextMenu_Logo = ""
		ContextMenu[4].Name = "     "..neuLang[14]
	end
	if string.match(Settings, "(.*)dbc(.*)") then
		ContextMenu_Colors = " -dbc"
		ContextMenu[5].Name = "\194\172  "..neuLang[15]
	else
		ContextMenu_Colors = ""
		ContextMenu[5].Name = "     "..neuLang[15]
	end
	if string.match(Settings, "(.*)1(.*)") then
		ContextMenu_Accurate = "1"
		ContextMenu[6].Name = "\194\172  "..neuLang[16]
	else
		ContextMenu_Accurate = ""
		ContextMenu[6].Name = "     "..neuLang[16]
	end
	if string.match(Settings, "(.*)2(.*)") then
		ContextMenu_Sync = "2"
		ContextMenu[7].Name = "\194\172  "..neuLang[17]
	else
		ContextMenu_Sync = ""
		ContextMenu[7].Name = "     "..neuLang[17]
	end
	if string.match(Settings, "(.*)3(.*)") then
		ContextMenu_Unhook = "3"
		ContextMenu[8].Name = "\194\172  "..neuLang[18]
	else
		ContextMenu_Unhook = ""
		ContextMenu[8].Name = "     "..neuLang[18]
	end
	if string.match(Settings, "(.*)5(.*)") then
		ContextMenu_Emulate = "5"
		ContextMenu[9].Name = "\194\172  "..neuLang[19]
	else
		ContextMenu_Emulate = ""
		ContextMenu[9].Name = "     "..neuLang[19]
	end
end
ContextMenu_FirstRun = true
function NEUTRINO_ContextMenu()
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
		ContextMenu[10] = {};
		ContextMenu[1].Description = neuLang[20]
		ContextMenu[2].Description = neuLang[21]
		ContextMenu[3].Description = neuLang[66]
		ContextMenu[4].Description = neuLang[22]
		ContextMenu[5].Description = neuLang[23]
		ContextMenu[6].Description = neuLang[24]
		ContextMenu[7].Description = neuLang[25]
		ContextMenu[8].Description = neuLang[26]
		ContextMenu[9].Description = neuLang[27]
		ContextMenu[10].Description = neuLang[28]
		if NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId == "" or NEUTRINO_CurrentList == NEUTRINO_Favorites then
			ContextMenu_AllItems = 9
		else
			ContextMenu_AllItems = 10
		end

		if System.doesFileExist(NEUTRINO_DataFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg") then
			NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg", r)
			ContextMenu_LocalSettings = (NEUTRINO_TempFile:read())
			io.close(NEUTRINO_TempFile)
		else
			ContextMenu_LocalSettings = 0
		end
		if System.doesFileExist("CFG/neutrinoLauncher/neutrinoLaunchOptions.cfg") then
			NEUTRINO_TempFile = io.open("CFG/neutrinoLauncher/neutrinoLaunchOptions.cfg", "r")
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
		ContextMenu[10].Name = neuLang[33]
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
			NEUTRINO_DrawMenu(false)
			DrawSubMenu(actualCat,actualOption,true)

			moveb=move*25
			movec=310-move*31
			for i = 1, howMuchRedrawTransparencyLayer do
				Graphics.drawImageExtended(themeInUse[-3], 352, 240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, moveb)
			end
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
	if ContextMenu_HasMoved == 1 then
		NEUTRINO_DrawMenu(false)
		DrawSubMenu(actualCat,actualOption,true)

		for i = 1, howMuchRedrawTransparencyLayer do
			Graphics.drawImageExtended(themeInUse[-3], 352, 240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
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
				if ContextMenu_Cheat == "" then
					ContextMenu[3].Name = "\194\172  "..neuLang[65]
					ContextMenu_Cheat = "-cheat"
				else
					ContextMenu[3].Name = "     "..neuLang[65]
					ContextMenu_Cheat = ""
				end
			elseif ContextMenu_SelectedItem == 4 then
				if ContextMenu_Logo == "" then
					ContextMenu[4].Name = "\194\172  "..neuLang[14]
					ContextMenu_Logo = " -logo"
				else
					ContextMenu[4].Name = "     "..neuLang[14]
					ContextMenu_Logo = ""
				end
			elseif ContextMenu_SelectedItem == 5 then
				if ContextMenu_Colors == "" then
					ContextMenu[5].Name = "\194\172  "..neuLang[15]
					ContextMenu_Colors = " -dbc"
				else
					ContextMenu[5].Name = "     "..neuLang[15]
					ContextMenu_Colors = ""
				end
			elseif ContextMenu_SelectedItem == 6 then
				if ContextMenu_Accurate == "" then
					ContextMenu[6].Name = "\194\172  "..neuLang[16]
					ContextMenu_Accurate = "1"
				else
					ContextMenu[6].Name = "     "..neuLang[16]
					ContextMenu_Accurate = ""
				end
			elseif ContextMenu_SelectedItem == 7 then
				if ContextMenu_Sync == "" then
					ContextMenu[7].Name = "\194\172  "..neuLang[17]
					ContextMenu_Sync = "2"
				else
					ContextMenu[7].Name = "     "..neuLang[17]
					ContextMenu_Sync = ""
				end
			elseif ContextMenu_SelectedItem == 8 then
				if ContextMenu_Unhook == "" then
					ContextMenu[8].Name = "\194\172  "..neuLang[18]
					ContextMenu_Unhook = "3"
				else
					ContextMenu[8].Name = "     "..neuLang[18]
					ContextMenu_Unhook = ""
				end
			elseif ContextMenu_SelectedItem == 9 then
				if ContextMenu_Emulate == "" then
					ContextMenu[9].Name = "\194\172  "..neuLang[19]
					ContextMenu_Emulate = "5"
				else
					ContextMenu[9].Name = "     "..neuLang[19]
					ContextMenu_Emulate = ""
				end
			elseif ContextMenu_SelectedItem == 10 then
				if NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId ~= "" then
					NEUTRINO_CachedCount = 0
					System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/DISC/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId..".png")
					System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/BG/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId..".png")
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
							System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nodisc.csv")
						else
							NEUTRINO_TempFile = io.open("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nodisc.csv", "w")
							io.output(NEUTRINO_TempFile)
							io.write(NEUTRINO_NewDiscs)
							io.close(NEUTRINO_TempFile)
						end
					end
					if RemoveBg == true then
						if NEUTRINO_NewBgs == "" or NEUTRINO_NewBgs == nil then 
							System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nobg.csv")
						else
							NEUTRINO_TempFile = io.open("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/nobg.csv", "w")
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
					NEUTRINO_TempFile = io.open("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/lastart.cfg", "w")
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
		ContextMenu_NewSettings = ContextMenu_Cheat
		ContextMenu_NewSettings = ContextMenu_NewSettings.."-gc="..ContextMenu_Disable
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Accurate
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Sync
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Unhook
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Emulate
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Colors
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Logo

		if ContextMenu_Global == false and ContextMenu_NewSettings ~= ContextMenu_LocalSettings and ContextMenu_UpdateFavorties == false then
			NEUTRINO_LoadingText(false, neuLang[34])
			NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg", "w")
			io.output(NEUTRINO_TempFile)
			io.write(ContextMenu_NewSettings)
			io.close(NEUTRINO_TempFile)
		elseif ContextMenu_Global == true then
			NEUTRINO_LoadingText(false, neuLang[34])
			if ContextMenu_NewSettings ~= ContextMenu_GlobalSettings then
				NEUTRINO_TempFile = io.open("CFG/neutrinoLauncher/neutrinoLaunchOptions.cfg", "w")
				io.output(NEUTRINO_TempFile)
				io.write(ContextMenu_NewSettings)
				io.close(NEUTRINO_TempFile)
			end
			if ContextMenu_LocalSettings ~= 0 then
				System.removeFile(NEUTRINO_DataFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg")
			end
		end

		for move = 1, 10 do
			Screen.clear()
			NEUTRINO_DrawMenu(false)
			DrawSubMenu(actualCat,actualOption,true)


			moveb=move*25
			movec=move*31
			for i = 1, howMuchRedrawTransparencyLayer do
				Graphics.drawImageExtended(themeInUse[-3], 352, 240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255-moveb)
			end
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
			NEUTRINO_LoadingText(false, neuLang[13])
			if themeInUse[-90] > 0 then
				Graphics.freeImage(themeInUse[-90])
				themeInUse[-90] = 0
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
	--NEUTRINO_Debug = System.getFreeMemory()
	pad = Pads.get()
	if XEBKeepInContextMenu == true then
		goto contexMenu
	end
	Screen.clear()
	if NEUTRINO_CurrentTotal() == 0 or NEUTRINO_NewHash == nil then
		NEUTRINO_IsThereAnError = true
	else
		NEUTRINO_IsThereAnError = false
	end
	NEUTRINO_DrawMenu(false)
	DrawSubMenu(actualCat,actualOption,true)
	if NEUTRINO_IsThereAnError then
		thmDrawBKGOL()
		if NEUTRINO_CurrentList == NEUTRINO_Games then
			Font.ftPrint(fontBig, 152, plusYValue+222, 0, 512, 64, xebLang[35], baseColorFull)
			Font.ftPrint(fontSmall, 153, plusYValue+243, 0, 512, 64, neuLang[35]..NEUTRINO_ListFile..neuLang[59], baseColorFull)
		elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
			Font.ftPrint(fontBig, 152, plusYValue+222, 0, 512, 64, xebLang[35], baseColorFull)
			Font.ftPrint(fontSmall, 153, plusYValue+243, 0, 512, 64, neuLang[47], baseColorFull)
			Graphics.drawImage(themeInUse[-95], 500, plusYValue+400)
			Graphics.drawImage(themeInUse[-96], 506, plusYValue+400)
			Font.ftPrint(fontSmall, 543, plusYValue+405, 0, 400, 64, neuLang[10], baseColorFull)
		end
	else
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
						NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_iB], 152, NEUTRINO_iB_Y+135, true)
					end
					NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+1
				end
				spinDisc()

				Graphics.drawRect(352, 240, 704, 480, Color.new(0,0,0,NEUTRINO_WaveByeBye*10))
				NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_SelectedItem], 152, 206, false)
				Screen.waitVblankStart()
				Screen.flip()
			end
			for NEUTRINO_WaveByeBye = 1, 25 do
				Screen.clear()
				NEUTRINO_DrawItem(NEUTRINO_CurrentList[NEUTRINO_SelectedItem], 152, 206, false)
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
			
			NEUTRINO_VMCParam = ""
			if string.match(NEUTRINO_Bsd, "(.*)udp(.*)") and System.doesFileExist("CFG/neutrinoLauncher/enable-VMC-UDPBD.list") and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId ~= "" and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId ~= nil then
				NEUTRINO_TempFile = io.open("mass:/XEBPLUS/CFG/neutrinoLauncher/enable-VMC-UDPBD.list", "r")
				if NEUTRINO_TempFile then
					for line in NEUTRINO_TempFile:lines() do
						if string.match(line, NEUTRINO_NewHash) then
							NEUTRINO_VMCParam = " \"-mc0=mass:/VMC/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId.."_0.bin\""
						end
					end
				end
				io.close(NEUTRINO_TempFile)
			end
			
			if System.doesFileExist(NEUTRINO_DataFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg") then
				NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg", "r")
				NEUTRINO_LaunchOptions = (NEUTRINO_TempFile:read())
				io.close(NEUTRINO_TempFile)
			elseif System.doesFileExist("CFG/neutrinoLauncher/neutrinoLaunchOptions.cfg") then
				NEUTRINO_TempFile = io.open("CFG/neutrinoLauncher/neutrinoLaunchOptions.cfg", "r")
				NEUTRINO_LaunchOptions = (NEUTRINO_TempFile:read())
				io.close(NEUTRINO_TempFile)
			else
				NEUTRINO_LaunchOptions = ""
				NEUTRINO_LoadingText(false, neuLang[40])
			end
			if string.match(NEUTRINO_LaunchOptions, "(.*)cheat(.*)") then
				NEUTRINO_LaunchOptions = string.sub(NEUTRINO_LaunchOptions, 7, string.len(NEUTRINO_LaunchOptions))
				NEUTRINO_Cheats = true
			end

			if NEUTRINO_PathPrefix ~= "mass" then
				NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder = ""
			end

			NEUTRINO_RadShellText = "fontsize 0.6\r\necho \"Starting "..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".iso\"\r\nsleep 1\r\nrun neutrino.elf -bsd="..NEUTRINO_Bsd.." -bsdfs="..NEUTRINO_Fs.." \"-dvd="..NEUTRINO_PathPrefix..":"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder.."/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name.."."..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Extension.."\""..NEUTRINO_VMCParam.." -mt="..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Media.." "..NEUTRINO_LaunchOptions.."\r\n"

			--NEUTRINO_RadShellFile = System.openFile(xebLua_AppWorkingPath.."radshellmod.ios", FRDWR)
			System.removeFile(xebLua_AppWorkingPath.."radshellmod.ios")
			--System.closeFile(NEUTRINO_RadShellFile)
			NEUTRINO_RadShellFile = System.openFile(xebLua_AppWorkingPath.."radshellmod.ios", FCREATE)
			System.writeFile(NEUTRINO_RadShellFile, NEUTRINO_RadShellText, string.len(NEUTRINO_RadShellText))
			System.closeFile(NEUTRINO_RadShellFile)
			NEUTRINO_SaveLast()
			if NEUTRINO_Cheats == true then
				NEUTRINO_CheatFile = "mass:CHT/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId..".cht"

				NEUTRINO_CheatDeviceText = "[CheatDevicePS2]\ndatabaseReadOnly = "..NEUTRINO_CheatFile.."\ndatabaseReadWrite =\nboot1 = mass:XEBPLUS/APPS/neutrinoLauncher/radshellmod.elf\nboot2 = \xE2\x81\xA0\nboot3 = \xE2\x81\xA0\nboot4 = \xE2\x81\xA0\nboot5 = \xE2\x81\xA0"

				System.removeFile(xebLua_AppWorkingPath.."/CheatDevice/CheatDevicePS2.ini")
				NEUTRINO_CheatDeviceFile = System.openFile(xebLua_AppWorkingPath.."/CheatDevice/CheatDevicePS2.ini", FCREATE)
				System.writeFile(NEUTRINO_CheatDeviceFile, NEUTRINO_CheatDeviceText, string.len(NEUTRINO_CheatDeviceText))
				System.closeFile(NEUTRINO_CheatDeviceFile)

				System.loadELF(xebLua_AppWorkingPath.."CheatDevice/CheatDevice-EXFAT.ELF")
			else
				System.loadELF(xebLua_AppWorkingPath.."radshellmod.elf")
			end
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
					NEUTRINO_LoadingText(false, neuLang[6])
					NEUTRINO_LoadIcon(0, 5)
				end
				NEUTRINO_Scrolling = false
			elseif (NEUTRINO_SelectedItem - 5) < 1 then
				AnimateCount = math.abs(1 - NEUTRINO_SelectedItem)
			else
				AnimateCount = 5
			end
			if AnimateCount > 0 then
				for i = AnimateCount,1,-1 do
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem - 1
					if i % 2 == 0 then
						NEUTRINO_AnimateUp(2)
					end
					if i == 1 and not Pads.check(pad, PAD_L1) then
						NEUTRINO_LoadingText(false, neuLang[6])
						NEUTRINO_LoadIcon(-6, 5)
						NEUTRINO_Scrolling = false
					end
				end
			end
			::L1End::
		elseif Pads.check(pad, PAD_R1) and not Pads.check(pad, PAD_L1) and not Pads.check(oldpad, PAD_L1)then
			NEUTRINO_Scrolling = true
			AnimateCount = 0
			if NEUTRINO_SelectedItem == NEUTRINO_CurrentTotal() then
				if not Pads.check(oldpad, PAD_R1) then
					NEUTRINO_SelectedItem = 1
					NEUTRINO_LoadingText(false, neuLang[6])
					NEUTRINO_LoadIcon(0, 5)
					NEUTRINO_Scrolling = false
					NEUTRINO_AnimateDown(1)
					goto R1End
				end
				NEUTRINO_SelectedItem = NEUTRINO_CurrentTotal()
				if NEUTRINO_SelectedItem ~= NEUTRINO_OldItem then
					NEUTRINO_LoadingText(false, neuLang[6])
					NEUTRINO_LoadIcon(-6, 0)
				end
				NEUTRINO_Scrolling = false
			elseif (NEUTRINO_SelectedItem + 5) > NEUTRINO_CurrentTotal() then
				AnimateCount = NEUTRINO_CurrentTotal() - NEUTRINO_SelectedItem
			else
				AnimateCount = 5
			end
			if AnimateCount > 0 then
				for i = AnimateCount,1,-1 do
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem + 1
					if i % 2 == 0 then
						NEUTRINO_AnimateDown(2)
					end
					if i == 1 and not Pads.check(pad, PAD_R1) then
						NEUTRINO_LoadingText(false, neuLang[6])
						NEUTRINO_LoadIcon(-6, 5)
						NEUTRINO_Scrolling = false
					end
				end
			end
			::R1End::
		elseif Pads.check(pad, PAD_L2) and not Pads.check(pad, PAD_R2) and not Pads.check(oldpad, PAD_R2) then
			NEUTRINO_Scrolling = true
			AnimateCount = 0
			if NEUTRINO_SelectedItem == 1 then
				if not Pads.check(oldpad, PAD_L2) then
					NEUTRINO_SelectedItem = NEUTRINO_CurrentTotal()
					NEUTRINO_LoadIcon(-6, 0)
					NEUTRINO_Scrolling = false
					NEUTRINO_AnimateUp(1)
					goto L2End
				end
				NEUTRINO_SelectedItem = 1
				if NEUTRINO_SelectedItem ~= NEUTRINO_OldItem then
					NEUTRINO_LoadingText(false, neuLang[6])
					NEUTRINO_LoadIcon(0, 15)
				end
				NEUTRINO_Scrolling = false
			elseif (NEUTRINO_SelectedItem - 15) < 1 then
				AnimateCount = math.abs(1 - NEUTRINO_SelectedItem)
			else
				AnimateCount = 15
			end
			if AnimateCount > 0 then
				for i = AnimateCount,1,-1 do
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem - 1
					if i % 2 == 0 then
						NEUTRINO_AnimateUp(2)
					end
					if i == 1 and not Pads.check(pad, PAD_L2) then
						NEUTRINO_LoadingText(false, neuLang[6])
						NEUTRINO_LoadIcon(-6, 5)
						NEUTRINO_Scrolling = false
					end
				end
			end
			::L2End::
		elseif Pads.check(pad, PAD_R2) and not Pads.check(pad, PAD_L2) and not Pads.check(oldpad, PAD_L2)then
			NEUTRINO_Scrolling = true
			AnimateCount = 0
			if NEUTRINO_SelectedItem == NEUTRINO_CurrentTotal() then
				if not Pads.check(oldpad, PAD_R2) then
					NEUTRINO_SelectedItem = 1
					NEUTRINO_LoadingText(false, neuLang[6])
					NEUTRINO_LoadIcon(0, 15)
					NEUTRINO_Scrolling = false
					NEUTRINO_AnimateDown(1)
					goto R2End
				end
				NEUTRINO_SelectedItem = NEUTRINO_CurrentTotal()
				if NEUTRINO_SelectedItem ~= NEUTRINO_OldItem then
					NEUTRINO_LoadingText(false, neuLang[6])
					NEUTRINO_LoadIcon(-6, 0)
				end
				NEUTRINO_Scrolling = false
			elseif (NEUTRINO_SelectedItem + 15) > NEUTRINO_CurrentTotal() then
				AnimateCount = NEUTRINO_CurrentTotal() - NEUTRINO_SelectedItem
			else
				AnimateCount = 15
			end
			if AnimateCount > 0 then
				for i = AnimateCount,1,-1 do
					NEUTRINO_SelectedItem = NEUTRINO_SelectedItem + 1
					if i % 2 == 0 then
						NEUTRINO_AnimateDown(2)
					end
					if i == 1 and not Pads.check(pad, PAD_R2) then
						NEUTRINO_LoadingText(false, neuLang[6])
						NEUTRINO_LoadIcon(-6, 5)
						NEUTRINO_Scrolling = false
					end
				end
			end
			::R2End::
		elseif Pads.check(pad, PAD_L3) and NEUTRINO_newLetter ~= NEUTRINO_currentLetter and not Pads.check(oldpad, PAD_L3) then
			NEUTRINO_currentLetter = string.sub(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name, 1, 1)
			NEUTRINO_newLetter = NEUTRINO_currentLetter
			i = NEUTRINO_SelectedItem
			while NEUTRINO_newLetter == NEUTRINO_currentLetter and i > 0 do
				i = i - 1
				NEUTRINO_newLetter = string.sub(NEUTRINO_CurrentList[i].Name, 1, 1)
			end
			NEUTRINO_currentLetter = NEUTRINO_newLetter
			while NEUTRINO_newLetter == NEUTRINO_currentLetter and i > 0 do
				i = i - 1
				NEUTRINO_newLetter = string.sub(NEUTRINO_CurrentList[i].Name, 1, 1)
			end
			NEUTRINO_LoadingText(false, neuLang[6])
			NEUTRINO_SelectedItem = i + 1
			NEUTRINO_LoadIcon(-6, 5)
		elseif Pads.check(pad, PAD_R3) and NEUTRINO_newLetter ~= NEUTRINO_currentLetter and not Pads.check(oldpad, PAD_R3) then
			NEUTRINO_currentLetter = string.sub(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name, 1, 1)
			NEUTRINO_newLetter = NEUTRINO_currentLetter
			i = NEUTRINO_SelectedItem
			while NEUTRINO_newLetter == NEUTRINO_currentLetter and i < NEUTRINO_CurrentTotal() do
				i = i + 1
				NEUTRINO_newLetter = string.sub(NEUTRINO_CurrentList[i].Name, 1, 1)
			end
			NEUTRINO_LoadingText(false, neuLang[6])
			NEUTRINO_SelectedItem = i
			NEUTRINO_LoadIcon(-6, 5)
		elseif  Pads.check(pad, PAD_SQUARE) and not Pads.check(oldpad, PAD_SQUARE)then
			XEBKeepInContextMenu = true
			ContextMenu_HasMoved = 0
		end
		end
	end
	if Pads.check(pad, PAD_CANCEL) and not Pads.check(oldpad, PAD_CANCEL) or Pads.check(pad, PAD_LEFT) and not Pads.check(oldpad, PAD_LEFT) then
		if NEUTRINO_ShowHelp == false then
			if NEUTRINO_IsThereAnError == false then
				NEUTRINO_LoadingText(false, neuLang[34])
				NEUTRINO_SaveLast()
			end
			XEBKeepInSubMenu=false
		end
	elseif Pads.check(pad, PAD_TRIANGLE) and not Pads.check(oldpad, PAD_TRIANGLE) then
			NEUTRINO_Timer = nil
			if themeInUse[-90] > 0 and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround ~= "default" and NEUTRINO_IsThereAnError == false then
				Graphics.freeImage(themeInUse[-90])
				themeInUse[-90] = 0
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
				NEUTRINO_LoadingText(false, neuLang[41])
			elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
				NEUTRINO_FavoritesSelected = NEUTRINO_SelectedItem
				NEUTRINO_CurrentList = NEUTRINO_Games
				NEUTRINO_LinkedList = NEUTRINO_Favorites
				if NEUTRINO_GamesSelected then
					NEUTRINO_SelectedItem = NEUTRINO_GamesSelected
				else
					NEUTRINO_SelectedItem = 1
				end
				NEUTRINO_LoadingText(false, neuLang[42])
			end
			NEUTRINO_InitList()
			NEUTRINO_LoadingText(false, neuLang[6])
			NEUTRINO_Timer = 0
	elseif  Pads.check(pad, PAD_SELECT) and not Pads.check(oldpad, PAD_SELECT)then
		if NEUTRINO_ShowHelp == false then
			NEUTRINO_ShowHelp = true
		end
	end
	spinDisc()

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
	thmDrawBKGOL()
	DrawSubMenu(actualCat,actualOption,true)
	NEUTRINO_ReverseFrame=4-NEUTRINO_i
	if NEUTRINO_IsThereAnError then
		Font.ftPrint(fontBig, 152, plusYValue+222, 0, 512, 64, xebLang[35], NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_ReverseFrame,baseColorFull,NEUTRINO_ColorFullZero))
		Font.ftPrint(fontSmall, 153, plusYValue+243, 0, 512, 64, neuLang[35]..NEUTRINO_ListFile..neuLang[59], NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_ReverseFrame,baseColorFull,NEUTRINO_ColorFullZero))
	else
		NEUTRINO_ItemPosition = -5
		for NEUTRINO_iB = NEUTRINO_SelectedItem-6, NEUTRINO_SelectedItem+5 do
			NEUTRINO_iB_Y = NEUTRINO_ItemPosition*71
			if NEUTRINO_iB == NEUTRINO_SelectedItem then
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB], 152, 206, false, NEUTRINO_ReverseFrame, baseColorFull, NEUTRINO_ColorFullZero)
			else
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB], 152, NEUTRINO_iB_Y+135, true,   NEUTRINO_ReverseFrame, baseColorFaded, NEUTRINO_ColorFadedZero)
			end
			NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+1
		end
	end
	spinDisc()
	Screen.waitVblankStart()
	oldpad = pad;
	Screen.flip()
end
for NEUTRINO_i = -90, -111 do
	if themeInUse[NEUTRINo_i] > 0 then
		Graphics.freeImage(themeInUse[NEUTRINO_i])
	end
end
NEUTRINO_Timer = nil

BackFromSubMenuIcon(actualCat,actualOption,true)
pad = Pads.get()
Screen.clear()
if backgroundFilter then
	Graphics.drawImageExtended(themeInUse[-1], 352, plusYValue+240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
else
	Graphics.drawImage(themeInUse[-1], 0, plusYValue+0)
end
thmDrawBKG()
thmDrawBKGOL()
DrawInterface(actualCat,actualOption,true)
spinDisc()
spinSpeed = 0
imanoSpin=0

oldpad = pad;
