<h1>XEB+ neutrino HDD Loader Plugin</h1>

This is a plugin for the Xtreme Elite Boot Plus dashboard for the PlayStation 2.<br>It allows XEB+ to load PlayStation 2 games from an exFAT hard drive via <a href="https://github.com/rickgaiser/neutrino">neutrino</a>.

<h2>Features</h2>

  * Load PlayStation 2 game backups straight from the Xtreme Elite Boot Plus dashboard.
  * Supports high capacity exFAT hard drives (currently tested with drives up to 4TB).
  * Quick navigation functions for browsing large game lists.
  * Remember last played game.
  * Display game-specific artwork on the menu.
  * Set neutrino compatibility flags and other options on a global or per-game basis.
  * Favorites list.

<h2>Requirements</h2>

  * A phat PlayStation 2 console configured to run unsigned code via an exploit such as FreeMCBoot or PS2BBL
  * A PlayStation 2 network adapter or hard drive add-on
  * A hard drive or SSD that is compatible with your Playstaion 2 network adapter or hard drive add-on
  * A FAT32 formatted USB drive (4GB or less recommended)
  * A Windows or Linux PC
  * A PC hard drive dock or USB adapter (optional)

<h2>Setup</h2>

1. If you have not already done so, download the Xtreme Eliete Boot Plus Xmas 2021 showcase <a href="http://web.archive.org/web/20221225042045/http://www.hwc.nat.cu/ps2-vault/hwc-projects/xebplus/">here</a>.<br>Extract the `XEBPLUS` folder to the root of your USB drive, and ensure that you can load into the XEB+ dashboard on your PlayStation 2.<br>You may wish to configure your PS2 exploit of choice to autorun XEB+ on startup.
2. Connect your hard drive or SSD to the PC, and format it as an exFAT partition.<br>Create folders named `CD` and `DVD` on the root of the drive. Rip/copy any PlayStation 2 disc images you wish to load into the folder that corresponds with their original source media. All disc images must be in *.iso* format.
3. Extract the `XEBPLUS` folder contained in this package to the root of the USB drive from step 1. Choose to merge any folders if prompted.
4. Navigate to the folder within the neutrino loader HDD package that corresponds to your operating system. Extract the `run_on_HDD` script to the root of the drive containing your PS2 disc images from step 2. 
5. Lunch `run_on_HDD.bat` or `run_on_HDD.sh` from the root of the hard drive. The script will create a new folder next to the `CD` and `DVD` folders, called `USB`.<br>The newly created `USB` folder contains a copy of the adjacent `CD` and `DVD` folders, however all the files within these copies are 0 bytes in size.
6. Copy / move the `CD` and `DVD` folders from within the `USB` folder to the root of your USB drive, next to the `XEBPLUS` folder.<br>The Neutrino Loader plugin uses the 0 byte files within these folders as references to the disc images on the hard drive.<br>Games may be missing, or fail to load, if there is as mismatch between the file names in the `CD` and `DVD` folders on the hard drive, and those on the USB.
7. Eject both drives from the computer. Connect the hard drive / SSD to the PlayStation 2 via the network adapter, and plug the USB drive into either of the front USB ports.<br>*neutrino Launcher (HDD)* and *neutrino Launcher (HDD) Settings* should now be available from the XEB+ dashboard. 

<h3>Adding Artwork</h3>
The Neutrino HDD Loader plugin can display game-specific artwork in the selection menu. This feature uses the same file type and naming conventions as Open PS2 Loader, which allows the plugin to take advantage of existing PS2 artwork libraries designed for OPL.<br><br>To make use of this feature, the following additional steps are required:

 1. Ensure that the game(s) you wish to display artwork for have their PlayStation 2 title ID somewhere in the filename.<br>Most title ID formats will work, such as `SLUS_123.45`, `SLUS-12345`, `SLUS.12345`, `SLUS12345`, ect.<br>If changing filenames, remember to do so for both the file on the hard drive and it's corresponding 0-byte reference on the USB.
 2. Prepare or acquire artwork files with the same file format and naming conventions as those used by OPL.<br>Note that only background (*_BG*) and disc art (*_ICO*) files are used by this plugin.
 3. Copy the artwork files you wish to use to `/XEBPLUS/GME/ART` on your USB drive. It is recommended that you copy as few files as possible to this directory.
 4. Launch XEB+ and select the Neutrino Loader (HDD) plugin. If the plugin detects files at `/XEBPLUS/GME/ART`, it will automatically create an artwork cache in the plugin folder. This is necessary to maintain a usable level of performance while displaying artwork in the menu.<br>The caching process can take a long time to complete the first time it runs, potentially up to several hours if you have a very large game library. Reducing the number for files in the `ART` folder can speed up this process somewhat.

Changing the contents of the `CD` or `DVD` folders on the USB drive, or modifying the cache folder, will trigger a refresh of the artwork cache the next time the plugin is launched. A refresh can also be triggered manually from the plugin settings.<br>Cache refreshes take much less time than initial creation, so long as the cache folder has not been moved or deleted.

<h2>Usage</h2>
<h3>Controls</h3>
CROSS -         <b>confirm / launch game</b><br>
CIRCLE / LEFT - <b>cancel / close plugin</b><br>
SQUARE -        <b>open context menu</b><br>
TRIANGLE -      <b>show favorites / show all</b><br>
DOWN -          <b>scroll down</b><br>
UP -            <b>scroll up</b><br>
R1 -            <b>scroll down 10 items</b><br>
L1 -            <b>scroll up 10 items</b><br>
R2 -            <b>jump to next letter</b><br>
L2 -            <b>jump to previous letter</b><br>
R3 -            <b>jump to bottom of list</b><br>
L3 -            <b>jump to top of list</b><br>
SELECT -        <b>view control map</b>
<h3>Basic Usage</h3>

Launch the XEB+ dashboard on your PlayStation 2 console, and select *Neutrino Launcher (HDD)* from the menu.<br>Wait a moment for the plugin to load. If there are artwork files present, you may need to wait for the artwork cache to build or refresh.<br>Select a game from the list to launch it with Neutrino, or press back to close the plugin.<br>Repeat steps 4-5 of the setup process each time you add or remove games on the hard drive.

<h3>Game Options</h3>
Press SQUARE while in the game selection menu, and the context menu will open.<br>Context menu options apply to the currently highlighted game by default, and are as follows:

  * **Add To Favorites** - Adds the current game to the favorites list. If the current game is already in the favorites list, this option will remove it.
  * **Global / Per-Game Settings** - This option toggles between Global and Per-Game settings modes.<br>When set to Global Settings, options shown below this one will apply to all games.<br>When set to Per-Game Settings, options shown below this one will apply only to the current game.
  * **Enable Boot Logo** - When enabled, the PlayStation 2 logo will be shown on screen when starting a game. This slightly increases the start time.
  * **Enable Debug Colors** - When enabled, a series of colors will flash on screen when starting a game. This can be used to help diagnose games that will not start.
  * **Accurate Reads** - When enabled, the data transfer rate for games will be limited to that of the PlayStation 2 DVD drive. This will increase load times, but can fix compatibility issues with some titles.
  * **Synchronous Reads** - When enabled, asynchronous (background) loading will not be used. This can affect load times, and fixes compatibility issues with some titles.
  * **Unhook Syscalls** - When enabled, neutrino Syscalls will be removed from memory after starting a game. This fixes compatibility issues with some titles.
  * **Emulate DVD-DL**- When enabled, neutrino will emulate the data structure of a dual-layer DVD. This option is required for DVD9 images that have been modified to fit a DVD5.
  * **Refresh Artwork** - Immediately delete and re-copy cached artwork for the current game. This option is only available for games with a valid title ID in their filename, and is not affected by the current settings mode.

Closing the context menu will automatically save the currently selected options. 

<h3>Favorites</h3>
Games can be added to a favorites list for easy organization and quicker access.<br>
To add a game to the favorites list, open the context menu and select "Add To Favorites", as described in the previous section. Repeat this process to remove a game from the favorites list.<br>When a game is in he favorites list, the word "Favorite" will be show below it's file name on the game selection menu.<br>
To access the favorites list, press TRIANGLE while on the game selection menu. Press TRIANGLE again to show all games.<br>The plugin will always start up to the all games list, even if it was previously closed while viewing the favorites list.

<h3>Neutrino HDD Loader Settings</h3>
This package includes a secondary plugin called <i>neutrino Launcher (HDD) Settings</i>, which is accessible from the far right column of the XEB+ dashboard.<br>This contains a settings menu whose options apply to the main neutrino Loader plugin. The available options are as follows:

  * **Disable Artwork** - When enabled, game specific artwork will not be shown on the menu. This can prevent the cache from auto-refreshing in some cases.
  * **Disable Status Messages** - When enabled, the text that appears at the bottom of the screen to indicate loading and other behavior will not be shown.
  * **Disable Icon Animation** - When enabled, the disc icon for the current game will not spin
  * **Refresh Artwork Cache** - Sets artwork cache to refresh next time the main plugin is loaded


<h2>Known Issues and Limitations</h2>

  * Artwork cannot be refreshed from the context menu while in the favorites list.
  * If an artwork cache build / refresh is interrupted, the system may crash the next time the plugin is loaded.<br>If this happens, the behavior will persist until the cache is refreshed manually.
  * The neutrino Loader plugin can take up to 30 seconds to load, and may appear to hang if there are a large number of games present.
  * If enabled, the PlayStation 2 boot logo will display incorrectly for games that do not match the console's region.
  * Repeatedly closing and re-opening the Neutrino Loader plugin can cause the system to crash.
  * Scrolling through the list quickly may cause corrupted graphics to be displayed briefly.
  * This plugin does not currently support virtual memory cards. Further development / testing is required to implement this feature.
