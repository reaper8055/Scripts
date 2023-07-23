#!/usr/bin/env bash
##################################################################################################
#
#    ▄█    █▄       ▄████████  ▄█          ▄███████▄    ▄████████    ▄████████ 
#   ███    ███     ███    ███ ███         ███    ███   ███    ███   ███    ███ 
#   ███    ███     ███    █▀  ███         ███    ███   ███    █▀    ███    ███ 
#  ▄███▄▄▄▄███▄▄  ▄███▄▄▄     ███         ███    ███  ▄███▄▄▄      ▄███▄▄▄▄██▀ 
# ▀▀███▀▀▀▀███▀  ▀▀███▀▀▀     ███       ▀█████████▀  ▀▀███▀▀▀     ▀▀███▀▀▀▀▀   
#   ███    ███     ███    █▄  ███         ███          ███    █▄  ▀███████████ 
#   ███    ███     ███    ███ ███▌    ▄   ███          ███    ███   ███    ███ 
#   ███    █▀      ██████████ █████▄▄██  ▄████▀        ██████████   ███    ███ 
#
# Usage:
# source <(curl -sSL "https://raw.githubusercontent.com/reaper8055/scripts/main/helpers/helper.sh")
##################################################################################################

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

# e - script stops on error (return != 0)
# u - error if undefined variable is used somewhere
# o pipefail - script fails if one of the piped command fails. 
#   - HINT: echo "hello, World!" | grep | sort
# x - output each line (add to set for debug)
# set -euo pipefail # ideally you would want to use this.
set -eo pipefail
trap 'catch $? $LINENO' EXIT

function resetColors() {
  tput sgr0
}

function catch() {
  if [ "$1" != "0" ]
  then
    printf "${Red}[ERROR]: ${White}Error ${Red}%s ${White}occurred on ${Red}%s\n" "$1" "$2"
    resetColors
  fi
}

# customLogger() takes two argement to run successfully. The 3rd and 4th
# argument to the function are optional i.e when none provided they default to
# ${White} for the severityLevelColor and ${BWhite} for the msgColor.
#
# $1:severityLevel
# First argument to the function i.e $1 can be any one of the following:
#   0 EMERGENCY
#   1 ALERT
#   2 CRITICAL
#   3 ERROR
#   4 WARN
#   5 NOTICE
#   6 INFO
#   7 DEBUG
# NOTE: Failing to specificy any of the above will call customLogger() function.
# 
# $2:msg
# Second argument to the function i.e $2 is the message you want to print to
# stdout. It can be any string and it **should not** end with a new line
# characther "\n".
#
# $3:severityLevelColor, $4:msgColor can be any of the above colors variable in
# line 3 to 74.
function customLogger() {
  if [ -z "$1" ]; then
    printf "${Red}[ERROR]: ${White}missing first positional argument to customLogger(): ${Red}%s\n" '$1 is empty'
    resetColors
    exit 1
  fi

  if [ -z "$2" ]; then
    printf "${Red}[ERROR]: ${White}missing second positional argument to customLogger(): ${Red}%s\n" '$2 is empty'
    resetColors
    exit 1
  fi

  if [ -z "$3" ]; then
    printf "${Yellow}[WARN]: ${White}missing third positional argument to customLogger(): ${Yellow}%s\n" '$3 is empty'
    resetColors
    severityLevelColor="$White"
  else
    severityLevelColor="$3"
  fi

  if [ -z "$4" ]; then
    printf "${Yellow}[WARN]: ${White}missing forth positional argument to customLogger(): ${Yellow}%s\n" '$4 is empty'
    resetColors
    msgColor="$BWhite"
  else
    msgColor="$4"
  fi

  severityLevel="$1"
  msg="$2"

  printf "${severityLevelColor}[%s]: ${msgColor}%s\n" "$severityLevel" "$msg"
  resetColors
}

# logger() takes two argement to run successfully.
#
# $1:severityLevel
# First argument to the function i.e $1 can be any one of the following:
#   0 EMERGENCY
#   1 ALERT
#   2 CRITICAL
#   3 ERROR
#   4 WARN
#   5 NOTICE
#   6 INFO
#   7 DEBUG
# NOTE: Failing to specificy any of the above will call customLogger() function.
# 
# $2:msg
# Second argument to the function i.e $2 is the message you want to print to
# stdout. It can be any string and it **should not** end with a new line
# characther "\n".
# usage:
#     logger 4 'successfull something'
function logger() {
  # fail if positional argument either $1 or $2 are not provided.
  if [ -z "$1" ]; then
    printf "${Red}[ERROR]: ${White}missing first positional argument for logger(): ${Red}%s\n" '$1 is empty'
    resetColors
    exit 1
  fi

  if [ -z "$2" ]; then
    printf "${Red}[ERROR]: ${White}missing second positional argument to logger(): ${Red}%s\n" '$2 is empty'
    resetColors
    exit 1
  fi

  severityLevel="$1"
  msg="$2"

  case $severityLevel in
    'ERROR'|'3')
      printf "${Red}[ERROR]: ${White}%s\n" "$msg"
      resetColors
      ;;
    'WARN'|'4')
      printf "${Yellow}[WARN]: ${White}%s\n" "$msg"
      resetColors
      ;;
    'NOTICE'|'5')
      printf "${IGreen}[NOTICE]: ${White}%s\n" "$msg"
      resetColors
      ;;
    'INFO'|'6')
      printf "${Green}[INFO]: ${White}%s\n" "$msg"
      resetColors
      ;;
    'DEBUG'|'7')
      printf "${Blue}[DEBUG]: ${White}%s\n" "$msg"
      resetColors
      ;;
    *)
      customLogger "$1" "$2" "$3" "$4"
      resetColors
      ;;
  esac
}

# To use setup_tmp_directory and cleanup_tmp_directory, set your tmp directory
# name by replacng the value after equal(=) sign below:

tempDirectoryName='my_temp_directory'

function setTempDirectoryName(){
  if [ -z "$1" ]; then
    logger 3 "missing first positional argument to setTempDirectoryName()"
    exit 1
  fi

  tempDirectoryName="$1"
}

function setupTempDirectory() {
  if [ -z "$1" ]; then
    logger 3 "missing first positional argument to setupTempDirectory()"
    exit 1
  fi

  cd "$HOME/Downloads"
  logger 5 "removing existing temp directory if any"
  if [ -d "$HOME/Downloads/$1" ]; then 
    if  [ ! "${rm -rf $HOME/Downloads/$1}" ]; then
      logger 3 "unable to remove existing temp directory: $HOME/Downloads/$1"
      logger 5 "please remove the directory manually and run the script again!"
      logger 5 "exiting ..."
      exit 1
    fi
    logger 5 "successfully removed existing temp directory: $HOME/Downloads/$1"
  fi
  logger 5 "Creating new temp directory: $HOME/Downloads/$1"
  mkdir "$HOME/Downloads/$1"
  if [ "$?" -ne 0 ]; then
    logger 3 "failed creating temporary directory: $HOME/Downloads/$1"
    exit 1
  fi
  return 0
}

function cleanupTempDirectory() {
  if [ -z "$1" ]; then
    logger 3 "missing first positional argument to cleanupTempDirectory()"
    exit 1
  fi

  if [ ! -d "$HOME/Downloads/$1" ]; then
    logger 3 "$HOME/Downloads/$1: No such file or directory"
    logger 5 "exiting... "
    exit 1
  fi
  logger 5 "cleaning up $HOME/Downloads/$1"
  rm -rf "$HOME/Downloads/$1"
  if [ "$?" -ne 0 ]; then
    logger 3 "failed to remove $HOME/Downloads/$1"
    logger 5 "please try to remove $HOME/Downloads/$1 manually"
    logger 5 "exiting ..."
    exit 1
  fi
  logger 5 "cleanup successfull :)"
  return 0
}

function install() {
  if [ -z "$1" ]; then
    logger 3 "missing first positional argument to install()"
    exit 1
  fi

  pkg="$(basename -- $1)"
  pkgExtension="${pkg##*.}"
  pkgName="${pkg%.*}"
  isDotDebFile=false

  if [ "$pkg" -eq "$pkgExtension" ] && [ "$pkg" -eq "$pkgName" ]; then
    isDotDebFile=true
  fi

  if [ ! "$isDotDebFile" ]; then
    logger 5 "$1 is not a .deb file"
    logger 4 "$1 is not installed!"
    logger 5 "installing $1 ..."
    sudo apt-get install "$1"
    if [ "$?" -ne 0 ]; then
      logger 3 "failed to installed $1"
      logger 5 "exiting ..."
      exit 1
    fi
    logger 5 "successfully installed $1 :)"
    return 0
  fi

  logger 5 "$1 is a .deb file"
  if [ ! -f "./$1" ]; then
    logger 3 "$1 no such file or directory!"
    logger 5 "exiting ..."
    exit 1
  fi

  logger 5 "Installing $1"
  sudo apt-get install "./$1"
  if [ "$?" -ne 0 ]; then
    logger 3 "failed to installed $1"
    logger 5 "exiting ..."
    exit 1
  fi
  logger 5 "successfully installed $1 :)"
  return 0
}

