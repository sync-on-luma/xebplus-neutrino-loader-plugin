XEBKeepInContextMenu=true
TransparencyAlpha=0
TempX=840
TempY=32

ContextMenu_AllItems = 10
ContextMenu_SelectedItem = 1
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
ContextMenu[1].Description = nSetLang[16]
ContextMenu[2].Description = nSetLang[18]
ContextMenu[3].Description = nSetLang[17]
ContextMenu[4].Description = nSetLang[3]
ContextMenu[5].Description = nSetLang[4]
ContextMenu[6].Description = nSetLang[29]
ContextMenu[7].Description = nSetLang[5]
ContextMenu[8].Description = nSetLang[22]
ContextMenu[9].Description = nSetLang[24]
ContextMenu[10].Description = nSetLang[6]
ContextMenu[11].Description = nSetLang[7]

if System.doesFileExist("CFG/neutrinoLauncher/menu.cfg") then
    ContextMenu_TempFile = io.open("CFG/neutrinoLauncher/menu.cfg", "r")
    Settings = (ContextMenu_TempFile:read())
    io.close(ContextMenu_TempFile)
else
    Settings = ""
end


if string.match(Settings, "(.*)H(.*)") then
	ContextMenu_EnableHDD = "H"
	ContextMenu[1].Name = "     "..nSetLang[19]
else
	ContextMenu_EnableHDD = ""
	ContextMenu[1].Name = "\194\172  "..nSetLang[19]
end
if string.match(Settings, "(.*)M(.*)") then
	ContextMenu_EnableUSB = "M"
	ContextMenu[2].Name = "     "..nSetLang[21]
else
	ContextMenu_EnableUSB = ""
	ContextMenu[2].Name = "\194\172  "..nSetLang[21]
end
if string.match(Settings, "(.*)U(.*)") then
	ContextMenu_EnableMX4 = "U"
	ContextMenu[3].Name = "     "..nSetLang[20]
else
	ContextMenu_EnableMX4 = ""
	ContextMenu[3].Name = "\194\172  "..nSetLang[20]
end
if string.match(Settings, "(.*)1(.*)") then
	ContextMenu_DisableArt = "1"
	ContextMenu[4].Name = "\194\172  "..nSetLang[8]
else
	ContextMenu_DisableArt = ""
	ContextMenu[4].Name = "     "..nSetLang[8]
end
if string.match(Settings, "(.*)2(.*)") then
	ContextMenu_DisableStatus = "2"
	ContextMenu[5].Name = "\194\172  "..nSetLang[9]
else
	ContextMenu_DisableStatus = ""
	ContextMenu[5].Name = "     "..nSetLang[9]
end
if string.match(Settings, "(.*)7(.*)") then
	ContextMenu_DisableFade = "7"
	ContextMenu[6].Name = "\194\172  "..nSetLang[28]
else
	ContextMenu_DisableFade = ""
	ContextMenu[6].Name = "     "..nSetLang[28]
end

if string.match(Settings, "(.*)3(.*)") then
	ContextMenu_DisableAnim = "3"
	ContextMenu[7].Name = "\194\172  "..nSetLang[15]
else
	ContextMenu_DisableAnim = ""
	ContextMenu[7].Name = "     "..nSetLang[15]
end
if string.match(Settings, "(.*)4(.*)") then
	ContextMenu_ShowTitleId = "4"
	ContextMenu[8].Name = "     "..nSetLang[25]
else
	ContextMenu_ShowTitleId = ""
	ContextMenu[8].Name = "\194\172  "..nSetLang[25]
end
if string.match(Settings, "(.*)6(.*)") then
	ContextMenu_ShowMedia = "6"
	ContextMenu[9].Name = "     "..nSetLang[27]
else
	ContextMenu_ShowMedia = ""
	ContextMenu[9].Name = "\194\172  "..nSetLang[27]
end
if System.doesFileExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/lastart.cfg") then
    ContextMenu[10].Name = nSetLang[11]
else
    ContextMenu[10].Name = nSetLang[12]
end
if System.doesDirectoryExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/") then
    ContextMenu[11].Name = nSetLang[13]
else
    ContextMenu[10].Name = nSetLang[12]
    ContextMenu[11].Name = nSetLang[14]
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
            if ContextMenu_EnableHDD == "" then
                ContextMenu_EnableHDD = "H"
                ContextMenu[1].Name = "     "..nSetLang[19]
            else
                ContextMenu_EnableHDD = ""
                ContextMenu[1].Name = "\194\172  "..nSetLang[19]
            end
        elseif ContextMenu_SelectedItem == 2 then
            if ContextMenu_EnableUSB == "" then
                ContextMenu_EnableUSB = "M"
                ContextMenu[2].Name = "     "..nSetLang[21]
            else
            	ContextMenu_EnableUSB = ""
                ContextMenu[2].Name = "\194\172  "..nSetLang[21]
            end
        elseif ContextMenu_SelectedItem == 3 then
            if ContextMenu_EnableMX4 == "" then
                ContextMenu_EnableMX4 = "U"
                ContextMenu[3].Name = "     "..nSetLang[20]
            else
            	ContextMenu_EnableMX4 = ""
                ContextMenu[3].Name = "\194\172  "..nSetLang[20]
            end
        elseif ContextMenu_SelectedItem == 4 then
            if ContextMenu_DisableArt == "" then
                ContextMenu_DisableArt = "1"
                ContextMenu[4].Name = "\194\172  "..nSetLang[8]
            else
                ContextMenu_DisableArt = ""
                ContextMenu[4].Name = "     "..nSetLang[8]
            end
        elseif ContextMenu_SelectedItem == 5 then
            if ContextMenu_DisableStatus == "" then
                ContextMenu_DisableStatus = "2"
                ContextMenu[5].Name = "\194\172  "..nSetLang[9]
            else
                ContextMenu_DisableStatus = ""
                ContextMenu[5].Name = "     "..nSetLang[9]
            end
        elseif ContextMenu_SelectedItem == 6 then
            if ContextMenu_DisableFade == "" then
                ContextMenu_DisableFade = "7"
                ContextMenu[6].Name = "\194\172  "..nSetLang[28]
            else
                ContextMenu_DisableFade = ""
                ContextMenu[6].Name = "     "..nSetLang[28]
            end

        elseif ContextMenu_SelectedItem == 7 then
            if ContextMenu_DisableAnim == "" then
                ContextMenu_DisableAnim = "3"
                ContextMenu[7].Name = "\194\172  "..nSetLang[15]
            else
                ContextMenu_DisableAnim = ""
                ContextMenu[7].Name = "     "..nSetLang[15]
            end
        elseif ContextMenu_SelectedItem == 8 then
            if ContextMenu_ShowTitleId == "" then
                ContextMenu_ShowTitleId = "4"
                ContextMenu[8].Name = "     "..nSetLang[25]
            else
                ContextMenu_ShowTitleId = ""
                ContextMenu[8].Name = "\194\172  "..nSetLang[25]
            end
        elseif ContextMenu_SelectedItem == 9 then
            if ContextMenu_ShowMedia == "" then
                ContextMenu_ShowMedia = "6"
                ContextMenu[9].Name = "     "..nSetLang[27]
            else
                ContextMenu_ShowMedia = ""
                ContextMenu[9].Name = "\194\172  "..nSetLang[27]
            end
        elseif ContextMenu_SelectedItem == 10 then
            if System.doesFileExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/lastart.cfg") then
                System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/lastart.cfg")
                ContextMenu[10].Name = nSetLang[11]
            end
        elseif ContextMenu_SelectedItem == 11 then
            if System.doesDirectoryExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/") then
                --System.removeDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/")
                --ContextMenu[7].Name = nSetLang[12]
                --ContextMenu[8].Name = nSetLang[14]
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
ContextMenu_NewSettings = ContextMenu_EnableHDD
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_EnableUSB
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_EnableMX4
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_DisableArt
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_DisableStatus
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_DisableFade
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_DisableAnim
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_ShowTitleId
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_ShowMedia
if ContextMenu_NewSettings == "" then
    System.removeFile(System.currentDirectory().."CFG/neutrinoLauncher/menu.cfg")
else
    ContextMenu_TempFile = io.open("CFG/neutrinoLauncher/menu.cfg", "w")
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