<h1>XEB+ neutrino Launcher Plugin</h1>

This is a plugin for the Xtreme Elite Boot Plus dashboard for the PlayStation 2.<br>It allows XEB+ to load PlayStation 2 games from HDD, USB and MX4SIO via [neutrino](https://github.com/rickgaiser/neutrino).

<h2>Features</h2>

  * Load PlayStation 2 game backups straight from the Xtreme Elite Boot Plus dashboard.
  * Supports game loading from HDD, MX4SIO, and USB.
  * Supports high capacity exFAT drives (currently tested with drives up to 4TB).
  * Quick navigation functions for browsing large game lists.
  * Remember last played game.
  * Display game-specific artwork on the menu.
  * Display metadata for each game.
  * Set neutrino compatibility flags and other options on a global or per-game basis.
  * Favorites list.
  * Custom theme integration.

<h2>Requirements</h2>

  * A PlayStation 2 console configured to run unsigned code via a custom boot loader.<br>[PS2BBL](https://israpps.github.io/PlayStation2-Basic-BootLoader/) is the recommended option, and is required for USB loading.
  * A computer with a recent version of [Python](https://www.python.org/) installed.
  * All of the requirements specific to the device you want to load games from.
 
<h3>HDD</h3>

  * A Phat PlayStation 2 console.
  * A PlayStation 2 network adapter or hard drive add-on.
  * A hard drive or SSD that is compatible with your Playstaion 2 network or hard drive adapter.
  * A FAT32 or exFAT formatted USB drive 1GB or larger.
  * A PC hard drive dock or USB adapter (optional)
    
<h3>MX4SIO</h3>

  * An MX4SIO adapter
  * An exFAT formatted SD card no less than 4GB in size.<br>32GB or larger is recommended.
  * A FAT32 or exFAT formatted USB drive 1GB or larger.
  * A USB SD card reader (optional)
    
<h3>USB</h3>

  * An exFAT formatted USB drive no less than 4GB in size.<br>32GB or larger is recommended.

<h2>Setup</h2>

*Note: This setup process is for version 2 of this plugin. If you have previously installed version 1, you will need to remove the old version of neutrino Launcher from your XEB+ install before continuing.<br>This includes all neutrino Launcher files in the `APPS`, `PLG`, and `CFG` folders, as well as the `CD` and `DVD` folders on the root of your USB drive.*

1. If you have not already done so, download the Xtreme Eliete Boot Plus Xmas 2021 showcase [here](http://web.archive.org/web/20221225042045/http://www.hwc.nat.cu/ps2-vault/hwc-projects/xebplus/).
2. Extract the `XEBPLUS` folder to the root of your USB drive, and ensure that you can load into the XEB+ dashboard on your PlayStation 2.<br>Note that if you are using an exFAT formatted USB drive, you will need to use PS2BBL and [this version](https://github.com/israpps/wLaunchELF_ISR) of wLaunchELF. 
3. (optional) Configure your PS2 exploit of choice to autorun XEB+ on startup.
4. Download the latest version of this plugin from the Releases section.<br>Extract the`XEBPLUS`folder to the root of your USB drive, merging all folders if prompted.
5. Extract the version of the neutrino List Builder application that corresponds to your operating system to a known location on your computer.
6. Complete setup by following the steps specific to the device you want to load games from.


<h3>HDD</h3>

<ol start="7">
<li>Connect your hard drive or SSD to a computer, and format it as an exFAT partition.</li>
<li>Create folders named <code>CD</code> and <code>DVD</code> on the root of the hard drive.</li>
<li>Rip/copy any PlayStation 2 disc images you wish to load into the folder that corresponds with their original source media.<br>All disc images must be in <i>.iso</i> format.</li>
<li>Run <code>GUI.py</code> from the included <code>List Builder</code> folder, and select <i>PS2 HDD</i> under <i>Drive Type</i>.</li>
<li>Click the <i>Browse</i> button under <i>XEBPLUS Location</i> and navigate to the root of the USB drive containing your XEB+ install.</li>
<li>Click the <i>Browse</i> button under <i>Games Location</i> and navigate to the root of your hard drive.</li>
<li>Click <i>Build List</i> and wait for the process to complete.</li>
<li>Eject both drives from the computer. Connect the hard drive / SSD to the PlayStation 2 via the network adapter, and plug the USB drive into either of the front USB ports.</li>
<li>Launch XEB+ on the PS2, and use <i>neutrino Launcher (HDD)</i> to load games from the hard drive.</li>
</ol>
Repeat steps 9-13 to add or remove games on the hard drive.

<h3>MX4SIO</h3>

<ol start="7">
<li>Connect your SD card to the computer, and format it as an exFAT partition.</li>
<li>Create folders named <code>CD</code> and <code>DVD</code> on the root of the SD card.</li>
<li>Rip/copy any PlayStation 2 disc images you wish to load into the folder that corresponds with their original source media.<br>All disc images must be in <i>.iso</i> format.</li>
<li>Run <code>GUI.py</code> from the included <code>List Builder</code> folder, and select <i>MX4SIO</i> under <i>Drive Type</i>.</li>
<li>Click the <i>Browse</i> button under <i>XEBPLUS Location</i> and navigate to the root of the USB drive containing your XEB+ install.</li>
<li>Click the <i>Browse</i> button under <i>Games Location</i> and navigate to the root of your SD card.</li>
<li>Click <i>Build List</i> and wait for the process to complete.</li>
<li>Eject both drives from the computer. Insert the SD card into an MX4SIO adapter and connect it to memory card slot 2 on the PlayStation 2. Plug the USB drive into either of the front USB ports.</li>
<li>Launch XEB+ on the PS2, and use <i>neutrino Launcher (MX4SIO)</i> to load games from the SD card.</li>
</ol>
Repeat steps 9-13 to add or remove games on the SD card.

<h3>USB</h3>

<ol start="7">
<li>Ensure your USB drive is formatted as an exFAT partition. You will need to reformat it and repeat steps 2-4 if it is not.</li>
<li>Create folders named <code>CD</code> and <code>DVD</code> on the root of the USB drive.</li>
<li>Rip/copy any PlayStation 2 disc images you wish to load into the folder that corresponds with their original source media.<br>All disc images must be in <i>.iso</i> format.</li>
<li>Run <code>GUI.py</code> from the included <code>List Builder</code> folder, and select <i>USB</i> under <i>Drive Type</i>.</li>
<li>Click the <i>Browse</i> button under <i>XEBPLUS Location</i> and navigate to the root of your USB drive.<br>The <i>Games Location</i> will automatically be set to the same folder.</li>
<li>Click <i>Build List</i> and wait for the process to complete.</li>
<li>Eject the USB drive and plug it into either of the front USB ports on the PlayStation 2.</li>
<li>Launch XEB+ on the PS2, and use <i>neutrino Launcher (USB)</i> to load games from the USB drive.</li>
</ol>
Repeat steps 9-12 to add or remove games on the USB drive.


<h3>Adding Artwork</h3>

The neutrino Launcher plugin can display game-specific artwork in the selection menu. This feature uses the same file type and naming conventions as Open PS2 Loader, which allows the plugin to take advantage of existing PS2 artwork libraries designed for OPL.<br> To make use of this feature, the following additional steps are required:

1. Prepare or acquire artwork files with the same file format and naming conventions as those used by OPL.
    * Only background art (*_BG*) and disc icon (*_ICO*) files are used by this plugin.
    * Some recent versions of OPL have added support for 128x128 disc icons. It is strongly recommended to only use the older 64x64 icons.
2. Copy the artwork files you wish to use to `/XEBPLUS/GME/ART` on your USB drive. It is recommended that you copy as few files as possible to this directory.
3. Launch XEB+ and select and of the neutrino Launcher plugins. If the plugin detects files at `/XEBPLUS/GME/ART`, it will automatically create an artwork cache in the `CFG/neutrinoLauncher` folder.<br>This is necessary to maintain a usable level of performance while displaying artwork in the menu.

The caching process can take a long time to complete the first time it runs, potentially up to several hours if you have a very large game library. Reducing the number for files in the `ART` folder can speed up this process somewhat.<br>
Making any changes to the *.list* files in the 'CFG/neutrinoLauncher`, or modifying the cache folder, will trigger a refresh of the artwork cache the next time the plugin is launched. A refresh can also be triggered manually from the plugin settings.<br>Cache refreshes take much less time than initial creation, so long as the cache folder has not been moved or deleted.

<h2>Usage</h2>

<h3>Controls</h3>

CROSS -         **confirm / launch game**<br>
CIRCLE / LEFT - **cancel / close plugin**<br>
SQUARE -        **open context menu**<br>
TRIANGLE -      **show favorites / show all**<br>
DOWN -          **scroll down**<br>
UP -            **scroll up**<br>
R1 -            **scroll down 10 items**<br>
L1 -            **scroll up 10 items**<br>
R2 -            **jump to next letter**<br>
L2 -            **jump to previous letter**<br>
R3 -            **jump to bottom of list**<br>
L3 -            **jump to top of list**<br>
SELECT -        **view control map**
<h3>Basic Usage</h3>

Launch the XEB+ dashboard on your PlayStation 2 console, and select the appropriate *neutrino Launcher* entry from the menu.<br>Wait a moment for the plugin to load. If there are artwork files present, you may need to wait for the artwork cache to build or refresh.<br>Select a game from the list to launch it with neutrino, or press back to close the plugin.<br>Repeat steps 9-14 of the setup process for your drive type each time you want to add or remove games.

<h3>Game Options</h3>

Press SQUARE while in the game selection menu, and the context menu will open.<br>Context menu options apply to the currently highlighted game by default, and are as follows:

  * **Add To Favorites** - Adds the current game to the favorites list. If the current game is already in the favorites list, this option will remove it.
  * **Global / Per-Game Settings** - This option toggles between Global and Per-Game settings modes.<br>When set to Global Settings, options shown below this one will apply to all games.<br>When set to Per-Game Settings, options shown below this one will apply only to the current game.
  * **Enable Boot Logo** - When enabled, the PlayStation 2 logo will be shown on screen when starting a game. This slightly increases the start time.
  * **Enable Debug Colors** - When enabled, a series of colors will flash on screen when starting a game. This can be used to help diagnose games that will not start.
  * **Accurate Reads** - When enabled, the data transfer rate for games will be limited to that of the PlayStation 2 DVD drive. This will increase load times if using a hard drive, but can fix compatibility issues with some titles.
  * **Synchronous Reads** - When enabled, asynchronous (background) loading will not be used. This can affect load times, and fixes compatibility issues with some titles.
  * **Unhook Syscalls** - When enabled, neutrino Syscalls will be removed from memory after starting a game. This fixes compatibility issues with some titles.
  * **Emulate DVD-DL**- When enabled, neutrino will emulate the data structure of a dual-layer DVD. This option is required for DVD9 images that have been modified to fit a DVD5.
  * **Refresh Artwork** - Immediately delete and re-copy cached artwork for the current game. This option is not affected by the current settings mode.

Closing the context menu will automatically save the currently selected options. 

<h3>Favorites</h3>

Games can be added to a favorites list for easy organization and quicker access.<br>
The favorites list is shared between all three drive types, however only titles present on the currently selected drive will be displayed.<br>
To add a game to the favorites list, open the context menu and select "Add To Favorites", as described in the previous section. Repeat this process to remove a game from the favorites list.<br>When a game is in the favorites list, it's title will be flanked by "●" on either side.<br>
To access the favorites list, press TRIANGLE while on the game selection menu. Press TRIANGLE again to show all games.<br>The plugin will always start up to the all games list, even if it was previously closed while viewing the favorites list.

<h3>Neutrino Launcher Settings</h3>
This package includes a secondary plugin called *neutrino Launcher Settings*, which is accessible from the far right column of the XEB+ dashboard.<br>This contains a settings menu whose options apply to the main neutrino Launcher plugins. The available options are as follows:
   
   * **Enable HDD** - When enabled, *neutrino Launcher (HDD)* will be available on the XEB+ dashboard.*
   * **Enable MX4SIO** - When enabled, *neutrino Launcher (MX4SIO)* will be available on the XEB+ dashboard.*
   * **Enable USB** - When enabled, *neutrino Launcher (USB)* will be available on the XEB+ dashboard.*
   * **Disable Artwork** - When enabled, game specific artwork will not be shown on the menu. This can prevent the cache from auto-refreshing in some cases.
  * **Disable Status Messages** - When enabled, the text that appears at the bottom of the screen to indicate loading and other behavior will not be shown.
  * **Disable Fade Effect** - When enabled, background artwork will not fade in/out when the image changes.
  * **Disable Icon Animation** - When enabled, the disc icon for the currently highlighted game will not spin.
  *  **Show Title ID** - When enabled, each game's PlayStation 2 title ID will be shown under it's title.
  *  **Show Media** - When enabled, each game's media type will be shown under it's title.
  * **Refresh Artwork Cache** - Sets artwork cache to refresh next time one of the neutrino Launcher plugins is loaded. 

    *An XEB+ reboot/refresh is required for changes made to this setting to take effect.

Returning to the dashboard will automatically save the currently selected options.

<h2>Integrating With Custom Themes</h2>

The three neutrino Launcher plugins and the settings plugin each use their own custom dashboard icon that is not normally present in XEB+. Versions of these icons that are visually consistent with the default XEB+ theme are included and will be loaded with each plugin by default. Alternate icons will be used instead, if icon files with the correct names are present in the current XEB+ theme folder.<br>
The filenames each plugin looks for are as follows:

  * *ic_tool_neutrino_hdl.png* - neutrino Luancher (HDD)
  * *ic_tool_neutrino_mx4.png* - neutrino Luancher (MX4SIO)
  * *ic_tool_neutrino_usb.png* - neutrino Luancher (USB)
  * *ic_set_neutrino_cfg.png* - neutrino Luancher Settings

If you wish to reference the included versions of these icons, they are located at `XEBPLUS/APPS/neutrinoLauncher/image/`.

<h2>Known Issues and Limitations</h2>

  * Artwork cannot be refreshed from the context menu while in the favorites list.
  * The plugin may need to be closed and re-opened for refreshed artwork to be shown.
  * If an artwork cache build / refresh is interrupted, the system may crash the next time the plugin is loaded.<br>If this happens, the behavior will persist until the cache is refreshed manually.
  * The *neutrino Launcher* plugins can take up to 30 seconds to load, and may appear to hang if there are a large number of games present.
  * If enabled, the PlayStation 2 boot logo will display incorrectly for games that do not match the console's region.
  * If installed, the PlayStation 2 hard drive will spin up when loading games from MX4SIO.
  * Repeatedly closing and re-opening the *neutrino Launcher* plugin can cause the system to crash.
  * Scrolling through the list quickly may cause corrupted graphics to be displayed briefly.
  * This plugin does not currently support virtual memory cards. Further development / testing is required to implement this feature.
