#!/bin/bash

######################################################################
##
##   Autostart Options for Sinden Lightgun
##   v2.00    June 2023
##   -- ByWidge
##
##   For use with Sinden v2.0x config files
##
######################################################################



###########################
############  GLOBAL ######
###########################

backtitle="Autostart Options for Sinden Lightgun v1.02 -- By Widge"
monodir="/home/pi/Lightgun/Application"
utilscfg="/home/pi/Lightgun/utils/widgeutils.cfg"
collectiondir="/opt/retropie/configs/all/emulationstation/collections"


function builder() { if ! grep -Fq "$1" "$3" ; then echo "$1=\"$2\"" >> $3 ; fi ; }


function cfgmaker() {
  if [ ! -f "$utilscfg" ]; then
    echo > $utilscfg
  fi
  if  ! grep -Fq "[ AUTOSTART SETTINGS ]" "$utilscfg" ; then
    echo >> $utilscfg
    echo "[ AUTOSTART SETTINGS ]" >> $utilscfg
    echo >> $utilscfg
  fi
  builder "<AutostartEnable>" "0" "$utilscfg"
  builder "<AutostartAllGames>" "0" "$utilscfg"
  builder "<LightgunCollectionFile>" "NONE" "$utilscfg"

if ! grep -Fq "sindenautostart.sh" "/opt/retropie/configs/all/runcommand-onlaunch.sh" ; then
    echo >> /opt/retropie/configs/all/runcommand-onlaunch.sh
    echo "/home/pi/Lightgun/utils/sindenautostart.sh -a \"\$1\" \"\$2\" \"\$3\" \"\$4\"" >> /opt/retropie/configs/all/runcommand-onlaunch.sh
  fi
  if ! grep -Fq "sindenautostart.sh" "/opt/retropie/configs/all/runcommand-onend.sh" ; then
    echo >> /opt/retropie/configs/all/runcommand-onend.sh
    echo "/home/pi/Lightgun/utils/sindenautostart.sh -x" >> "/opt/retropie/configs/all/runcommand-onend.sh"
  fi
}



function grabber(){ grep "$1" "$2" | grep -o '".*"' | sed 's/"//g' ; }



function prep() {
  cfgmaker
  cfg_enable=$(grabber "<AutostartEnable>" "$utilscfg")
  cfg_allgames=$(grabber "<AutostartAllGames>" "$utilscfg")
  cfg_collectionfile=$(grabber "<LightgunCollectionFile>" "$utilscfg")
}





function areyousure() {
  dialog --defaultno --title "Are you sure?" --backtitle "$backtitle" --yesno "\nAre you sure you want to $1" 10 70 3>&1 1>&2 2>&3
  echo $?
}



function applychange () { sed -i -e "/.*${2}/s/\".*\"/\"${3}\"/" ${1} ; }

function getvalues() { grep $1 $sourcefile | grep -o 'value=".*"' | sed 's/value="//g' | sed 's/"//g' ; }

function onoffread(){ if [ $2 $1 = "1" ]; then echo "on"; else echo "off"; fi }

function onoffwrite() { if [ ! $1 = "1" ]; then echo "1"; else echo "0"; fi }



##############################
############  MAIN   ########
############################

function savechanges() {
  local yn
  yn=$(areyousure "save these changes?")
  if [ $yn == "0" ]; then
    applychange "$utilscfg" "AutostartEnable"        $cfg_enable
    applychange "$utilscfg" "AutostartAllGames"        $cfg_allgames
    applychange "$utilscfg" "LightgunCollectionFile" "$cfg_collectionfile"
    dialog --title "SAVE" --infobox "Changes Saved" 3 13
  else
    dialog --title "SAVE" --infobox "CANCELLED" 3 13
  fi


}



function set_collectionfile(){
  local title="Set your Lightgun Games Collection file."
  local selection
  local i=0 # define counting variable
  local j=0 # define counting variable
  local firstlist=() # define working array  local line
  firstlist+=($j "I don't have one yet")
  while read -r line; do # process file by file
    let i=$i+1
    if [[ $line == *.cfg ]]; then
      let j=$j+1
      firstlist+=($j "$line"); fi
  done < <( ls -1 "$collectiondir" )
  selection=$(dialog --title "$title" --ok-label " Select " --cancel-label " None " --menu "Select your Lightgun Games collection file from the list of available collections." 20 70 10 "${firstlist[@]}" 3>&2 2>&1 1>&3)
  if [ ! $selection = "0" ]; then
    cfg_collectionfile="${firstlist[((($selection+1)*2)-1)]}"
    dialog --title "$title" --msgbox "\nYou have selected \"${firstlist[((($selection+1)*2)-1)]}\"" 10 70
  else
    dialog --title "$title" --msgbox "\nNo collection has been selected. You will not be able to autostart your guns without a collection, unless you choose to indiscrimintely autostart on \"All Games\"" 10 70
    cfg_collectionfile="NONE"
  fi
}


#########################
#  Options
#########################



function mainmenu(){
  local title
  local selection
  while :; do
  comparetypes
    title="Sinden Autostart Options"
    selection=$(dialog --cancel-label " Exit " --title "$title" --backtitle "$backtitle" --menu \
        "\nApply your settings here" \
        20 70 12 \
        "1"  "Autostart Lightguns        : $(onoffread $cfg_enable)" \
        "2"  "Indiscriminite (all games) : $(onoffread $cfg_allgames)" \
		" "  "                                      " \
		"C"  "Set Lightgun Collection File" \
		" "  "                                      " \
        "S"  "Save Changes" \
        "X"  "Reset unsaved changes" \
        3>&1 1>&2 2>&3 )
          case "$selection" in
            1) cfg_enable=$(onoffwrite $cfg_enable)  ;;
            2) cfg_allgames=$(onoffwrite $cfg_allgames)  ;;
            C) set_collectionfile ;;
            S) savechanges ;;
            X) prep ;;
            " ") ;;
            *) return ;;
          esac
  done
}


#########################
#  Autostop
#########################


function stopguns(){
    sudo pkill -9 -f "mono"
    sudo rm /tmp/LightgunMono* -f
}



#########################
#  Recoil Reset
#########################


function recoilreset(){
## this function is deprecated so, if called, this will now delete the reference that calls it, left behind by a previous version.
    linedelete "sindenautostart.sh" "/opt/retropie/configs/all/autostart.sh"
}


#########################
#  Uninstall
#########################


function linedelete(){
  sed -i "/$1/d" $2
}

function uninstall() {
  local yn
  echo "This command will uninstall Sinden Autostart."
  echo "Are you sure you want to uninstall the official unofficial Sinden Autostart? [y/n]"
  read -N1 yn
  if ! ([ "$yn" = "y" ] || [ "$yn" = "Y" ]); then
    echo " : Cancelling uninstall"
    exit
  fi
  echo " : Proceeding with uninstall!"
  
  applychange "$utilscfg" "AutostartEnable"        "0"
  echo "...Autostart disabled in widgeutils.cfg..."
  linedelete "sindenautostart.sh" "/opt/retropie/configs/all/autostart.sh"  #keep this line in case the reference is still present from a previous version
  linedelete "sindenautostart.sh" "/opt/retropie/configs/all/runcommand-onlaunch.sh"
  linedelete "sindenautostart.sh" "/opt/retropie/configs/all/runcommand-onend.sh"
  echo "...Removed references to sindenautostart from EmulationStation files..."
  /bin/rm -f "/home/pi/Lightgun/utils/sindenautostart.sh"
  echo "...Deleted sindenautostart.sh..."
  bin/rm -f "/home/pi/RetroPie/roms/sinden/Sinden Lightgun Autostart Options.sh"
  bin/rm -f "/home/pi/RetroPie/roms/ports/Sinden Lightgun Autostart Options.sh"
  echo "...Deleted Options Menu from EmulationStation..."
  echo "Uninstall complete."
}

#########################
#  Autostart
#########################


function autostart(){  
  local rc_emu="$2"
  local rc_rom="$3"
  local rc_collection="$collectiondir/$cfg_collectionfile"

if fgrep "$rc_rom" "$rc_collection" || [ $cfg_allgames = "1" ]; then
    if [ "$rc_emu" = "Supermodel" ]; then       
      ## do something for SM3  ## LOST WORLD needs o/s reloading
	  echo " "
    fi
  cd "$monodir"
  sudo mono-service LightgunMono.exe
#  sudo mono-service LightgunMono2.exe
fi
}

#############################
############  START  #######
###########################


prep

while getopts a:rxu flag
  do
    case "${flag}" in
      a) if [ $cfg_enable = "1" ]; then autostart "$2" "$3" "$4" "$5"; fi ;;
      r) recoilreset ;;
      x) if [ $cfg_enable = "1" ]; then stopguns; fi ;;
      u) uninstall ;;
      *) echo "Invalid switch option." ;;
    esac
    exit
  done

/opt/retropie/admin/joy2key/joy2key start
mainmenu
/opt/retropie/admin/joy2key/joy2key stop
clear
