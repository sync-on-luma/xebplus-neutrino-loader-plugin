import hashlib
import os

FinalList = ''
GameCount = 0
if not os.path.exists('hdl_toc.txt'):
    print('Missing hdl_toc.txt')
    print('Press Enter to Exit:')
    input()
    exit()
with open('hdl_toc.txt', 'r', encoding="utf-8") as hdl_toc:
    AllLines = hdl_toc.readlines()

for TempLine in AllLines:
    TempMedia = TempLine.split(' ')[0]
    if TempMedia.find("DVD") == -1 and TempMedia.find("CD") == -1:
        continue

    TempSplitLine = TempLine.split(' ')
    for TempSection in TempSplitLine:
        if '_' in TempSection and len(TempSection) == 11:
            TempGameID = TempSection
            break

    TempMask = TempLine.split(TempGameID)[0]
    TempGameName = TempLine.replace(TempMask, '').replace(TempGameID + '  ', '', 1).replace('\n', '').replace('\r', '')

    FinalList += TempGameID + ' /' + TempMedia + '/' + TempGameName + '.iso\n'
    GameCount += 1

if GameCount < 1:
    print('0 HDL format games were found in hdl_toc.txt')
    print('Press Enter to Exit:')
    input()
    exit()
ListHash = hashlib.md5(FinalList.encode("utf-8")).hexdigest()
FinalList += ListHash
with open('neutrinoHDL.list', 'w', encoding="utf-8") as HDLList:
    HDLList.write(FinalList)
print('The list of all HDL format games has been saved to neutrinoHDL.list')
print('Copy neutrinoHDL.list to the XEBPLUS USB drive in this location: XEBPLUS/CFG/neutrinoLauncher/neutrinoHDL.list')
print('Press Enter to Exit:')
input()
