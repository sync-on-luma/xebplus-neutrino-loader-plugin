XEBKeepInContextMenu=true
TransparencyAlpha=0
TempX=840
TempY=32

ContextMenu_AllItems = 4
ContextMenu_SelectedItem = 1
ContextMenu={};
ContextMenu[1] = {};
ContextMenu[2] = {};
ContextMenu[3] = {};
ContextMenu[4] = {};
ContextMenu[5] = {};
ContextMenu[1].Description = nSetLang[3]
ContextMenu[2].Description = nSetLang[4]
ContextMenu[3].Description = nSetLang[5]
ContextMenu[4].Description = nSetLang[6]
ContextMenu[5].Description = nSetLang[7]

if System.doesFileExist("CFG/neutrinoHDD.cfg") then
    ContextMenu_TempFile = io.open("CFG/neutrinoHDD.cfg", "r")
    Settings = (ContextMenu_TempFile:read())
    io.close(ContextMenu_TempFile)
else
    Settings = ""
end

if string.match(Settings, "(.*)1(.*)") then
	ContextMenu_DisableArt = "1"
	ContextMenu[1].Name = "\194\172  "..nSetLang[8]
else
	ContextMenu_DisableArt = ""
	ContextMenu[1].Name = "     "..nSetLang[8]
end
if string.match(Settings, "(.*)2(.*)") then
	ContextMenu_DisableStatus = "2"
	ContextMenu[2].Name = "\194\172  "..nSetLang[9]
else
	ContextMenu_DisableStatus = ""
	ContextMenu[2].Name = "     "..nSetLang[9]
end
if string.match(Settings, "(.*)3(.*)") then
	ContextMenu_DisableReload = "3"
	ContextMenu[3].Name = "\194\172  "..nSetLang[15]
else
	ContextMenu_DisableReload = ""
	ContextMenu[3].Name = "     "..nSetLang[15]
end
if System.doesFileExist(xebLua_AppWorkingPath..".cache/lastart.cfg") then
    ContextMenu[4].Name = nSetLang[11]
else
    ContextMenu[4].Name = nSetLang[12]
end
if System.doesDirectoryExist(xebLua_AppWorkingPath..".cache") then
    ContextMenu[5].Name = nSetLang[13]
else
    ContextMenu[4].Name = nSetLang[12]
    ContextMenu[5].Name = nSetLang[14]
end

for move = 1, 10 do
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
    thmDrawBKGOL()

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
    if ContextMenu_SelectedItem == 1 then
        Font.ftPrint(fontSmall, 408+movec, plusYValue+380, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
    else
        Font.ftPrint(fontSmall, 408+movec, plusYValue+380, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
    end
    ----------------------------------------------------------------------------
    Screen.waitVblankStart()
    oldpad = pad;
    Screen.flip()
end
while XEBKeepInContextMenu do
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
    thmDrawBKGOL()
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
    if ContextMenu_SelectedItem == 1 then
        Font.ftPrint(fontSmall, 408, plusYValue+380, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
    else
        Font.ftPrint(fontSmall, 408, plusYValue+380, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
    end
    ----------------------------------------------------------------------------
    if Pads.check(pad, PAD_ACCEPT) and not Pads.check(oldpad, PAD_ACCEPT) then
        if ContextMenu_SelectedItem == 1 then
            if ContextMenu_DisableArt == "" then
                ContextMenu_DisableArt = "1"
                ContextMenu[1].Name = "\194\172  "..nSetLang[8]
            else
                ContextMenu_DisableArt = ""
                ContextMenu[1].Name = "     "..nSetLang[8]
            end
        elseif ContextMenu_SelectedItem == 2 then
            if ContextMenu_DisableStatus == "" then
                ContextMenu_DisableStatus = "2"
                ContextMenu[2].Name = "\194\172  "..nSetLang[9]
            else
                ContextMenu_DisableStatus = ""
                ContextMenu[2].Name = "     "..nSetLang[9]
            end
        elseif ContextMenu_SelectedItem == 3 then
            if ContextMenu_DisableReload == "" then
                ContextMenu_DisableReload = "3"
                ContextMenu[3].Name = "\194\172  Disable Icon Animation"
            else
                ContextMenu_DisableReload = ""
                ContextMenu[3].Name = "     Disable Icon Animation"
            end
        elseif ContextMenu_SelectedItem == 4 then
            if System.doesFileExist(xebLua_AppWorkingPath..".cache/lastart.cfg") then
                System.removeFile(xebLua_AppWorkingPath..".cache/lastart.cfg")
                System.removeFile(xebLua_AppWorkingPath..".cache/lastgame.cfg")
                System.removeFile(xebLua_AppWorkingPath..".cache/lasttotal.cfg")
                ContextMenu[4].Name = nSetLang[12]
            end
        elseif ContextMenu_SelectedItem == 5 then
            if System.doesDirectoryExist(xebLua_AppWorkingPath..".cache/") then
                --System.removeDirectory(xebLua_AppWorkingPath..".cache/")
                --ContextMenu[4].Name = nSetLang[12]
                --ContextMenu[5].Name = nSetLang[14]
            end
        end
    end
    if Pads.check(pad, PAD_UP) and not Pads.check(oldpad, PAD_UP) then
        if ContextMenu_SelectedItem > 1 then
            ContextMenu_SelectedItem=ContextMenu_SelectedItem-1
        end
    end
    if Pads.check(pad, PAD_DOWN) and not Pads.check(oldpad, PAD_DOWN) then
        if ContextMenu_SelectedItem < ContextMenu_AllItems then
            ContextMenu_SelectedItem=ContextMenu_SelectedItem+1
        end
    end
    if Pads.check(pad, PAD_CANCEL) and not Pads.check(oldpad, PAD_CANCEL) then
        XEBKeepInContextMenu=false
    end
    Screen.waitVblankStart()
    oldpad = pad;
    Screen.flip()
end

ContextMenu_NewSettings = ""
ContextMenu_NewSettings = ContextMenu_DisableArt
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_DisableStatus
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_DisableReload
if ContextMenu_NewSettings == "" then
    System.removeFile(System.currentDirectory().."CFG/neutrinoHDD.cfg")
else
    ContextMenu_TempFile = io.open("CFG/neutrinoHDD.cfg", "w")
    io.output(ContextMenu_TempFile)
    io.write(ContextMenu_NewSettings)
    io.close(ContextMenu_TempFile)
end
for move = 1, 10 do
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
    thmDrawBKGOL()

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
    if ContextMenu_SelectedItem == 1 then
        Font.ftPrint(fontSmall, 408+movec, plusYValue+380, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
    else
        Font.ftPrint(fontSmall, 408+movec, plusYValue+380, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
    end
    ----------------------------------------------------------------------------
    Screen.waitVblankStart()
    oldpad = pad;
    Screen.flip()
end
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
thmDrawBKGOL()
oldpad = pad;
