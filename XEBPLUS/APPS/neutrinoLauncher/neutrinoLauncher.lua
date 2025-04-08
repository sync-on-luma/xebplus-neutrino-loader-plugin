--------------------------------------------------------
-- NEUTRINO LAUNCHER
--------------------------------------------------------
GoToSubMenuIcon(actualCat,actualOption,true)
XEBKeepInSubMenu=true
XEBKeepInContextMenu=false

function NEUTRINO_ShowDebug(message)
	Screen.clear()
	if NEUTRINO_Debug ~= nil then
		Font.ftPrint(fontBig, 280, plusYValue+390, 11, 620, 64, message, baseColorFull)
	end
	Screen.waitVblankStart()
	Screen.flip()
end

if System.doesFileExist("CFG/neutrinoLauncher/menu.cfg") then
    ContextMenu_TempFile = io.open("CFG/neutrinoLauncher/menu.cfg", "r")
    NEUTRINO_Settings = (ContextMenu_TempFile:read())
    io.close(ContextMenu_TempFile)
else
    NEUTRINO_Settings = ""
end
if string.match(NEUTRINO_Settings, "(.*)1(.*)") then
	NEUTRINO_DisableDisc = true
else
	NEUTRINO_DisableDisc = false
end
if string.match(NEUTRINO_Settings, "(.*)8(.*)") then
	NEUTRINO_DisableBg = true
else
	NEUTRINO_DisableBg = false
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
NEUTRINO_Debug = "debug"
NEUTRINO_Scrolling = false
NEUTRINO_ScrollCount = 0

function NEUTRINO_PrepDraw(NEUTRINO_TempGame)
	if NEUTRINO_ShowTitleId == false then
		NEUTRINO_TempTitleId = ""
	else
		NEUTRINO_TempTitleId = NEUTRINO_TempGame.TitleId
	end
	if NEUTRINO_TempGame.IconSlot == 0 or NEUTRINO_Scrolling == true or themeInUse[NEUTRINO_TempGame.IconSlot] == 0 or themeInUse[NEUTRINO_TempGame.IconSlot] == nil then
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
				Graphics.drawImageExtended(NEUTRINO_SetIcon, NEUTRINO_TempX+32, plusYValue+NEUTRINO_TempY+32, 0, 0,  Graphics.getImageWidth(NEUTRINO_SetIcon), Graphics.getImageHeight(NEUTRINO_SetIcon), 42, 42, 0, columnsFade)
			else
				Graphics.drawImage(NEUTRINO_SetIcon, NEUTRINO_TempX, plusYValue+NEUTRINO_TempY, columnsFade)
			end
			Font.ftPrint(fontSmall, NEUTRINO_TempX+70, plusYValue+NEUTRINO_TempY+32, 0, 512, 64, NEUTRINO_TempTitleId.." "..NEUTRINO_Seperator.." "..NEUTRINO_TempMedia, baseColorFaded)
		end
		Font.ftPrint(fontBig, NEUTRINO_TempX+69, plusYValue+NEUTRINO_TempY+16, 0, 512, 64, NEUTRINO_TempName, baseColorFaded)
	else
		if NEUTRINO_TempName ~= "" then
			if NEUTRINO_SetIcon == themeInUse[NEUTRINO_TempGame.IconSlot] then
				Graphics.drawImageExtended(NEUTRINO_SetIcon, NEUTRINO_TempX+32, plusYValue+NEUTRINO_TempY+32, 0, 0,  Graphics.getImageWidth(NEUTRINO_SetIcon), Graphics.getImageHeight(NEUTRINO_SetIcon), 42, 42, imanoSpin, 255)
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
			Graphics.drawImageExtended(NEUTRINO_SetIcon, NEUTRINO_TempX+32, plusYValue+NEUTRINO_TempY+32, 0, 0,  Graphics.getImageWidth(NEUTRINO_SetIcon), Graphics.getImageWidth(NEUTRINO_SetIcon), 42, 42, 0, TempAlpha)
		else
			Graphics.drawImage(NEUTRINO_SetIcon, NEUTRINO_TempX, plusYValue+NEUTRINO_TempY, TempAlpha)
		end
		Font.ftPrint(fontSmall, NEUTRINO_TempX+70, plusYValue+NEUTRINO_TempY+32, 0, 512, 64, NEUTRINO_TempTitleId.." "..NEUTRINO_Seperator.." "..NEUTRINO_TempMedia, NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_TempTheFrame, NEUTRINO_TempTheColorA, NEUTRINO_TempTheColorB))
	end
	Font.ftPrint(fontBig, NEUTRINO_TempX+69, plusYValue+NEUTRINO_TempY+16, 0, 512, 64, NEUTRINO_TempName, NEUTRINO_ColorGetAnimationAlpha(NEUTRINO_TempTheFrame,NEUTRINO_TempTheColorA,NEUTRINO_TempTheColorB))
end

function NEUTRINO_DrawHelp()
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

function NEUTRINO_DrawBKG()
	if backgroundFilter then
		Graphics.drawImageExtended(themeInUse[-1], 352, plusYValue+240, 0, 0, backgroundValueX, backgroundValueY, 704, 480, 0, 255)
	else
		Graphics.drawImage(themeInUse[-1], 0, plusYValue+0)
	end
end

function NEUTRINO_DrawTitleBar()
	Graphics.drawImage(themeInUse[-94], NEUTRINO_BoxPos, plusYValue+22)
	if NEUTRINO_CurrentList == NEUTRINO_Games then
		Font.ftPrint(fontMid, NEUTRINO_HeaderPos, plusYValue+45, 0, 400, 64, neuLang[10].." - "..NEUTRINO_SelectedItem..neuLang[9]..NEUTRINO_GamesTotal, baseColorFull)
	elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
		Font.ftPrint(fontMid, 495, plusYValue+45, 0, 400, 64, neuLang[11]..NEUTRINO_SelectedItem..neuLang[9]..NEUTRINO_FavoritesTotal, baseColorFull)
	elseif NEUTRINO_CurrentList == NEUTRINO_Recents then
		Font.ftPrint(fontMid, NEUTRINO_RecentPos, plusYValue+45, 0, 400, 64, neuLang[68]..NEUTRINO_SelectedItem..neuLang[9]..NEUTRINO_RecentsTotal, baseColorFull)
	end
	Graphics.drawImage(themeInUse[-95], 500, plusYValue+400)
	Graphics.drawImage(themeInUse[-93], 506, plusYValue+400)
	Font.ftPrint(fontSmall, 543, plusYValue+405, 0, 400, 64, neuLang[12], baseColorFull)
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
		Graphics.drawImage(themeInUse[-91], 152, 186, NEUTRINO_BgAlpha)

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
	NEUTRINO_DrawTitleBar()

end

function NEUTRINO_DrawMenu(Animate)
	NEUTRINO_DrawBKG()
	thmDrawBKG()
	if not NEUTRINO_IsThereAnError and NEUTRINO_HoldingUp > 1 and NEUTRINO_HoldingDown > 1 then
		if NEUTRINO_SelectedItem == NEUTRINO_OldItem then
			NEUTRINO_Timer = NEUTRINO_Timer+1
		else
			NEUTRINO_Fade = "out"
			NEUTRINO_Timer = 0
		end

		NEUTRINO_DrawUnderlay(Animate)

		if NEUTRINO_Scrolling == false then
			if NEUTRINO_Timer == 7 and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround ~= "default" and themeInUse[-90] == 0 then
				NEUTRINO_LoadingText(false, neuLang[13])
				NEUTRINO_Fade = "in"
				themeInUse[-90] = Graphics.loadImage(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround)
				if NEUTRINO_DisableAnimate == false then
					spinSpeed = 0.24
				end
			elseif NEUTRINO_Timer == 7 then
				NEUTRINO_Fade = "in"
				NEUTRINO_Timer = 0
				themeInUse[-90] = 0
				if NEUTRINO_DisableAnimate == false then
					spinSpeed = 0.17
				end
			end
			NEUTRINO_OldItem=NEUTRINO_SelectedItem
		end

		while NEUTRINO_ShowHelp == true do
			NEUTRINO_DrawHelp()
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
if System.doesFileExist(NEUTRINO_DataFolder.."recent.csv") then
	NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder.."recent.csv", "r")
	NEUTRINO_Recent = NEUTRINO_TempFile:read()
	io.close(NEUTRINO_TempFile)
else
	NEUTRINO_Recent = ""
	NEUTRINO_SelectedItem = 1
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
	NEUTRINO_DisableDisc = true
	NEUTRINO_DisableBg = true
end

themeInUse[-91] = Graphics.loadImage(xebLua_AppWorkingPath.."image/dropshadow.png")
if buttonSettings == "X" then
    themeInUse[-92] = Graphics.loadImage(xebLua_AppWorkingPath..NEUTRINO_Control1)
elseif buttonSettings == "O" then
    themeInUse[-92] = Graphics.loadImage(xebLua_AppWorkingPath..NEUTRINO_Control2)
end
themeInUse[-93] = Graphics.loadImage(xebLua_AppWorkingPath.."image/select.png")
themeInUse[-94] = Graphics.loadImage(xebLua_AppWorkingPath.."image/box.png")
themeInUse[-95] = Graphics.loadImage(xebLua_AppWorkingPath.."image/button.png")

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

NEUTRINO_ShowHelp = false

NEUTRINO_ColorFullZero=Color.new(Color.getR(baseColorFull),Color.getG(baseColorFull),Color.getB(baseColorFull),0)
NEUTRINO_ColorFadedZero=Color.new(Color.getR(baseColorFaded),Color.getG(baseColorFaded),Color.getB(baseColorFaded),0)

NEUTRINO_IsThereAnError = false
NEUTRINO_FoundGames=false
NEUTRINO_GamesTotal = 0
NEUTRINO_FavoritesTotal = 0
NEUTRINO_RecentsTotal = 0
NEUTRINO_Games = {};
NEUTRINO_Favorites = {};
NEUTRINO_Recents = {};
NEUTRINO_Vmc = ""
NEUTRINO_CurrentList = NEUTRINO_Games
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
				NEUTRINO_Favorites[NEUTRINO_FavoritesTotal].Vmc = NEUTRINO_Games[Index].Vmc
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
	if System.doesDirectoryExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache") then
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
			if NEUTRINO_DisableDisc == false then
				for NEUTRINO_i in string.gmatch(NEUTRINO_NoDisc, "[^,]+") do
					if NEUTRINO_i == NEUTRINO_Games[Index].TitleId then
						NEUTRINO_Games[Index].Icon = "default"
						NEUTRINO_NoDisc = string.sub(NEUTRINO_NoDisc, 13)
						break
					end
				end
			else
				NEUTRINO_Games[Index].Icon = "default"
			end
			if NEUTRINO_DisableBg == false then
				for NEUTRINO_i in string.gmatch(NEUTRINO_NoBg, "[^,]+") do
					if NEUTRINO_i == NEUTRINO_Games[Index].TitleId then
						NEUTRINO_Games[Index].BackGround = "default"
						NEUTRINO_NoBg = string.sub(NEUTRINO_NoBg, 13)
						break
					end
				end
			else
				NEUTRINO_Games[Index].BackGround = "default"
			end
		end
		
		if NEUTRINO_Games[Index].TitleId == "" then
				NEUTRINO_Games[Index].Icon = "default"
				NEUTRINO_Games[Index].BackGround = "default"
		else
			if NEUTRINO_Games[Index].Icon ~= "default" and NEUTRINO_DisableDisc == false then
				NEUTRINO_Games[Index].Icon = "mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/DISC/"..NEUTRINO_Games[Index].TitleId..".png"
			elseif NEUTRINO_DisableDisc == false then
				NEUTRINO_NDiscCount = NEUTRINO_NDiscCount + 1
			else
				NEUTRINO_Games[Index].Icon = "default"
			end
			if NEUTRINO_Games[Index].BackGround ~= "default" and NEUTRINO_DisableBg == false then
				NEUTRINO_Games[Index].BackGround = "mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/BG/"..NEUTRINO_Games[Index].TitleId..".png"
			elseif NEUTRINO_DisableBg == false then
				NEUTRINO_NBgCount = NEUTRINO_NBgCount + 1
			else
				NEUTRINO_Games[Index].BackGround = "default"
			end
		end
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
			if string.match(line, "(.*)/VMC/(.*)") or string.match(line, "(.*)0000000000000000000000(.*)") then
				NEUTRINO_Games[NEUTRINO_GamesTotal].Vmc = string.sub(line, string.len(line)-21, string.len(line))
				line = string.sub(line, 1, string.len(line)-23)
			else
				NEUTRINO_Games[NEUTRINO_GamesTotal].Vmc = "0000000000000000000000"
			end
			NEUTRINO_Games[NEUTRINO_GamesTotal].Folder, line = string.match(line, "(.*)/(.*)")
			NEUTRINO_Games[NEUTRINO_GamesTotal].Folder = string.sub(NEUTRINO_Games[NEUTRINO_GamesTotal].Folder, 2, 4)
			NEUTRINO_Games[NEUTRINO_GamesTotal].Name = string.sub(line, 1, -5)
			NEUTRINO_Games[NEUTRINO_GamesTotal].Extension = string.sub(line, string.len(line)-2, string.len(line))
			NEUTRINO_Games[NEUTRINO_GamesTotal].Media = string.lower(NEUTRINO_Games[NEUTRINO_GamesTotal].Folder)

			if NEUTRINO_Games[NEUTRINO_GamesTotal].Name == NEUTRINO_SelectedItem then
				NEUTRINO_SelectedItem = NEUTRINO_GamesTotal
			end
		elseif line ~= "" then
			NEUTRINO_NewHash = line
		end
	end
end

function NEUTRINO_GetRecents()
	for NEUTRINO_i in string.gmatch(NEUTRINO_Recent, "[^,]+") do
		NEUTRINO_i = string.gsub(NEUTRINO_i, "#c", ",")
		for NEUTRINO_j = 1, NEUTRINO_GamesTotal do
			if NEUTRINO_i == NEUTRINO_Games[NEUTRINO_j].Name then
				NEUTRINO_RecentsTotal = NEUTRINO_RecentsTotal+1
				NEUTRINO_Recents[NEUTRINO_RecentsTotal] = {};
				NEUTRINO_Recents[NEUTRINO_RecentsTotal].Name = NEUTRINO_Games[NEUTRINO_j].Name
				NEUTRINO_Recents[NEUTRINO_RecentsTotal].Folder = NEUTRINO_Games[NEUTRINO_j].Folder
				NEUTRINO_Recents[NEUTRINO_RecentsTotal].Extension = NEUTRINO_Games[NEUTRINO_j].Extension
				NEUTRINO_Recents[NEUTRINO_RecentsTotal].Media = NEUTRINO_Games[NEUTRINO_j].Media
				NEUTRINO_Recents[NEUTRINO_RecentsTotal].TitleId = NEUTRINO_Games[NEUTRINO_j].TitleId
				NEUTRINO_Recents[NEUTRINO_RecentsTotal].Vmc = NEUTRINO_Games[NEUTRINO_j].Vmc
				NEUTRINO_Recents[NEUTRINO_RecentsTotal].Icon = NEUTRINO_Games[NEUTRINO_j].Icon
				NEUTRINO_Recents[NEUTRINO_RecentsTotal].BackGround = NEUTRINO_Games[NEUTRINO_j].BackGround
				NEUTRINO_Recents[NEUTRINO_RecentsTotal].Favorite = NEUTRINO_Games[NEUTRINO_j].Favorite
				NEUTRINO_Recents[NEUTRINO_RecentsTotal].Link = NEUTRINO_j
				break
			end
		end
	end
end

function NEUTRINO_LoadIcon(firstOffest, lastOffset)
	for NEUTRINO_i = NEUTRINO_SelectedItem+firstOffest, NEUTRINO_SelectedItem+lastOffset do
		if NEUTRINO_CurrentList[NEUTRINO_i].Icon ~= "default" and NEUTRINO_i >= 1 and NEUTRINO_i <= NEUTRINO_CurrentTotal() then
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
	elseif NEUTRINO_CurrentList == NEUTRINO_Recents then
		return NEUTRINO_RecentsTotal
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

	for	NEUTRINO_i = 1, NEUTRINO_GamesTotal do
		NEUTRINO_GetFavorites(NEUTRINO_i)
		NEUTRINO_CacheArt(NEUTRINO_i)
	end
	NEUTRINO_LoadingText(false, neuLang[62])

	NEUTRINO_GetRecents()
	NEUTRINO_LoadingText(false, neuLang[62])
	NEUTRINO_CreateArt()

	NEUTRINO_CurrentList = NEUTRINO_Games
	NEUTRINO_LinkedList = NEUTRINO_Favorites
	if NEUTRINO_SelectedItem == nil then
		NEUTRINO_SelectedItem = 1
	end
	NEUTRINO_InitList()
end

for NEUTRINO_i = 1, 3 do
	pad = Pads.get()
	Screen.clear()
	NEUTRINO_DrawBKG()
	thmDrawBKG()
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

	thmDrawBKGOL()
	NEUTRINO_DrawTitleBar()
	
	spinDisc()
	Screen.waitVblankStart()
	oldpad = pad;
	Screen.flip()
end

function NEUTRINO_SyncFavorites()
	if NEUTRINO_CurrentList ~= NEUTRINO_Games then
		for NEUTRINO_i = 1, NEUTRINO_GamesTotal do
			if NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name == NEUTRINO_Games[NEUTRINO_i].Name then
				NEUTRINO_Games[NEUTRINO_i].Favorite = NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Favorite
			end
		end
	end
	if NEUTRINO_CurrentList ~= NEUTRINO_Recents then
		for NEUTRINO_i = 1, NEUTRINO_RecentsTotal do
			if NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name == NEUTRINO_Recents[NEUTRINO_i].Name then
				NEUTRINO_Recents[NEUTRINO_i].Favorite = NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Favorite
			end
		end
	end
end

NEUTRINO_Timer = 0
function NEUTRINO_UpdateFavorites()
	if System.doesFileExist("CFG/neutrinoLauncher/favorites.csv") then
		NEUTRINO_TempFile = io.open("CFG/neutrinoLauncher/favorites.csv", "r")
		if NEUTRINO_TempFile:seek("end") == 0 then
			io.close(NEUTRINO_TempFile)
			System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/favorites.csv")
		end
	end
	
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
		NEUTRINO_LinkedList[NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Link].Link = 0
		NEUTRINO_SyncFavorites()
		NEUTRINO_FavoritesTotal = NEUTRINO_FavoritesTotal - 1
		if NEUTRINO_CurrentList == NEUTRINO_Favorites then
			table.remove(NEUTRINO_Favorites, NEUTRINO_SelectedItem)
			if NEUTRINO_SelectedItem == NEUTRINO_FavoritesTotal then
				NEUTRINO_SelectedItem = NEUTRINO_SelectedItem - 1
			end
			NEUTRINO_Timer = 0
		elseif NEUTRINO_CurrentList == NEUTRINO_Games then
			table.remove(NEUTRINO_Favorites, NEUTRINO_Games[NEUTRINO_SelectedItem].Link)
		elseif NEUTRINO_CurrentList == NEUTRINO_Recents then
			table.remove(NEUTRINO_Favorites, NEUTRINO_Games[NEUTRINO_Recents[NEUTRINO_SelectedItem].Link].Link)
		end
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
		NEUTRINO_NewFavorite.Vmc = NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Vmc
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
		NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Favorite = true
		NEUTRINO_SyncFavorites()
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
NEUTRINO_HoldingLetter=20

function NEUTRINO_AnimateUp(speed)
	if NEUTRINO_Scrolling == false then
		NEUTRINO_LoadIcon(-6, -6)
		if themeInUse[-90] == 0 then
			for t = 0, 10 do end
		end
	end
	
	for NEUTRINO_Move = 1, 3 do
		Screen.clear()
		NEUTRINO_DrawBKG()
		thmDrawBKG()
		if themeInUse[-90] > 0 and NEUTRINO_BgAlpha > 128 then
			NEUTRINO_BgAlpha = 255
			Graphics.drawImageExtended(themeInUse[-90], 352, plusYValue+240, 0, 0, 640, 480, 704, 480, 0, NEUTRINO_BgAlpha)
			Graphics.drawImage(themeInUse[-91], 152, 186, NEUTRINO_BgAlpha)
		end
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

		thmDrawBKGOL()
		NEUTRINO_DrawTitleBar()
		
		pad = Pads.get()
		if NEUTRINO_Move ~= 3 and not Pads.check(pad, PAD_L2) then
			spinDisc()
			Screen.waitVblankStart()
			oldpad = pad
			Screen.flip()
		end
	end
end
function NEUTRINO_AnimateDown(speed)
	if NEUTRINO_Scrolling == false then
		NEUTRINO_LoadIcon(5, 5)
		if themeInUse[-90] == 0 then
			for t = 0, 10 do end
		end
	end

	for NEUTRINO_Move = 1, 3 do
		Screen.clear()
		NEUTRINO_DrawBKG()
		thmDrawBKG()
		if themeInUse[-90] > 0 and NEUTRINO_BgAlpha > 128 then
			NEUTRINO_BgAlpha = 255
			Graphics.drawImageExtended(themeInUse[-90], 352, plusYValue+240, 0, 0, 640, 480, 704, 480, 0, NEUTRINO_BgAlpha)
			Graphics.drawImage(themeInUse[-91], 152, 186, NEUTRINO_BgAlpha)
		end
		DrawSubMenu(actualCat,actualOption,true)
		NEUTRINO_MoveBack=4-NEUTRINO_Move
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

		thmDrawBKGOL()
		NEUTRINO_DrawTitleBar()
		
		pad = Pads.get()
		if NEUTRINO_Move ~= 3 and not Pads.check(pad, PAD_L2) then
			spinDisc()
			Screen.waitVblankStart()
			oldpad = pad
			Screen.flip()
		end
	end
end

function NEUTRINO_SaveLast()
	NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder.."lastgame.cfg", "w")
	io.output(NEUTRINO_TempFile)
	if NEUTRINO_CurrentList == NEUTRINO_Games then
		io.write(NEUTRINO_SelectedItem)
	else
		io.write(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Link)
	end
	io.close(NEUTRINO_TempFile)
end

function NEUTRINO_UpdateRecents()
	NEUTRINO_NewRecent = ""
	if System.doesFileExist(NEUTRINO_DataFolder.."recent.csv") then
		recentCount = 0
		for NEUTRINO_i in string.gmatch(NEUTRINO_Recent, "[^,]+") do
			recentCount = recentCount + 1
			NEUTRINO_i = string.gsub(NEUTRINO_i, "#c", ",")
			if recentCount < 10 and NEUTRINO_i ~= NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name then
				NEUTRINO_NewRecent = NEUTRINO_NewRecent..NEUTRINO_i..","
			elseif recentCount < 10 then
				recentCount = recentCount - 1
			end
		end
	end

	NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder.."recent.csv", "w")
	io.output(NEUTRINO_TempFile)
	io.write(string.gsub(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name, ",", "#c")..","..NEUTRINO_NewRecent)
	io.close(NEUTRINO_TempFile)
end

function NEUTRINO_CheckGroups(titleID)
	for NEUTRINO_i = 1, #NEUTRINO_MemGroups do
		if string.match(NEUTRINO_MemGroups[NEUTRINO_i], "(.*)XEBP(.*)") then
			Group = NEUTRINO_MemGroups[NEUTRINO_i]
		elseif NEUTRINO_MemGroups[NEUTRINO_i] == titleID then
			return Group
		end
	end
	return titleID
end

function NEUTRINO_NextLetter()
	NEUTRINO_currentLetter = string.sub(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name, 1, 1)
	NEUTRINO_newLetter = NEUTRINO_currentLetter
	i = NEUTRINO_SelectedItem
	while NEUTRINO_newLetter == NEUTRINO_currentLetter and i < NEUTRINO_CurrentTotal() do
		i = i + 1
		NEUTRINO_newLetter = string.sub(NEUTRINO_CurrentList[i].Name, 1, 1)
	end
end

function NEUTRINO_PrevLetter()
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
end

function ContextMenu_ReadSettings(Settings)
	if string.match(Settings, "(.*)cheat(.*)") then
		ContextMenu_Cheat = "-cheat "
		ContextMenu[2].Name = "\194\172  "..neuLang[65]
	else
		ContextMenu_Cheat = ""
		ContextMenu[2].Name = "     "..neuLang[65]
	end
	if ContextMenu_EnableVmc == true then
		if string.match(Settings, "(.*)vmc(.*)") then
			ContextMenu_Vmc = "-vmc "
			ContextMenu[3].Name = "\194\172  "..neuLang[53]
		else
			ContextMenu_Vmc = ""
			ContextMenu[3].Name = "     "..neuLang[53]
		end
	end
	if ContextMenu_EnableUnique == true then
		if string.match(Settings, "(.*)unique(.*)") then
			ContextMenu_Unique = "-unique "
			ContextMenu[3+(ContextMenu_Offset-1)].Name = "\194\172  "..neuLang[73]
		else
			ContextMenu_Unique = ""
			ContextMenu[3+(ContextMenu_Offset-1)].Name = "     "..neuLang[73]
		end
	end
	if string.match(Settings, "(.*)logo(.*)") then
		ContextMenu_Logo = " -logo"
		ContextMenu[3+ContextMenu_Offset].Name = "\194\172  "..neuLang[14]
	else
		ContextMenu_Logo = ""
		ContextMenu[3+ContextMenu_Offset].Name = "     "..neuLang[14]
	end

	if string.match(Settings, "(.*)0(.*)") then
		ContextMenu_Fast = "0"
		ContextMenu[4+ContextMenu_Offset].Name = "\194\172  "..neuLang[16]
	else
		ContextMenu_Fast = ""
		ContextMenu[4+ContextMenu_Offset].Name = "     "..neuLang[16]
	end
	if string.match(Settings, "(.*)2(.*)") then
		ContextMenu_Sync = "2"
		ContextMenu[5+ContextMenu_Offset].Name = "\194\172  "..neuLang[17]
	else
		ContextMenu_Sync = ""
		ContextMenu[5+ContextMenu_Offset].Name = "     "..neuLang[17]
	end
	if string.match(Settings, "(.*)3(.*)") then
		ContextMenu_Unhook = "3"
		ContextMenu[6+ContextMenu_Offset].Name = "\194\172  "..neuLang[18]
	else
		ContextMenu_Unhook = ""
		ContextMenu[6+ContextMenu_Offset].Name = "     "..neuLang[18]
	end
	if string.match(Settings, "(.*)5(.*)") then
		ContextMenu_Emulate = "5"
		ContextMenu[7+ContextMenu_Offset].Name = "\194\172  "..neuLang[19]
	else
		ContextMenu_Emulate = ""
		ContextMenu[7+ContextMenu_Offset].Name = "     "..neuLang[19]
	end
	if string.match(Settings, "(.*)7(.*)") then
		ContextMenu_Buffer = "7"
		ContextMenu[8+ContextMenu_Offset].Name = "\194\172  "..neuLang[77]
	else
		ContextMenu_Buffer = ""
		ContextMenu[8+ContextMenu_Offset].Name = "     "..neuLang[77]
	end

	if string.match(Settings, "(.*)-gsm(.*)") then
		ContextMenu_Gsm = " -gsm="
		if string.match(Settings, "(.*)-gsm=fp(.*)") then
			ContextMenu_Gx = "fp"
			ContextMenu[9+ContextMenu_Offset].Name = neuLang[80]..neuLang[86]
		else
			ContextMenu_Gx = ""
			ContextMenu[9+ContextMenu_Offset].Name = neuLang[80]..neuLang[82]
		end
		if string.match(Settings, "(.*):fp1(.*)") then
			ContextMenu_Gy = ":fp1"
			ContextMenu[10+ContextMenu_Offset].Name = neuLang[79]..neuLang[87]
		elseif string.match(Settings, "(.*):fp2(.*)") then
			ContextMenu_Gy = ":fp2"
			ContextMenu[10+ContextMenu_Offset].Name = neuLang[79]..neuLang[88]
		else
			ContextMenu_Gy = ""
			ContextMenu[10+ContextMenu_Offset].Name = neuLang[79]..neuLang[82]
		end
		if string.match(Settings, "(.*):1(.*)") then
			ContextMenu_Gz = ":1"
			ContextMenu[11+ContextMenu_Offset].Name = neuLang[81]..neuLang[85].."  1"
		elseif string.match(Settings, "(.*):2(.*)") then
			ContextMenu_Gz = ":2"
			ContextMenu[11+ContextMenu_Offset].Name = neuLang[81]..neuLang[85].."  2"
		elseif string.match(Settings, "(.*):3(.*)") then
			ContextMenu_Gz = ":3"
			ContextMenu[11+ContextMenu_Offset].Name = neuLang[81]..neuLang[85].."  3"
		else
			ContextMenu_Gz = ""
			ContextMenu[11+ContextMenu_Offset].Name = neuLang[81]..neuLang[89]
		end
		if ContextMenu_Gy == "" and ContextMenu_Gz ~= "" then
			ContextMenu_Gy = ":"
		end
	else
		ContextMenu_Gsm = ""
		ContextMenu_Gx = ""
		ContextMenu[9+ContextMenu_Offset].Name = neuLang[80]..neuLang[82]
		ContextMenu_Gy = ""
		ContextMenu[10+ContextMenu_Offset].Name = neuLang[79]..neuLang[82]
		ContextMenu_Gz = ""
		ContextMenu[11+ContextMenu_Offset].Name = neuLang[81]..neuLang[89]
	end
end
ContextMenu_FirstRun = true
function NEUTRINO_ContextMenu()
	if ContextMenu_FirstRun == true then
		ContextMenu_HasMoved = 0
		ContextMenu_SelectedItem = 1
		ContextMenu_Vmc = ""
		ContextMenu_Unique = ""
		ContextMenu_ReloadArt = false
		ContextMenu_Offset = 1
		ContextMenu_EnableVmc = true
		ContextMenu_EnableUnique = false
		
		if string.match(NEUTRINO_CheckGroups(NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId), "(.*)XEBP(.*)") then
			ContextMenu_Offset = ContextMenu_Offset + 1
			ContextMenu_EnableUnique = true
		end
		if NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Vmc == "0000000000000000000000" then
			ContextMenu_Offset = ContextMenu_Offset - 1
			ContextMenu_EnableVmc = false
		end
			
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
		ContextMenu[11] = {};
		ContextMenu[12] = {};
		if ContextMenu_Offset > 0 then
			ContextMenu[13] = {};
		end
		if ContextMenu_Offset == 2 then
			ContextMenu[14] = {};
		end

		ContextMenu[1].Description = neuLang[21]
		ContextMenu[2].Description = neuLang[66]
		if ContextMenu_EnableVmc == true then
			ContextMenu[3].Description = neuLang[56]
		end
		if ContextMenu_EnableUnique == true then
			ContextMenu[3+(ContextMenu_Offset-1)].Description = neuLang[74]
		end
		ContextMenu[3+ContextMenu_Offset].Description = neuLang[22]
		ContextMenu[4+ContextMenu_Offset].Description = neuLang[24]
		ContextMenu[5+ContextMenu_Offset].Description = neuLang[25]
		ContextMenu[6+ContextMenu_Offset].Description = neuLang[26]
		ContextMenu[7+ContextMenu_Offset].Description = neuLang[27]
		ContextMenu[8+ContextMenu_Offset].Description = neuLang[78]
		ContextMenu[9+ContextMenu_Offset].Description = neuLang[58]
		ContextMenu[10+ContextMenu_Offset].Description = neuLang[58]
		ContextMenu[11+ContextMenu_Offset].Description = neuLang[58]
		ContextMenu[12+ContextMenu_Offset].Description = neuLang[28]

		ContextMenu_AllItems = 12 + ContextMenu_Offset
		
		if System.doesFileExist(NEUTRINO_DataFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg") then
			NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg", "r")
			ContextMenu_LocalSettings = (NEUTRINO_TempFile:read())
			io.close(NEUTRINO_TempFile)
		else
			ContextMenu_LocalSettings = 1
		end
		if System.doesFileExist("CFG/neutrinoLauncher/neutrinoLaunchOptions.cfg") then
			NEUTRINO_TempFile = io.open("CFG/neutrinoLauncher/neutrinoLaunchOptions.cfg", "r")
			ContextMenu_GlobalSettings = (NEUTRINO_TempFile:read())
			io.close(NEUTRINO_TempFile)
		else
			ContextMenu_GlobalSettings = ""
		end

		ContextMenu[1].Name = neuLang[31]
		ContextMenu_Global = false
		if ContextMenu_LocalSettings ~= 0 then
			ContextMenu_ReadSettings(ContextMenu_LocalSettings)
		else
			ContextMenu_ReadSettings(ContextMenu_GlobalSettings)
		end
		ContextMenu[12+ContextMenu_Offset].Name = neuLang[33]
		ContextMenu_FirstRun = false
		
		if ContextMenu_Fast..ContextMenu_Sync..ContextMenu_Unhook..ContextMenu_Emulate..ContextMenu_Buffer == "" then
			ContextMenu_Disable = ""
		else
			ContextMenu_Disable = "-gc="
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
				if ContextMenu_Global == false then
					ContextMenu_ReadSettings(ContextMenu_GlobalSettings)
					ContextMenu[1].Name = neuLang[32]
					ContextMenu_Global = true
				elseif ContextMenu_Global == true then
					if ContextMenu_LocalSettings ~= 0 then
						ContextMenu_ReadSettings(ContextMenu_LocalSettings)
					else
						ContextMenu_LocalSettings = ContextMenu_GlobalSettings
						ContextMenu_ReadSettings(ContextMenu_LocalSettings)
					end
					ContextMenu[1].Name = neuLang[31]
					ContextMenu_Global = false
				end
			elseif ContextMenu_SelectedItem == 2 then
				if ContextMenu_Cheat == "" then
					ContextMenu[2].Name = "\194\172  "..neuLang[65]
					ContextMenu_Cheat = "-cheat "
				else
					ContextMenu[2].Name = "     "..neuLang[65]
					ContextMenu_Cheat = ""
				end
			elseif ContextMenu_SelectedItem == 3 and ContextMenu_EnableVmc == true then
				if ContextMenu_Vmc == "" then
					ContextMenu[3].Name = "\194\172  "..neuLang[53]
					ContextMenu_Vmc = "-vmc "
				else
					ContextMenu[3].Name = "     "..neuLang[53]
					ContextMenu_Vmc = ""
				end
			elseif ContextMenu_SelectedItem == 3+(ContextMenu_Offset-1) and ContextMenu_EnableUnique == true then
				if ContextMenu_Unique == "" then
					ContextMenu[3+(ContextMenu_Offset-1)].Name = "\194\172  "..neuLang[73]
					ContextMenu_Unique = "-unique "
				else
					ContextMenu[3+(ContextMenu_Offset-1)].Name = "     "..neuLang[73]
					ContextMenu_Unique = ""
				end
			elseif ContextMenu_SelectedItem == 3+ContextMenu_Offset then
				if ContextMenu_Logo == "" then
					ContextMenu[3+ContextMenu_Offset].Name = "\194\172  "..neuLang[14]
					ContextMenu_Logo = " -logo"
				else
					ContextMenu[3+ContextMenu_Offset].Name = "     "..neuLang[14]
					ContextMenu_Logo = ""
				end

			elseif ContextMenu_SelectedItem == 4+ContextMenu_Offset then
				if ContextMenu_Fast == "" then
					ContextMenu[4+ContextMenu_Offset].Name = "\194\172  "..neuLang[16]
					ContextMenu_Fast = "0"
				else
					ContextMenu[4+ContextMenu_Offset].Name = "     "..neuLang[16]
					ContextMenu_Fast = ""
				end
			elseif ContextMenu_SelectedItem == 5+ContextMenu_Offset then
				if ContextMenu_Sync == "" then
					ContextMenu[5+ContextMenu_Offset].Name = "\194\172  "..neuLang[17]
					ContextMenu_Sync = "2"
				else
					ContextMenu[5+ContextMenu_Offset].Name = "     "..neuLang[17]
					ContextMenu_Sync = ""
				end
			elseif ContextMenu_SelectedItem == 6+ContextMenu_Offset then
				if ContextMenu_Unhook == "" then
					ContextMenu[6+ContextMenu_Offset].Name = "\194\172  "..neuLang[18]
					ContextMenu_Unhook = "3"
				else
					ContextMenu[6+ContextMenu_Offset].Name = "     "..neuLang[18]
					ContextMenu_Unhook = ""
				end
			elseif ContextMenu_SelectedItem == 7+ContextMenu_Offset then
				if ContextMenu_Emulate == "" then
					ContextMenu[7+ContextMenu_Offset].Name = "\194\172  "..neuLang[19]
					ContextMenu_Emulate = "5"
				else
					ContextMenu[7+ContextMenu_Offset].Name = "     "..neuLang[19]
					ContextMenu_Emulate = ""
				end
			elseif ContextMenu_SelectedItem == 8+ContextMenu_Offset then
				if ContextMenu_Buffer == "" then
					ContextMenu[8+ContextMenu_Offset].Name = "\194\172  "..neuLang[77]
					ContextMenu_Buffer = "7"
				else
					ContextMenu[8+ContextMenu_Offset].Name = "     "..neuLang[77]
					ContextMenu_Buffer = ""
				end
			elseif ContextMenu_SelectedItem == 9+ContextMenu_Offset then
				if ContextMenu_Gx == "fp" then
					ContextMenu[9+ContextMenu_Offset].Name = neuLang[80]..neuLang[82]
					ContextMenu_Gx = ""
				else
					ContextMenu[9+ContextMenu_Offset].Name = neuLang[80]..neuLang[86]
					ContextMenu_Gx = "fp"
				end
			elseif ContextMenu_SelectedItem == 10+ContextMenu_Offset then
				if ContextMenu_Gy == ":fp1" then
					ContextMenu[10+ContextMenu_Offset].Name = neuLang[79]..neuLang[88]
					ContextMenu_Gy = ":fp2"
				elseif ContextMenu_Gy == ":fp2" then
					ContextMenu[10+ContextMenu_Offset].Name = neuLang[79]..neuLang[82]
					ContextMenu_Gy = ""
				else
					ContextMenu[10+ContextMenu_Offset].Name = neuLang[79]..neuLang[87]
					ContextMenu_Gy = ":fp1"
				end
			elseif ContextMenu_SelectedItem == 11+ContextMenu_Offset then
				if ContextMenu_Gz == ":1" then
					ContextMenu[11+ContextMenu_Offset].Name = neuLang[81].. neuLang[85].."  2"
					ContextMenu_Gz = ":2"
				elseif ContextMenu_Gz == ":2" then
					ContextMenu[11+ContextMenu_Offset].Name = neuLang[81].. neuLang[85].."  3"
					ContextMenu_Gz = ":3"
				elseif ContextMenu_Gz == ":3" then
					ContextMenu[11+ContextMenu_Offset].Name = neuLang[81]..neuLang[89]
					ContextMenu_Gz = ""
				else
					ContextMenu[11+ContextMenu_Offset].Name = neuLang[81].. neuLang[85].."  1"
					ContextMenu_Gz = ":1"
				end
					
			elseif ContextMenu_SelectedItem == 12+ContextMenu_Offset then
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
			if ContextMenu_Gy == "" and ContextMenu_Gz ~= "" then
				ContextMenu_Gy = ":"
			elseif ContextMenu_Gy == ":" and ContextMenu_Gz == "" then
				ContextMenu_Gy = ""
			end
			if ContextMenu_Gx..ContextMenu_Gy..ContextMenu_Gz == "" then
				ContextMenu_Gsm = ""
			else
				ContextMenu_Gsm = " -gsm="
			end
			if ContextMenu_Fast..ContextMenu_Sync..ContextMenu_Unhook..ContextMenu_Emulate..ContextMenu_Buffer == "" then
				ContextMenu_Disable = ""
			else
				ContextMenu_Disable = " -gc="
			end
		end
    end

    if ContextMenu_HasMoved == 2 then
		ContextMenu_NewSettings = ContextMenu_Vmc
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Unique
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Cheat
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Disable
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Fast
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Sync
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Unhook
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Emulate
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Buffer
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Logo
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Gsm
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Gx
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Gy
		ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_Gz

		if ContextMenu_Global == false then
			if ContextMenu_NewSettings ~= ContextMenu_GlobalSettings or System.doesFileExist(NEUTRINO_DataFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg") then
				NEUTRINO_LoadingText(false, neuLang[34])
				if ContextMenu_NewSettings == "" then
					System.removeFile(NEUTRINO_DataFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg")
				else
					NEUTRINO_TempFile = io.open(NEUTRINO_DataFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".cfg", "w")
					io.output(NEUTRINO_TempFile)
					io.write(ContextMenu_NewSettings)
					io.close(NEUTRINO_TempFile)
				end
			end
		elseif ContextMenu_Global == true then
			NEUTRINO_LoadingText(false, neuLang[34])
			if ContextMenu_NewSettings ~= ContextMenu_GlobalSettings then
				if ContextMenu_NewSettings == "" then
					System.removeFile("CFG/neutrinoLauncher/neutrinoLaunchOptions.cfg")
				else
					NEUTRINO_TempFile = io.open("CFG/neutrinoLauncher/neutrinoLaunchOptions.cfg", "w")
					io.output(NEUTRINO_TempFile)
					io.write(ContextMenu_NewSettings)
					io.close(NEUTRINO_TempFile)
				end
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

function NEUTRINO_Bytes(x)
    local b1=x%256  x=(x-x%256)/256
    return string.char(b1)
end

while XEBKeepInSubMenu do
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

	--Font.ftPrint(fontBig, 300, plusYValue+300, 11, 620, 64, NEUTRINO_HoldingUp, baseColorFull)

	
	if NEUTRINO_IsThereAnError then
		thmDrawBKGOL()
		if NEUTRINO_CurrentList == NEUTRINO_Games then
			Font.ftPrint(fontBig, 152, plusYValue+222, 0, 512, 64, xebLang[35], baseColorFull)
			Font.ftPrint(fontSmall, 153, plusYValue+243, 0, 512, 64, neuLang[35]..NEUTRINO_ListFile..neuLang[59], baseColorFull)
		else
			if NEUTRINO_CurrentList == NEUTRINO_Favorites then
				Font.ftPrint(fontBig, 152, plusYValue+222, 0, 512, 64, xebLang[35], baseColorFull)
				Font.ftPrint(fontSmall, 153, plusYValue+243, 0, 512, 64, neuLang[47], baseColorFull)
			elseif NEUTRINO_CurrentList == NEUTRINO_Recents then
				Font.ftPrint(fontBig, 152, plusYValue+222, 0, 512, 64, xebLang[35], baseColorFull)
				Font.ftPrint(fontSmall, 153, plusYValue+243, 0, 512, 64, neuLang[70], baseColorFull)
			end
			Graphics.drawImage(themeInUse[-95], 500, plusYValue+400)
			Graphics.drawImage(themeInUse[-93], 506, plusYValue+400)
			Font.ftPrint(fontSmall, 543, plusYValue+405, 0, 400, 64, neuLang[12], baseColorFull)
			while NEUTRINO_ShowHelp == true do
				NEUTRINO_DrawHelp()
			end
		end
			
	else
		if NEUTRINO_ShowHelp == false then
		if Pads.check(pad, PAD_ACCEPT) and not Pads.check(oldpad, PAD_ACCEPT) then
			spinStep = (1 - spinSpeed)/25
			for NEUTRINO_WaveByeBye = 1, 25 do
				Screen.clear()
				spinSpeed = spinSpeed + spinStep
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
				spinDisc()
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
			for NEUTRINO_WaveByeBye = 1, 30 do
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

			if string.match(NEUTRINO_LaunchOptions, "(.*)vmc(.*)") then
				NEUTRINO_LaunchOptions = string.sub(NEUTRINO_LaunchOptions, 5, string.len(NEUTRINO_LaunchOptions))
				if NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Vmc ~= "0000000000000000000000" and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Vmc ~= nil then
					NEUTRINO_Vmc = " -mc0="..NEUTRINO_PathPrefix..":"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Vmc
				end
			end
			
			if System.doesFileExist("mc0:/BADATA-SYSTEM/history") then
				NEUTRINO_TempFile = System.openFile("mc0:/BADATA-SYSTEM/history", FREAD)
				if System.sizeFile(NEUTRINO_TempFile) > 22 then
					System.copyFile("mc0:/BADATA-SYSTEM/history", "mc0:/BADATA-SYSTEM/history.bak")
					System.closeFile(NEUTRINO_TempFile)
					NEUTRINO_PlayCount = 1
				else
					System.closeFile(NEUTRINO_TempFile)
					
					NEUTRINO_TempFile = io.open("mc0:/BADATA-SYSTEM/history", "rb")
					NEUTRINO_TempFile:seek("set", 16)
					NEUTRINO_PlayCount = NEUTRINO_TempFile:read(1)
					io.close(NEUTRINO_TempFile)
					NEUTRINO_PlayCount = string.byte(NEUTRINO_PlayCount)
					
					NEUTRINO_PlayCount = NEUTRINO_PlayCount + 1
					if NEUTRINO_PlayCount >= 64 then
						NEUTRINO_PlayCount = 1
					end
				end
				System.removeFile("mc0:/BADATA-SYSTEM/history")
			else
				NEUTRINO_PlayCount = 1
			end
			if not System.doesDirectoryExist("mc0:/BADATA-SYSTEM") then
				System.createDirectory("mc0:/BADATA-SYSTEM")
			end
			if System.doesDirectoryExist("mc0:/BADATA-SYSTEM") then
				NEUTRINO_MemCard = true
			end
			
			if NEUTRINO_MemCard then
				NEUTRINO_PlayCount = NEUTRINO_Bytes(NEUTRINO_PlayCount) --NEUTRINO_ByteCodes[NEUTRINO_PlayCount]

				NEUTRINO_TempFile = io.open("mc0:/BADATA-SYSTEM/history", "w")
				io.output(NEUTRINO_TempFile)
			end
			if string.match(NEUTRINO_LaunchOptions, "(.*)unique(.*)") then
				NEUTRINO_LaunchOptions = string.sub(NEUTRINO_LaunchOptions, 9, string.len(NEUTRINO_LaunchOptions))
				if NEUTRINO_Vmc ~= "" then
					NEUTRINO_Vmc = " -mc0="..NEUTRINO_PathPrefix..":/VMC/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId.."_0.bin"
				end
				
				if NEUTRINO_MemCard then
					io.write(NEUTRINO_Games[NEUTRINO_SelectedItem].TitleId.."\x00\x00\x00\x00\x00"..NEUTRINO_PlayCount.."\x01\x00\x00\x21\x00")
					io.close(NEUTRINO_TempFile)
				end
			elseif NEUTRINO_MemCard then
				io.write(NEUTRINO_CheckGroups(NEUTRINO_Games[NEUTRINO_SelectedItem].TitleId).."\x00\x00\x00\x00\x00"..NEUTRINO_PlayCount.."\x01\x00\x00\x21\x00")
				io.close(NEUTRINO_TempFile)
			end
			
			if string.match(NEUTRINO_LaunchOptions, "(.*)cheat(.*)") then
				NEUTRINO_LaunchOptions = string.sub(NEUTRINO_LaunchOptions, 8, string.len(NEUTRINO_LaunchOptions))
				NEUTRINO_Cheats = true
			end

			NEUTRINO_PrepIRX = ""
			if string.match(NEUTRINO_Bsd, "(.*)udp(.*)") then
				NEUTRINO_PrepIRX = "echo \""..neuLang[15].."\"\r\nload modules/ps2dev9.irx\r\nload modules/netman.irx\r\nload modules/smap.irx\r\nsleep 3\r\n"
			end

			NEUTRINO_GameFolder = NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Folder.."/"
			if string.match(NEUTRINO_Fs, "(.*)hdl(.*)") then
				NEUTRINO_GameFolder = ""
			end

			NEUTRINO_RadShellText = "fontsize 0.6\r\necho \""..neuLang[71]..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name..".iso\"\r\n"..NEUTRINO_PrepIRX.."sleep 1\r\nrun neutrino.elf -bsd="..NEUTRINO_Bsd..NEUTRINO_Fs.." \"-dvd="..NEUTRINO_PathPrefix..":"..NEUTRINO_GameFolder..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Name.."."..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Extension.."\" -mt="..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].Media..NEUTRINO_LaunchOptions..NEUTRINO_Vmc.."\r\n"

			System.removeFile(xebLua_AppWorkingPath.."radshellmod.ios")
			NEUTRINO_RadShellFile = System.openFile(xebLua_AppWorkingPath.."radshellmod.ios", FCREATE)
			System.writeFile(NEUTRINO_RadShellFile, NEUTRINO_RadShellText, string.len(NEUTRINO_RadShellText))
			System.closeFile(NEUTRINO_RadShellFile)
			NEUTRINO_SaveLast()
			NEUTRINO_UpdateRecents()
			if NEUTRINO_Cheats == true then
				NEUTRINO_CheatFile = "mass:CHT/"..NEUTRINO_CurrentList[NEUTRINO_SelectedItem].TitleId..".cht"

				NEUTRINO_CheatDeviceText = "[CheatDevicePS2]\ndatabaseReadOnly = "..NEUTRINO_CheatFile.."\ndatabaseReadWrite =\nboot1 = mass:XEBPLUS/APPS/neutrinoLauncher/radshellmod.elf\nboot2 = mass:XEBPLUS/XEBPLUS_XMAS.elf\nboot3 = "..neuLang[67]--.."\nboot4 = \xE2\x81\xA0\nboot5 = \xE2\x81\xA0"

				System.removeFile(xebLua_AppWorkingPath.."/CheatDevice/CheatDevicePS2.ini")
				NEUTRINO_CheatDeviceFile = System.openFile(xebLua_AppWorkingPath.."/CheatDevice/CheatDevicePS2.ini", FCREATE)
				System.writeFile(NEUTRINO_CheatDeviceFile, NEUTRINO_CheatDeviceText, string.len(NEUTRINO_CheatDeviceText))
				System.closeFile(NEUTRINO_CheatDeviceFile)

				System.loadELF(xebLua_AppWorkingPath.."CheatDevice/CheatDevice-EXFAT.ELF", 1)
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
		elseif Pads.check(pad, PAD_L2) and not Pads.check(pad, PAD_R2) and not Pads.check(oldpad, PAD_R2) then
			NEUTRINO_Scrolling = true
			if NEUTRINO_SelectedItem ~= 1 then
				NEUTRINO_SelectedItem = NEUTRINO_SelectedItem - 1
			elseif NEUTRINO_SelectedItem == 1 and not Pads.check(oldpad, PAD_L2) then
				NEUTRINO_SelectedItem = NEUTRINO_CurrentTotal()
				NEUTRINO_LoadingText(false, neuLang[6])
				NEUTRINO_LoadIcon(-6, 0)
			end
		elseif Pads.check(pad, PAD_R2) and not Pads.check(pad, PAD_L2) and not Pads.check(oldpad, PAD_L2)then
			NEUTRINO_Scrolling = true
			if NEUTRINO_SelectedItem ~= NEUTRINO_CurrentTotal() then
				NEUTRINO_SelectedItem = NEUTRINO_SelectedItem + 1
			elseif NEUTRINO_SelectedItem == NEUTRINO_CurrentTotal() and not Pads.check(oldpad, PAD_R2) then
				NEUTRINO_SelectedItem = 1
				NEUTRINO_LoadingText(false, neuLang[6])
				NEUTRINO_LoadIcon(0, 6)
			end
		elseif Pads.check(pad, PAD_L3) and NEUTRINO_newLetter ~= NEUTRINO_currentLetter then --and 
			NEUTRINO_Scrolling = true
			if not Pads.check(oldpad, PAD_L3) then
				NEUTRINO_PrevLetter()
			else
				if NEUTRINO_HoldingLetter == 0 then
					NEUTRINO_PrevLetter()
					NEUTRINO_HoldingLetter = 15
				end
				NEUTRINO_HoldingLetter = NEUTRINO_HoldingLetter -1
			end
			NEUTRINO_SelectedItem = i + 1
			NEUTRINO_newLetter = "0"
		elseif Pads.check(pad, PAD_R3) and NEUTRINO_newLetter ~= NEUTRINO_currentLetter then --and 
			NEUTRINO_Scrolling = true
			if not Pads.check(oldpad, PAD_R3) then
				NEUTRINO_NextLetter()
			else
				if NEUTRINO_HoldingLetter == 0 then
					NEUTRINO_NextLetter()
					NEUTRINO_HoldingLetter = 15
				end
				NEUTRINO_HoldingLetter = NEUTRINO_HoldingLetter -1
			end
			NEUTRINO_SelectedItem = i
			NEUTRINO_newLetter = "0"
		elseif Pads.check(pad, PAD_SQUARE) and not Pads.check(oldpad, PAD_SQUARE) then
			if themeInUse[-90] == 0 or NEUTRINO_BgAlpha == 255 then
				XEBKeepInContextMenu = true
				ContextMenu_HasMoved = 0
			end
		elseif Pads.check(pad, PAD_TRIANGLE) and not Pads.check(oldpad, PAD_TRIANGLE) then
			NEUTRINO_UpdateFavorites()
		else
			if NEUTRINO_Scrolling == true then
				NEUTRINO_LoadingText(false, neuLang[6])
				NEUTRINO_LoadIcon(-6, 6)
				NEUTRINO_Scrolling = false
			end
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
	elseif Pads.check(pad, PAD_R1) and not Pads.check(oldpad, PAD_R1) then
			NEUTRINO_Timer = nil
			if themeInUse[-90] > 0 and NEUTRINO_CurrentList[NEUTRINO_SelectedItem].BackGround ~= "default" and NEUTRINO_IsThereAnError == false then
				Graphics.freeImage(themeInUse[-90])
				themeInUse[-90] = 0
			end
			if NEUTRINO_CurrentList == NEUTRINO_Games then
				NEUTRINO_GamesSelected = NEUTRINO_SelectedItem
				NEUTRINO_CurrentList = NEUTRINO_Recents
				NEUTRINO_LinkedList = NEUTRINO_Games
				NEUTRINO_SelectedItem = 1
				NEUTRINO_LoadingText(false, neuLang[72])
			elseif NEUTRINO_CurrentList == NEUTRINO_Recents then
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
	elseif Pads.check(pad, PAD_L1) and not Pads.check(oldpad, PAD_L1) then
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
				NEUTRINO_LoadingText(false, neuLang[72])
			elseif NEUTRINO_CurrentList == NEUTRINO_Favorites then
				NEUTRINO_FavoritesSelected = NEUTRINO_SelectedItem
				NEUTRINO_CurrentList = NEUTRINO_Recents
				NEUTRINO_LinkedList = NEUTRINO_Games
				NEUTRINO_SelectedItem = 1
				NEUTRINO_LoadingText(false, neuLang[41])
			elseif NEUTRINO_CurrentList == NEUTRINO_Recents then
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
	NEUTRINO_DrawBKG()
	thmDrawBKG()

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
				NEUTRINO_DrawItemFrame(NEUTRINO_CurrentList[NEUTRINO_iB], 152, NEUTRINO_iB_Y+135, true, NEUTRINO_ReverseFrame, baseColorFaded, NEUTRINO_ColorFadedZero)
			end
			NEUTRINO_ItemPosition=NEUTRINO_ItemPosition+1
		end
	end
	thmDrawBKGOL()
	spinDisc()
	Screen.waitVblankStart()
	oldpad = pad;
	Screen.flip()
end
for NEUTRINO_i = 1, 21 do
	item = NEUTRINO_i - 111
	if themeInUse[item] ~= nil and themeInUse[item] > 0 then
		Graphics.freeImage(themeInUse[item])
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
DrawInterface(actualCat,actualOption,true)
thmDrawBKGOL()
spinDisc()
spinSpeed = 0
imanoSpin=0

oldpad = pad;
