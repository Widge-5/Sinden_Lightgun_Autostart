#!/bin/bash

######################################################################
##
##   Autostart Options for Sinden Lightgun
##   v1.02    January 2023
##   -- By Widge
##
##   For use with Sinden v1.8 config files
##
######################################################################



###########################
############  GLOBAL ######
###########################

backtitle="Autostart Options for Sinden Lightgun v1.01 -- By Widge"
utilscfg="/home/pi/Lightgun/utils/widgeutils.cfg"
collectiondir="/opt/retropie/configs/all/emulationstation/collections"


function builder() { if ! grep -Fq "$1" "$3" ; then echo "$1=\"$2\"" >> $3 ; fi ; }


function cfgmaker() {
  if [ ! -f "$utilscfg" ]; then
    echo > $utilscfg
  fi
  if  ! grep -Fq "[ CONFIG LOCATIONS ]" "$utilscfg" ; then
    echo >> $utilscfg
    echo "[ CONFIG LOCATIONS ] S1 & S2 are Supermodel-specific configs." >> $utilscfg
    echo >> $utilscfg
  fi
  builder "<P1normal>" "/home/pi/Lightgun/Player1/LightgunMono.exe.config" "$utilscfg"
  builder "<P1recoil>" "/home/pi/Lightgun/Player1recoil/LightgunMono.exe.config" "$utilscfg"
  builder "<P1auto>" "/home/pi/Lightgun/Player1recoilauto/LightgunMono.exe.config" "$utilscfg"
  builder "<P2normal>" "/home/pi/Lightgun/Player2/LightgunMono2.exe.config" "$utilscfg"
  builder "<P2recoil>" "/home/pi/Lightgun/Player2recoil/LightgunMono2.exe.config" "$utilscfg"
  builder "<P2auto>" "/home/pi/Lightgun/Player2recoilauto/LightgunMono2.exe.config" "$utilscfg"
  builder "<P3normal>" "/home/pi/Lightgun/Player3/LightgunMono3.exe.config" "$utilscfg"
  builder "<P3recoil>" "/home/pi/Lightgun/Player3recoil/LightgunMono3.exe.config" "$utilscfg"
  builder "<P3auto>" "/home/pi/Lightgun/Player3recoilauto/LightgunMono3.exe.config" "$utilscfg"
  builder "<P4normal>" "/home/pi/Lightgun/Player4recoil/LightgunMono4.exe.config" "$utilscfg"
  builder "<P4recoil>" "/home/pi/Lightgun/Player4recoil/LightgunMono4.exe.config" "$utilscfg"
  builder "<P4auto>" "/home/pi/Lightgun/Player4recoilauto/LightgunMono4.exe.config" "$utilscfg"
  builder "<S1normal>" "/home/pi/Lightgun/SM3_Player1/LightgunMono.exe.config" "$utilscfg"
  builder "<S1recoil>" "/home/pi/Lightgun/SM3_Player1recoil/LightgunMono.exe.config" "$utilscfg"
  builder "<S2normal>" "/home/pi/Lightgun/SM3_Player2/LightgunMono2.exe.config" "$utilscfg"
  builder "<S2recoil>" "/home/pi/Lightgun/SM3_Player2recoil/LightgunMono2.exe.config" "$utilscfg"
  builder "<S1auto>" "/home/pi/Lightgun/SM3_Player1recoilauto/LightgunMono.exe.config" "$utilscfg"
  if  ! grep -Fq "[ AUTOSTART SETTINGS ]" "$utilscfg" ; then
    echo >> $utilscfg
    echo "[ AUTOSTART SETTINGS ]" >> $utilscfg
    echo >> $utilscfg
  fi
  builder "<AutostartEnable>" "0" "$utilscfg"
  builder "<RecoilTypeP1>" "off" "$utilscfg"
  builder "<RecoilTypeP2>" "off" "$utilscfg"
  builder "<RecoilTypeP3>" "off" "$utilscfg"
  builder "<RecoilTypeP4>" "off" "$utilscfg"
  builder "<RecoilReset>" "0" "$utilscfg"
  builder "<LightgunCollectionFile>" "NONE" "$utilscfg"

  if ! grep -Fq "sindenautostart.sh" "/opt/retropie/configs/all/autostart.sh" ; then
    sed -i -e "1s/^/\/home\/pi\/Lightgun\/utils\/sindenautostart.sh -r\n/" "/opt/retropie/configs/all/autostart.sh"
  fi
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
  cfg_P1_norm=$(grabber "<P1normal>" "$utilscfg")
  cfg_P1_reco=$(grabber "<P1recoil>" "$utilscfg")
  cfg_P1_auto=$(grabber "<P1auto>" "$utilscfg")
  cfg_P2_norm=$(grabber "<P2normal>" "$utilscfg")
  cfg_P2_reco=$(grabber "<P2recoil>" "$utilscfg")
  cfg_P2_auto=$(grabber "<P2auto>" "$utilscfg")
  cfg_P3_norm=$(grabber "<P3normal>" "$utilscfg")
  cfg_P3_reco=$(grabber "<P3recoil>" "$utilscfg")
  cfg_P3_auto=$(grabber "<P3auto>" "$utilscfg")
  cfg_P4_norm=$(grabber "<P4normal>" "$utilscfg")
  cfg_P4_reco=$(grabber "<P4recoil>" "$utilscfg")
  cfg_P4_auto=$(grabber "<P4auto>" "$utilscfg")
  cfg_S1_norm=$(grabber "<S1normal>" "$utilscfg")
  cfg_S1_reco=$(grabber "<S1recoil>" "$utilscfg")
  cfg_S1_auto=$(grabber "<S1auto>" "$utilscfg")
  cfg_S2_norm=$(grabber "<S2normal>" "$utilscfg")
  cfg_S2_reco=$(grabber "<S2recoil>" "$utilscfg")
  cfg_S2_auto=$(grabber "<S2auto>" "$utilscfg")

  cfg_enable=$(grabber "<AutostartEnable>" "$utilscfg")
  cfg_recoiltypeP1=$(grabber "<RecoilTypeP1>" "$utilscfg")
  cfg_recoiltypeP2=$(grabber "<RecoilTypeP2>" "$utilscfg")
  cfg_recoiltypeP3=$(grabber "<RecoilTypeP3>" "$utilscfg")
  cfg_recoiltypeP4=$(grabber "<RecoilTypeP4>" "$utilscfg")
  cfg_recoilreset=$(grabber "<RecoilReset>" "$utilscfg")
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


  local duration=10
  local count=$duration+1
  local percent
  local yn
  (( ++count )) 
  ( while :; do
      cat <<-EOF      # The "-" here allows EOF later to be indented with TAB
        $percent
	EOF
      (( count-=1 ))  # This can only be indented with TAB
      percent=$((100/$duration*($duration+1-$count)))
      [ $count -eq 0 ] && break
      sleep 0.1
    done ) |
    dialog --title "Saving..." --gauge "$4" 5 30 $percent

    applychange "$utilscfg" "AutostartEnable"        $cfg_enable           
    applychange "$utilscfg" "RecoilTypeP1"           $cfg_recoiltypeP1     
    applychange "$utilscfg" "RecoilTypeP2"           $cfg_recoiltypeP2     
    applychange "$utilscfg" "RecoilTypeP3"           $cfg_recoiltypeP3     
    applychange "$utilscfg" "RecoilTypeP4"           $cfg_recoiltypeP4     
    applychange "$utilscfg" "RecoilReset"            $cfg_recoilreset
    applychange "$utilscfg" "LightgunCollectionFile" "$cfg_collectionfile"

  else
    dialog --title "SAVE" --infobox "CANCELLED" 3 13
  fi


}



function comparetypes(){
  if [ "$cfg_recoiltypeP1" = "$cfg_recoiltypeP2" ] && [ "$cfg_recoiltypeP2" = "$cfg_recoiltypeP3" ] && [ "$cfg_recoiltypeP3" = "$cfg_recoiltypeP4" ]; then
    grecoil="all "$cfg_recoiltypeP1
  else
    grecoil="individual"
  fi
}



function set_recoil(){
  local var
  var="cfg_recoiltype"$1
  case "${!var}" in
    off)    export "$var=single" ;;
    single) export "$var=auto"   ;;
    auto)   export "$var=off"    ;;
    *)      export "$var=off"    ;;
  esac
}



function set_global(){
  case "$grecoil" in
    "inividual"|"all off")
        cfg_recoiltypeP1="single"
        cfg_recoiltypeP2="single"
        cfg_recoiltypeP3="single"
        cfg_recoiltypeP4="single"
        ;;
    "all single")
        cfg_recoiltypeP1="auto"
        cfg_recoiltypeP2="auto"
        cfg_recoiltypeP3="auto"
        cfg_recoiltypeP4="auto"
        ;;
    "all auto"|*)
        cfg_recoiltypeP1="off"
        cfg_recoiltypeP2="off"
        cfg_recoiltypeP3="off"
        cfg_recoiltypeP4="off"
        ;;
  esac
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
    dialog --title "$title" --msgbox "\nNo collection has been selected. You will not be able to autostart your guns without a collection." 10 70
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
        "A"  "Autostart Lightguns       : $(onoffread $cfg_enable)" \
        "G"  "Set Global Recoil         : $grecoil" \
        "1"  "P1 Recoil                 : $cfg_recoiltypeP1" \
        "2"  "P2 Recoil                 : $cfg_recoiltypeP2" \
        "3"  "P3 Recoil                 : $cfg_recoiltypeP3" \
        "4"  "P4 Recoil                 : $cfg_recoiltypeP4" \
	"R"  "Reset recoil on each boot : $(onoffread $cfg_recoilreset)" \
	" "  "                                      " \
	"C"  "Set Lightgun Collection File" \
	" "  "                                      " \
        "S"  "Save Changes" \
        "X"  "Reset unsaved changes" \
        3>&1 1>&2 2>&3 )
          case "$selection" in
            A) cfg_enable=$(onoffwrite $cfg_enable)  ;;
            G) set_global ;;
            1) set_recoil "P1";;
            2) set_recoil "P2";;
            3) set_recoil "P3";;
            4) set_recoil "P4";;
            R) cfg_recoilreset=$(onoffwrite $cfg_recoilreset)  ;;
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
  if [ $cfg_recoilreset = 1 ]; then
    echo "reset the recoil"
    applychange "$utilscfg" "RecoilTypeP1" "off"
    applychange "$utilscfg" "RecoilTypeP2" "off"
    applychange "$utilscfg" "RecoilTypeP3" "off"
    applychange "$utilscfg" "RecoilTypeP4" "off"
  else
    echo "don't reset"
  fi

}


#########################
#  Uninstall
#########################


function linedelete(){
  sed -i "/$1/d" $2
}

function uninstall() {
  local yn
  echo "This command will uninstall Sinded Autostart."
  echo "Are you sure you want to uninstall the official unofficial Sinden Autostart? [y/n]"
  read -N1 yn
  if ! ([ "$yn" = "y" ] || [ "$yn" = "Y" ]); then
    echo " : Cancelling uninstall"
    exit
  fi
  echo " : Proceeding with uninstall!"
  
  applychange "$utilscfg" "AutostartEnable"        "0"
  echo "...Autostart disabled in widgeutils.cfg..."
  linedelete "sindenautostart.sh" "/opt/retropie/configs/all/autostart.sh"
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
  local player1
  local player2
  local player3
  local player4

  if fgrep -q "$rc_rom" "$rc_collection"; then
    if [ "$rc_emu" = "Supermodel" ]; then       
      player1="cfg_S1_"
      player2="cfg_S2_"
      player3="cfg_S3_"
      player4="cfg_S4_"
    else
      player1="cfg_P1_"
      player2="cfg_P2_"
      player3="cfg_P3_"
      player4="cfg_P4_"
    fi
    case "$cfg_recoiltypeP1" in
      single) player1=$player1"reco" ;;
      auto)   player1=$player1"auto" ;;
      *)      player1=$player1"norm" ;;
    esac
    case "$cfg_recoiltypeP2" in
      single) player2=$player2"reco" ;;
      auto)   player2=$player2"auto" ;;
      *)      player2=$player2"norm" ;;
    esac
    case "$cfg_recoiltypeP3" in
      single) player3=$player3"reco" ;;
      auto)   player3=$player3"auto" ;;
      *)      player3=$player3"norm" ;;
    esac
    case "$cfg_recoiltypeP4" in
      single) player4=$player4"reco" ;;
      auto)   player4=$player4"auto" ;;
      *)      player4=$player4"norm" ;;
    esac

  cd "${!player1%/*}"
  sudo mono-service "${!player1%.config}"
  cd "${!player2%/*}"
  sudo mono-service "${!player2%.config}"
  cd "${!player3%/*}"
  sudo mono-service "${!player3%.config}"
  cd "${!player4%/*}"
  sudo mono-service "${!player4%.config}"
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
