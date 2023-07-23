#!/usr/bin/env bash


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
    printf "${Red}[ERROR]: ${White}Error ${BRed}%s ${White}occurred on ${BRed}%s\n" "$1" "$2"
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
    printf "${BRed}[ERROR]: ${White}missing first positional argument to customLogger(): ${Red}%s\n" '$1 is empty'
    resetColors
    exit 1
  fi

  if [ -z "$2" ]; then
    printf "${BRed}[ERROR]: ${White}missing second positional argument to customLogger(): ${Red}%s\n" '$2 is empty'
    resetColors
    exit 1
  fi

  if [ -z "$3" ]; then
    printf "${BYellow}[WARN]: ${White}missing third positional argument to customLogger(): ${Yellow}%s\n" '$3 is empty'
    resetColors
    severityLevelColor="$White"
  else
    severityLevelColor="$3"
  fi

  if [ -z "$4" ]; then
    printf "${BYellow}[WARN]: ${White}missing forth positional argument to customLogger(): ${Yellow}%s\n" '$4 is empty'
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
    printf "${BRed}[ERROR]: ${White}missing first positional argument for logger(): ${Red}%s\n" '$1 is empty'
    resetColors
    exit 1
  fi

  if [ -z "$2" ]; then
    printf "${BRed}[ERROR]: ${White}missing second positional argument to logger(): ${Red}%s\n" '$2 is empty'
    resetColors
    exit 1
  fi

  severityLevel="$1"
  msg="$2"

  case $severityLevel in
    'ERROR'|'3')
      printf "${BRed}[ERROR]: ${White}%s\n" "$msg"
      resetColors
      ;;
    'WARN'|'4')
      printf "${BYellow}[WARN]: ${White}%s\n" "$msg"
      resetColors
      ;;
    'NOTICE'|'5')
      printf "${IGreen}[NOTICE]: ${White}%s\n" "$msg"
      resetColors
      ;;
    'INFO'|'6')
      printf "${BGreen}[INFO]: ${White}%s\n" "$msg"
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
    logger 3 'missing first positional argument to setTempDirectoryName()'
    exit 1
  fi

  tempDirectoryName="$1"
}

function setupTempDirectory() {
  if [ -z "$1" ]; then
    logger 3 'missing first positional argument to setupTmpDirectory()'
    exit 1
  fi

  cd "$HOME/Downloads"
  logger 5 'removing existing temp directory if any'
  if [ -d "$HOME/Downloads/$1" ]; then 
    if  [ ! "${rm -rf $HOME/Downloads/$1}" ]; then
      logger 3 'unable to remove existing temp directory: $HOME/Downloads/$1'
      logger 5 'please remove the directory manually and run the script again!'
      logger 5 'exiting'
      exit 1
    fi
    logger 5 'successfully removed existing temp directory: $HOME/Downloads/$1'
  fi
  logger 5 'Creating new temp directory: $HOME/Downloads/$1'
  if [ ! "${mkdir $HOME/Downloads/$1}" ]; then
    logger 3 'failed creating temporary directory: $HOME/Downloads/$1'
    exit 1
  fi
  return 0
}

function cleanupTempDirectory() {
  if [ -z "$1" ]; then
    logger 3 'missing first positional argument to cleanupTempDirectory()'
    exit 1
  fi

  if [ ! -d "$HOME/Downloads/$1" ]; then
    logger 3 '$HOME/Downloads/$1: No such file or directory'
    logger 5 'exiting... '
    exit 1
  fi
  logger 5 'cleaning up $HOME/Downloads/$1'
  if [ ! "${rm -rf $HOME/Downloads/$1}" ]; then
    logger 3 'failed to remove $HOME/Downloads/$1'
    logger 5 'please try to remove $HOME/Downloads/$1 manually'
    logger 5 'exiting ...'
    exit 1
  fi
  logger 5 'cleanup successfull :)'
  return 0
}

function install() {
  if [ -z "$1" ]; then
    logger 3 'missing first positional argument to install()'
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
    logger 5 '$1 is not a .deb file'
    logger 4 '$1 is not installed!'
    logger 5 'installing $1 ...'
    if [ ! "${sudo apt-get install $1}" ]; then
      logger 3 'failed to installed $1'
      logger 5 'exiting ...'
      exit 1
    fi
    logger 5 'successfully installed $1 :)'
    return 0
  fi

  logger 5 '$1 is a .deb file'
  if [ ! -f "./$1" ]; then
    logger 3 '$1 no such file or directory!'
    logger 5 'exiting ...'
    exit 1
  fi

  logger 5 'Installing $1'
  if [ ! "${sudo apt-get install ./$1}" ]; then
    logger 3 'failed to installed $1'
    logger 5 'exiting ...'
    exit 1
  fi
  logger 5 'successfully installed $1 :)'
  return 0
}

