# Sinden_Lightgun_Autostart (v2.00)
A utility to automatically start and stop Sinden Lightgun used in RetroPie, with options.

**This branch is currently a work-in-progress.**
**Intended for use only with Barebones 9.2 and the v2.05 Sinden driver software**

This utility is very clean. Everything is self-contained within one script and references to this script placed only where necessary, making use of command line switches to activate different functions.  I've tried to make the code as economical as possible, so it doesn't take up thousands of lines of repetition where only a hundred or so is necessary.

# What's new?
Many of the features of the earlier version of the utility are no longer required, thanks to feature improvements in the new Sinden Driver software.  It's no longer necessary to have multiple configs for different recoil states as the new Sinden software now allows you to toggle recoil in-game. So the only need that remains is the option to enable/disable autostart. 

The previous version took into account the unique config required by the Supermodel emulator. However, the latest version of Supermodel 3 used in Barebones 9.2 uses an improved raw mouse input system that doesn't requre a ratio adjustment so this is no longer required.


## WARNING ##
**If you already have some other autostart utility in place, and you want to use this one, make sure you purge the other one first. There's no telling what those two guys will get up to if left alone in the same space!**

## How to install
**If you already have an older version of the install script, you should delete it first. It will not be overwritten by the wget command below**

If running from the Pi itself with a connected keyboard, press `F4` to exit EmulationStation and reach the command line.

Or you can connect to your Pi via SSH using a reliable utility such as PuTTY.

From the command line, type the following:
```
cd /home/pi/
wget https://github.com/Widge-5/Sinden_Lightgun_Autostart/raw/main/autostart_install.sh
chmod +x autostart_install.sh
sudo ./autostart_install.sh
```
This will download the script to your `/home/pi` folder and make it executable. The last line executes the script.

When you run the script you will be asked whether your Sinden start scripts are in the Sinden group (for BB9) or the Ports group (for BB8).

The script will then download the files needed and install them in their appropriate locations.

If the `widgeutils.cfg` file doesn't already exist on your system, then it is generated by the installer.  If it does exist, the installer will check if the variables needed by this tool are contained within and, if not, it will add them in with default values.

The install script will offer to delete itself then you will be prompted to restart EmulationStation.

## What to expect
In the Sinden (or Ports) group, you will find a new script available called Sinden Lightgun Autostart Options.  Executing this script will launch a menu system that will enable you to edit the way the Autostart will work.
The Autostart is designed to only start the guns if it identifies the game being launched as a lightgun game.  The purpose of this is to ensure that your Pi isn't burdened with unnecessarily allocating resources to running the guns when you want to play a non-lightgun game.  It identifies games as Lightgun Games by their inclusion in a Collection of lightgun games which you will need to create.
If you do not already have such a  Collection, you can create one in EmulationStation as follows:
- In EmulationStation, press `Start` then go to `Game Collection Setings` --> `Create New Custom Collection`.  Then type in a name for it, such as "Lightgun Games" using a connected keyboard.
- Then go through your games and press `Y` to add/remove games to the Collection.
- When you've finished, restart EmulationStation so the additions to the Collection are written to the file.
- Later, you can update the Collection by going to the Collections group, selecting the collection, pressing `Select` and choosing `Add/Remove Games To This Collection`.

You may already have a `widgeutils.cfg` file present on your system from another utility. If you don't already have `widgeutils.cfg` on your system, then it is generated by the the utility when it is first run.  If it does exist, the installer will check if the variables needed by this tool are contained within and, if not, it will add them in with default values.

When you first visit the Options menu, the first thing you should usually do is choose `Set Lightgun Collection File` in order to apply the Collection file you created earlier. Then `Save Changes`.  The utility will not work if no Collection file is set unless you choose to autostart the guns indiscriminitely. The Collection file chosen will be remembered and can be changed later if needed.

The options available are as follows : 
- `Autostart Lightguns` [on/off] - Choose to Enable the Autostart function, or disable it entirely.  When enabled, the guns will be started automatically on launch of any game present in your chosen Collection, and will be stopped when the game closes.  Both Start and Stop functions are disabled if this setting is `off`.
- `Indiscriminite (all games)` - Choose whether the enabled Autostart function should check if a lightgun game is being launched or not. If this is `on` then the gun(s) will be started regardless of what type of game you launched. This might be useful if you have a lightgun-only image and don't want to create a Collection file.
- `Set Lightgun Collection File` - Define the Collection file that Autostart will refer to in order to identify a lightgun game. This is necessary if `Autostart` is `on` and `Indiscriminite` is `off`.  If both the above are `on` then this is not necessary.
- `Save Changes` - This must be applied after making your selections for them to take effect.
- `Reset Unsaved Changes` - Restore these settings to those currently saved.



## Uninstalling
If you want to uninstall, from terminal just type `sudo /home/pi/Lightgun/utils/sindenautostart.sh -u`  You will be asked for confirmation then the script will remove the commands it placed in EmulationStation files and then delete itself.  The `widgeutils.cfg` file won't be deleted because it is a shared cfg with other utilities of mine so might still be needed, but it's harmless if not.
