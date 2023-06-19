#!/bin/bash
######################################################################################################
##
##  Installer for "Sinden Lightgun Autostart"
##  -- by Widge
##  February 2023
##
######################################################################################################

thisfile=$(echo "$PWD/"`basename "$0"`)

branch="ver2"
repo="https://github.com/Widge-5/Sinden_Lightgun_Autostart/archive/refs/heads/"$branch".zip"
tmpfolder="/home/pi/slgce_install"
destfolder="/home/pi/Lightgun/utils"
sindenfolder="/home/pi/RetroPie/roms"
utilscfg="widgeutils.cfg"
title="Sinden Lightgun Autostart"
automode=false


function rootcheck() {
  #- Script must be run as root
  if [[ $EUID > 0 ]]; then
    colourecho cLRED "ERROR: Script must be run as root: eg: \"sudo $thisfile\""
    exit 0
  else	
    return
  fi
}



function colourecho(){
    _nc="\033[0m"
    case $1 in
      cBLACK )         _col="\033[0;30m";;
      cDGRAY|cDGREY )  _col="\033[1;30m";;
      cRED )           _col="\033[0;31m";;
      cLRED )          _col="\033[1;31m";;
      cGREEN )         _col="\033[0;32m";;
      cLGREEN )        _col="\033[1;32m";;
      cBROWN|cORANGE ) _col="\033[0;33m";;
      cYELLOW )        _col="\033[1;33m";;
      cBLUE )          _col="\033[0;34m";;
      cLBLUE )         _col="\033[1;34m";;
      cPURPLE )        _col="\033[0;35m";;
      cLPURPLE )       _col="\033[1;35m";;
      cCYAN )          _col="\033[0;36m";;
      cLCYAN )         _col="\033[1;36m";;
      cLGRAY|cLGREY )  _col="\033[0;37m";;
      cWHITE )         _col="\033[1;37m";;
      cNUL|* )         _col=$nc;;
    esac
  echo -e "${_col}${2}${_nc}"
}



function downloader() {
  rm -rf $2
  mkdir $2
  cd $2
  echo "Downloading "$1"..."
  wget --timeout 15 --no-http-keep-alive --no-cache --no-cookies $3
  wait
  echo "Extracting "$1"..."
  unzip -q $branch".zip"
}



function tidyup(){
  echo "Cleaning up...."
  cd /home/pi
  rm -rf $1
  echo "Done."
}




function main() {
echo $thisfile
  while true ; do
    colourecho cLCYAN  "In which location are your Sinden start scripts?"
    colourecho cLGREEN "[1] SINDEN"
    colourecho cLGREEN "[2] PORTS"
    colourecho cLGREEN "[Q] quit"
    if [ $automode = true ]; then
		ans=1
	else
		read -N1 ans
	fi
    case "$ans" in
      1)   colourecho cLBLUE " : SINDEN"
           sindenfolder="$sindenfolder/sinden"
           break ;;
      2)   colourecho cLBLUE " : PORTS"
           sindenfolder="$sindenfolder/ports"
           break ;;
      Q|q) colourecho cLRED " : CANCELLING"
           exit;;
    esac
  done
  downloader "Autostart for Sinden Lightgun" "$tmpfolder" "$repo"
  cd "$tmpfolder/Sinden_Lightgun_Autostart-"$branch
  chmod +x *.sh
  if [ ! -d "$destfolder" ]; then
    mkdir "$destfolder"
  fi
  cp -pf "$tmpfolder/Sinden_Lightgun_Autostart-"$branch"/sindenautostart.sh" $destfolder
  cp -pf "$tmpfolder/Sinden_Lightgun_Autostart-"$branch"/Sinden Lightgun Autostart Options.sh" $sindenfolder
  tidyup "$tmpfolder"
  chown -R pi:pi "$destfolder"
  colourecho cLCYAN  "Install completed"
  while true ; do
    colourecho cLCYAN  "Do you want to delete this installer?"
    colourecho cLGREEN "[Y] Yes"
    colourecho cLGREEN "[N] No"
	if [ $automode = true ]; then
		ans="Y"
	else
		read -N1 ans
	fi
    case "$ans" in
      y|Y)  colourecho cLBLUE " : YES"
            /bin/rm -f "$thisfile"
            break ;;
      n|N)  colourecho cLBLUE " : NO"
            break ;;
    esac
  done
  colourecho cLRED "Now restart EmulationStation"
}



####### START #######

rootcheck

if [ "$1" = "--auto" -o "$1" = "-a" ]; then
	automode=true
	echo "Automatic installation requested..."
else
	automode=false
fi

main

