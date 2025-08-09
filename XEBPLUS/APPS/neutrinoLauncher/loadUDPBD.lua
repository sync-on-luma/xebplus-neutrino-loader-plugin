NEUTRINO_Bsd = "udpbd"
NEUTRINO_Fs = " -bsdfs=exfat"
NEUTRINO_PathPrefix = "mass"
NEUTRINO_ListFile = "mass:XEBPLUS/CFG/neutrinoLauncher/neutrinoUDPBD.list"
NEUTRINO_DataFolder = "mass:XEBPLUS/CFG/neutrinoLauncher/UDPBD/"
NEUTRINO_InitNetwork = 0

dofile(xebLua_AppWorkingPath.."neutrinoLauncher.lua")
