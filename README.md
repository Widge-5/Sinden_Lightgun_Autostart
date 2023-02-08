# Sinden_Lightgun_Autostart (v1.02)
A utility to automatically start and stop Sinden Lightgun used in RetroPie, with options.


## How to install
**If you already have an older version of the install script, you should delete it first. It will not be overwritten by the wget command below**

If running from the Pi itself with a connected keyboard, press `F4` to exit EmulationStation and reach the command line.

Or you can connect to your Pi via SSH using a reliable utility such as PuTTY.

From the command line, type the following:
```
cd /home/pi/
wget https://github.com/Widge-5/Sinden_Lightgun_Config_Editor/raw/main/autostart_install.sh
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

The utility is pre-configured with the addresses of the Lightgun config files as they are in BareBones.  If your config files are in another location then you should edit the variables in the config file at `/home/pi/Lightgun/utils/widgeutils.cfg`.

When you first visit the Options menu, hte first thing you should do is choose `Set Lightgun Collection File` in order to apply the Collection file you created earlier. Then `Save Changes`.  The utility will not work if no Collection file is set. The Collection file chosen will be remembered and can be changed later if needed.

The options available are as follows : 
- `Autostart Lightguns` [on/off] - Choose to Enable the Autostart function, or disable it entirely.  When enabled, the guns will be started automatically on launch of any game present in your chosen Collection, and will be stopped when the game closes.  Both Start and Stop functions are disabled if this setting is `off`.
- `Set Global Recoil` [all off|single|auto|individual] - This decides which recoil option is used by all connected guns.  Making a selection here automatically adjusts the individual guns' recoil types.
- `PX Recoil` [off|single|auto] - (X is a the Player number 1-4) Choose which recoil type to use for each individual player. This setting is automatically adjusted by the Global setting above, or setting this independantly will automatically adjust the Global setting to `individual`.
- `Reset recoil on each boot` - Enabling this option will automatically reset the Global recoil option to `all off` each time your Pi is booted up. Disabling this option will preserve the last setings used on each boot.  You may wish to enable this option if you only occasionally use recoil and you might forget to disable it again after a session.
- `Set Lightgun Collection File` - Define the Collection file that Autostart will refer to in order to identify a lightgun game.
- `Save Changes` - This must be applied after making your selections for them to take effect.
- `Reset Unsaved Changes` - Restore these settings to those currently saved.

Finally, this Autostart also takes into account the unique config required by the Supermodel emulator.  If the lightgun game being launched is a Supermodel game then it will use the Supermodel-specific lightgun config files which apply a ratio correction to the lightgun tracking.
