#!/usr/bin/env bash

source <(curl -sSL "https://raw.githubusercontent.com/reaper8055/scripts/main/helpers/helper.sh")

function installPkgs() {
  # Google Chrome
  setTempDirectoryName 'temp_pkgs'
  setupTempDirectory "$tempDirectoryName"
  cd "$HOME/Downloads/$tempDirectoryName"
  [ ! -f "$(which wget)" ] && install 'wget'
  logger 5 'Downloading google-chrome-stable ...'
  pkg=$(wget -nv https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb  2>&1 | cut -d\" -f2)
  if [ "$?" -nq 0 ]; then 
    logger 3 'failed to download google-chrome-stable'
    logger 5 'exiting...'
    exit 1
  fi
  logger 5 'Download successfull ... :)'
  logger 5 'Installing...'
  install "$pkg"

  # Brave Browser
  sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
  sudo apt update
  sudo apt install brave-browser
}
