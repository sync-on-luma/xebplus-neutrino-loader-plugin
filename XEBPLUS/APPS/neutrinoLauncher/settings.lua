XEBKeepInContextMenu=true
TransparencyAlpha=0
TempX=840
TempY=32

ContextMenu_AllItems = 16
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
ContextMenu[12] = {};
ContextMenu[13] = {};
ContextMenu[14] = {};
ContextMenu[15] = {};
ContextMenu[16] = {};
ContextMenu[1].Description = nSetLang[16]
ContextMenu[2].Description = nSetLang[18]
ContextMenu[3].Description = nSetLang[39]
ContextMenu[4].Description = nSetLang[17]
ContextMenu[5].Description = nSetLang[30]
ContextMenu[6].Description = nSetLang[35]
ContextMenu[7].Description = nSetLang[41]
ContextMenu[8].Description = nSetLang[3]
ContextMenu[9].Description = nSetLang[37]
ContextMenu[10].Description = nSetLang[4]
ContextMenu[11].Description = nSetLang[29]
ContextMenu[12].Description = nSetLang[5]
ContextMenu[13].Description = nSetLang[22]
ContextMenu[14].Description = nSetLang[24]
ContextMenu[15].Description = nSetLang[6]
ContextMenu[16].Description = nSetLang[33]

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
	ContextMenu_EnableMX4 = "M"
	ContextMenu[2].Name = "     "..nSetLang[21]
else
	ContextMenu_EnableMX4 = ""
	ContextMenu[2].Name = "\194\172  "..nSetLang[21]
end
if string.match(Settings, "(.*)C(.*)") then
	ContextMenu_EnableMMCE = "C"
	ContextMenu[3].Name = "     "..nSetLang[38]
else
	ContextMenu_EnableMMCE = ""
	ContextMenu[3].Name = "\194\172  "..nSetLang[38]
end
if string.match(Settings, "(.*)U(.*)") then
	ContextMenu_EnableUSB = "U"
	ContextMenu[4].Name = "     "..nSetLang[20]
else
	ContextMenu_EnableUSB = ""
	ContextMenu[4].Name = "\194\172  "..nSetLang[20]
end
if string.match(Settings, "(.*)D(.*)") then
	ContextMenu_EnableUDPBD = "D"
	ContextMenu[5].Name = "     "..nSetLang[31]
else
	ContextMenu_EnableUDPBD = ""
	ContextMenu[5].Name = "\194\172  "..nSetLang[31]
end
if string.match(Settings, "(.*)I(.*)") then
	ContextMenu_EnableILINK = "I"
	ContextMenu[6].Name = "\194\172  "..nSetLang[34]
else
	ContextMenu_EnableILINK = ""
	ContextMenu[6].Name = "     "..nSetLang[34]
end
if string.match(Settings, "(.*)L(.*)") then
	ContextMenu_EnableHDL = "L"
	ContextMenu[7].Name = "\194\172  "..nSetLang[40]
else
	ContextMenu_EnableHDL = ""
	ContextMenu[7].Name = "     "..nSetLang[40]
end
if string.match(Settings, "(.*)1(.*)") then
	ContextMenu_DisableDisc = "1"
	ContextMenu[8].Name = "\194\172  "..nSetLang[8]
else
	ContextMenu_DisableDisc = ""
	ContextMenu[8].Name = "     "..nSetLang[8]
end
if string.match(Settings, "(.*)8(.*)") then
    ContextMenu_DisableBg = "8"
    ContextMenu[9].Name = "\194\172  "..nSetLang[36]
else
    ContextMenu_DisableBg = ""
    ContextMenu[9].Name = "     "..nSetLang[36]
end
if string.match(Settings, "(.*)2(.*)") then
	ContextMenu_DisableStatus = "2"
	ContextMenu[10].Name = "\194\172  "..nSetLang[9]
else
	ContextMenu_DisableStatus = ""
	ContextMenu[10].Name = "     "..nSetLang[9]
end
if string.match(Settings, "(.*)7(.*)") then
	ContextMenu_DisableFade = "7"
	ContextMenu[11].Name = "\194\172  "..nSetLang[28]
else
	ContextMenu_DisableFade = ""
	ContextMenu[11].Name = "     "..nSetLang[28]
end
if string.match(Settings, "(.*)3(.*)") then
	ContextMenu_DisableAnim = "3"
	ContextMenu[12].Name = "\194\172  "..nSetLang[15]
else
	ContextMenu_DisableAnim = ""
	ContextMenu[12].Name = "     "..nSetLang[15]
end
if string.match(Settings, "(.*)4(.*)") then
	ContextMenu_ShowTitleId = "4"
	ContextMenu[13].Name = "     "..nSetLang[25]
else
	ContextMenu_ShowTitleId = ""
	ContextMenu[13].Name = "\194\172  "..nSetLang[25]
end
if string.match(Settings, "(.*)6(.*)") then
	ContextMenu_ShowMedia = "6"
	ContextMenu[14].Name = "     "..nSetLang[27]
else
	ContextMenu_ShowMedia = ""
	ContextMenu[14].Name = "\194\172  "..nSetLang[27]
end
if System.doesFileExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/lastart.cfg") then
    ContextMenu[15].Name = nSetLang[11]
else
    ContextMenu[15].Name = nSetLang[12]
end
ContextMenu[16].Name = nSetLang[32]

function ContextMenu_ReadList(ListFile)
    ContextMenu_TempFile = nil
    ContextMenu_TempFile = io.open(ListFile, "r")
    if ContextMenu_TempFile then
        for line in ContextMenu_TempFile:lines() do
            if line ~= "" and string.match(line, "(.*) (.*)")then
                line = string.gsub(line, "\x0D", "")
                ContextMenu_GamesTotal = ContextMenu_GamesTotal+1
                ContextMenu_Games[ContextMenu_GamesTotal] = {};
                ContextMenu_Games[ContextMenu_GamesTotal].TitleId = string.sub(line, 1, 11)
            end
        end
    end
end

function ContextMenu_CleanCache()
    ContextMenu_Games = {}
    ContextMenu_GamesTotal = 0
    if System.doesFileExist("mass:XEBPLUS/CFG/neutrinoLauncher/neutrinoUSB.list") then
        ContextMenu_ReadList("mass:XEBPLUS/CFG/neutrinoLauncher/neutrinoUSB.list")
    end
    if System.doesFileExist("mass:XEBPLUS/CFG/neutrinoLauncher/neutrinoHDD.list") then
        ContextMenu_ReadList("mass:XEBPLUS/CFG/neutrinoLauncher/neutrinoHDD.list")
    end
    if System.doesFileExist("mass:XEBPLUS/CFG/neutrinoLauncher/neutrinoMX4.list") then
        ContextMenu_ReadList("mass:XEBPLUS/CFG/neutrinoLauncher/neutrinoMX4.list")
    end
    if System.doesFileExist("mass:XEBPLUS/CFG/neutrinoLauncher/neutrinoUDPBD.list") then
        ContextMenu_ReadList("mass:XEBPLUS/CFG/neutrinoLauncher/neutrinoUDPBD.list")
    end

    ContextMenu_Removed = 0
    ContextMenu_DiscFolder = System.listDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/DISC/")
	ContextMenu_BgFolder = System.listDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/BG/")
	for ContextMenu_i = 1, #ContextMenu_DiscFolder do
        ContextMenu_FileName = string.gsub(ContextMenu_DiscFolder[ContextMenu_i].name, ".png", "")
        Screen.clear()
		thmDrawBKG()
		Font.ftPrint(fontBig, 420, plusYValue+256, 11, 512, 64, neuLang[5].."\n"..ContextMenu_Removed.." files removed.", Color.new(255,255,255,128))
		thmDrawBKGOL()
		Screen.waitVblankStart()
		Screen.flip()

        for ContextMenu_j = 1, ContextMenu_GamesTotal + 1 do
            if ContextMenu_j == ContextMenu_GamesTotal + 1 then
                System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/DISC/"..ContextMenu_DiscFolder[ContextMenu_i].name)
                ContextMenu_Removed = ContextMenu_Removed + 1
            elseif ContextMenu_FileName == ContextMenu_Games[ContextMenu_j].TitleId then
                break
            end
        end
	end
    for ContextMenu_i = 1, #ContextMenu_BgFolder do
        ContextMenu_FileName = string.gsub(ContextMenu_BgFolder[ContextMenu_i].name, ".png", "")
        Screen.clear()
		thmDrawBKG()
		Font.ftPrint(fontBig, 420, plusYValue+256, 11, 512, 64, neuLang[45].."\n"..ContextMenu_Removed.." files removed.", Color.new(255,255,255,128))
		thmDrawBKGOL()
		Screen.waitVblankStart()
		Screen.flip()

        for ContextMenu_j = 1, ContextMenu_GamesTotal + 1 do
            if ContextMenu_j == ContextMenu_GamesTotal + 1 then
                System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/BG/"..ContextMenu_BgFolder[ContextMenu_i].name)
                ContextMenu_Removed = ContextMenu_Removed + 1
            elseif ContextMenu_FileName == ContextMenu_Games[ContextMenu_j].TitleId then
                break
            end
        end
	end
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
        Font.ftPrint(fontSmall, 408+movec, plusYValue+408, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
    else
        Font.ftPrint(fontSmall, 408+movec, plusYValue+408, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
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
        Font.ftPrint(fontSmall, 408, plusYValue+408, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
    else
        Font.ftPrint(fontSmall, 408, plusYValue+408, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
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
            if ContextMenu_EnableMX4 == "" then
                ContextMenu_EnableMX4 = "M"
                ContextMenu[2].Name = "     "..nSetLang[21]
            else
            	ContextMenu_EnableMX4 = ""
                ContextMenu[2].Name = "\194\172  "..nSetLang[21]
            end
            
        elseif ContextMenu_SelectedItem == 3 then
            if ContextMenu_EnableMMCE == "" then
                ContextMenu_EnableMMCE = "C"
                ContextMenu[3].Name = "     "..nSetLang[38]
            else
            	ContextMenu_EnableMMCE = ""
                ContextMenu[3].Name = "\194\172  "..nSetLang[38]
            end
            
        elseif ContextMenu_SelectedItem == 4 then
            if ContextMenu_EnableUSB == "" then
                ContextMenu_EnableUSB = "U"
                ContextMenu[4].Name = "     "..nSetLang[20]
            else
            	ContextMenu_EnableUSB = ""
                ContextMenu[4].Name = "\194\172  "..nSetLang[20]
            end
        elseif ContextMenu_SelectedItem == 5 then
            if ContextMenu_EnableUDPBD == "" then
                ContextMenu_EnableUDPBD = "D"
                ContextMenu[5].Name = "     "..nSetLang[31]
            else
            	ContextMenu_EnableUDPBD = ""
                ContextMenu[5].Name = "\194\172  "..nSetLang[31]
            end
        elseif ContextMenu_SelectedItem == 6 then
            if ContextMenu_EnableILINK == "" then
                ContextMenu_EnableILINK = "I"
                ContextMenu[6].Name = "\194\172  "..nSetLang[34]
            else
            	ContextMenu_EnableILINK = ""
                ContextMenu[6].Name = "     "..nSetLang[34]
            end
        elseif ContextMenu_SelectedItem == 7 then
            if ContextMenu_EnableHDL == "" then
                ContextMenu_EnableHDL = "L"
                ContextMenu[7].Name = "\194\172  "..nSetLang[40]
            else
            	ContextMenu_EnableHDL = ""
                ContextMenu[7].Name = "     "..nSetLang[40]
            end
        elseif ContextMenu_SelectedItem == 8 then
            if ContextMenu_DisableDisc == "" then
                ContextMenu_DisableDisc = "1"
                ContextMenu[8].Name = "\194\172  "..nSetLang[8]
            else
                ContextMenu_DisableDisc = ""
                ContextMenu[8].Name = "     "..nSetLang[8]
            end
        elseif ContextMenu_SelectedItem == 9 then
            if ContextMenu_DisableBg == "" then
                ContextMenu_DisableBg = "8"
                ContextMenu[9].Name = "\194\172  "..nSetLang[36]
            else
                ContextMenu_DisableBg = ""
                ContextMenu[9].Name = "     "..nSetLang[36]
            end
        elseif ContextMenu_SelectedItem == 10 then
            if ContextMenu_DisableStatus == "" then
                ContextMenu_DisableStatus = "2"
                ContextMenu[10].Name = "\194\172  "..nSetLang[9]
            else
                ContextMenu_DisableStatus = ""
                ContextMenu[10].Name = "     "..nSetLang[9]
            end
        elseif ContextMenu_SelectedItem == 11 then
            if ContextMenu_DisableFade == "" then
                ContextMenu_DisableFade = "7"
                ContextMenu[11].Name = "\194\172  "..nSetLang[28]
            else
                ContextMenu_DisableFade = ""
                ContextMenu[11].Name = "     "..nSetLang[28]
            end

        elseif ContextMenu_SelectedItem == 12 then
            if ContextMenu_DisableAnim == "" then
                ContextMenu_DisableAnim = "3"
                ContextMenu[12].Name = "\194\172  "..nSetLang[15]
            else
                ContextMenu_DisableAnim = ""
                ContextMenu[12].Name = "     "..nSetLang[15]
            end
        elseif ContextMenu_SelectedItem == 13 then
            if ContextMenu_ShowTitleId == "" then
                ContextMenu_ShowTitleId = "4"
                ContextMenu[13].Name = "     "..nSetLang[25]
            else
                ContextMenu_ShowTitleId = ""
                ContextMenu[13].Name = "\194\172  "..nSetLang[25]
            end
        elseif ContextMenu_SelectedItem == 14 then
            if ContextMenu_ShowMedia == "" then
                ContextMenu_ShowMedia = "6"
                ContextMenu[14].Name = "     "..nSetLang[27]
            else
                ContextMenu_ShowMedia = ""
                ContextMenu[14].Name = "\194\172  "..nSetLang[27]
            end
        elseif ContextMenu_SelectedItem == 15 then
            if System.doesFileExist("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/lastart.cfg") then
                System.removeFile("mass:/XEBPLUS/CFG/neutrinoLauncher/.cache/lastart.cfg")
                ContextMenu[15].Name = nSetLang[12]
            end
        elseif ContextMenu_SelectedItem == 16 then
            ContextMenu_CleanCache()
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

ContextMenu_NewSettings = ContextMenu_EnableHDD
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_EnableUSB
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_EnableMX4
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_EnableMMCE
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_EnableUDPBD
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_EnableILINK
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_EnableHDL
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_DisableDisc
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_DisableBg
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_DisableStatus
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_DisableFade
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_DisableAnim
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_ShowTitleId
ContextMenu_NewSettings = ContextMenu_NewSettings..ContextMenu_ShowMedia
if not System.doesDirectoryExist("mass:/XEBPLUS/CFG/neutrinoLauncher") then
	System.createDirectory("mass:/XEBPLUS/CFG/neutrinoLauncher")
end
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
        Font.ftPrint(fontSmall, 408+movec, plusYValue+408, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
    else
        Font.ftPrint(fontSmall, 408+movec, plusYValue+408, 0, 400, 64, ContextMenu[ContextMenu_SelectedItem].Description, baseColorFull)
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
