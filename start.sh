#!/bin/bash
# Author: Xyz (based on https://github.com/RocketMod/Rocket.Unturned/tree/master/Rocket.Unturned/Scripts/Linux by fr34kyn01535).
# Website: https://devdox.net

#CONFIG
INSTANCE_NAME=$2
STEAMCMD_HOME="${HOME}/steamcmd"
UNTURNED_HOME="${HOME}/unturned"
ROCKETMOD_HOME="${HOME}/rocketmod"
SESSION_NAME="unturned-server"
# Check for update when start
AUTO_UPDATE=false
UPDATE_FILE=$UNTURNED_HOME/Modules/Rocket.Unturned/version
# Please fill these field.
# if you leave the password empty steamcmd will ask for you when updating or installing
STEAM_USERNAME=""
STEAM_PASSWORD=""

#COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLLOW='\033[0;33m'
NC='\033[0m'

STEAMCMD_API=$STEAMCMD_HOME/linux32/steamclient.so
UNTURNED_API=$UNTURNED_HOME/Unturned_Data/Plugins/x86/steamclient.so

update_rocket() {
  echo "Cheking for latest version."
  latest_version=$(curl -s https://ci.rocketmod.net/job/Rocket.Unturned/api/xml?xpath=/*/lastStableBuild/number | sed -e 's/<[^>]*>//g')
  old_ver=$(cat $UPDATE_FILE)

  # create a file with latest version which was installed.
  if (( latest_version > old_ver)); then
    echo $latest_version > $UPDATE_FILE
  else
    echo "You're running the latest verson of rocketmod!"
    return
  fi

  # create a folder for rocketmod 
  if [ ! -d "${ROCKETMOD_HOME}" ]; then
    mkdir -p $ROCKETMOD_HOME
  fi

  cd $ROCKETMOD_HOME
  # Download rocketmod
  curl -sO "https://ci.rocketmod.net/job/Rocket.Unturned%20Linux/lastSuccessfulBuild/artifact/Rocket.Unturned/bin/Release/Rocket.zip"
  unzip Rocket.zip
  # Install Modules.
  mv Modules/* $HOME/unturned/Modules/.
  mv RocketLauncher.exe $HOME/unturned/.
  echo "Rocketmod was updated from ${old_ver} to ${latest_version}!"
}

ask() {
  if [[ -z "${STEAM_USERNAME}" ]]; then
    echo "Please Input your username for steam login."
    read input
    if [ -z $input ]; then
      ask
    else
      STEAM_USERNAME=$input
    fi
  fi
}

update_unturned() {
  # if there is no updated steamcmd will quit and do nothing which is very helpful!
  ask
  ./steamcmd.sh +@sSteamCmdForcePlatformBitness 32 +login "$STEAM_USERNAME" "$STEAM_PASSWORD" +force_install_dir $UNTURNED_HOME +app_update 304930 validate +exit
}

start() {
  # if auto update is enabled checks for update
  if $AUTO_UPDATE ; then
    update_unturned
  fi

  if $ROCKET_AUTOUPDATE ; then
    update_rocket
  fi

  echo "Updating steamclient.so"
  if [ -f $STEAMCMD_API ]; then
    if diff $STEAMCMD_API $UNTURNED_API >/dev/null ; then
      printf "${GREEN}UP TO DATE${NC}\n\n"
    else
      cp $STEAMCMD_API $UNTURNED_API
      printf "${YELLLOW}UPDATING${NC}\n\n"
    fi
  else
    printf "${RED}steamclient.so WAS NOT FOUND${NC}\n\n"
  fi

  sleep 1

  cd $UNTURNED_HOME

  if [ ! -f RocketLauncher.exe ]; then
    echo "RocketLauncher not found. Reinstalling RocketMod"
    update_rocket
  else
    tmux new-session -d -n $SESSION_NAME mono RocketLauncher.exe $INSTANCE_NAME
    echo "Started Server"
  fi
}

stop() {
  #screen -r $SESSION_NAME -X shutdown
  tmux send-keys -t $SESSION_NAME "shutdown" C-m
}


install() {
  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' "lib32gcc1" |grep "install ok installed")
  if [ "" == "$PKG_OK" ]; then
    printf "${RED}lib32gcc1 was not found on your computed. Installing it now."
    sudo apt-get --force-yes --yes install lib32gcc1
  else
    printf "${GREEN}lib32gcc1 is installed!!${NC}\n\n"
  fi

  # create a folder to put steamcmd files
  if [ ! -d $STEAMCMD_HOME ]; then
    mkdir -p $HOME/steamcmd
  fi

  cd $STEAMCMD_HOME

  # You dont have steamcmd installed?
  if [ ! -f "steamcmd.sh" ]; then
    echo "Downloading steamcmd"
    curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxf -
  fi

  # Did it install?
  if [ ! -e "$STEAMCMD_HOME/steamcmd.sh" ]
  then
    echo "ERROR: Failed to install steamcmd"
    exit 1
  fi

  # Done installing steamcmd, install the server
  echo "Done installing steamcmd. Installing the game"
  # if you didnt edited the username
  # it will ask you the username everytime and the password :D
  echo "This will take a while"
  update_unturned
}

status() {
  tmux ls | grep [.]$SESSION_NAME[[:space:]] > /dev/null
}

console() {
  tmux a -t $SESSION_NAME
}

case "$1" in
  stop)
    printf "Stopping $SESSION_NAME..."
    stop
    sleep 5
    printf "$SESSION_NAME stopped successfully"
    ;;

  restart)
    printf "Restarting $SESSION_NAME..."
    status && stop
    sleep 5
    start
    sleep 5
    printf "$SESSION_NAME restarted successfully"
    ;;

  status)
    if status
    then printf "$SESSION_NAME is UP"
    else printf "$SESSION_NAME is DOWN"
    fi
    ;;

  console)
    printf "Open console on $SESSION_NAME..."
    console
    ;;

  update)
    printf "Updating $SESSION_NAME..."
    update_unturned
    ;;

  update-rocket)
    printf "Updating $SESSION_NAME..."
    update_rocket
    ;;

  install)
    install
    ;;

  start)
    printf "Starting $SESSION_NAME..."
    start
    ;;

  esac

  exit 0
