NEUTRINO_Bsd = "udpbd"
NEUTRINO_Fs = " -bsdfs=exfat"
NEUTRINO_PathPrefix = "mass"
NEUTRINO_ListFile = "mass:XEBPLUS/CFG/neutrinoLauncher/neutrinoUDPBD.list"
NEUTRINO_DataFolder = "mass:XEBPLUS/CFG/neutrinoLauncher/UDPBD/"

dofile(xebLua_AppWorkingPath.."neutrinoLauncher.lua")
