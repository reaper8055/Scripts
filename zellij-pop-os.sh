#!/usr/bin/env bash

source <(curl -sSL "https://raw.githubusercontent.com/reaper8055/scripts/main/helpers/helper.sh")

logger 6 'setting up tmp directory...'
setTempDirectoryName 'zellij-temp'
setupTempDirectory "$tempDirectoryName"
logger 6 'tmp directory setup successful...'

logger 6 'changing to tmp directory'
cd "$HOME/Downloads/$tempDirectoryName"
logger 6 "working from $PWD"
logger 6 'downloading zellij'
pkg=$(wget -nv https://github.com/zellij-org/zellij/releases/download/v0.37.2/zellij-x86_64-unknown-linux-musl.tar.gz 2>&1 | cut -d\" -f2)
[ $? -eq 0 ] && logger 6 'download successful...'

# remove existing install
logger 5 'removing existing installation of zellij'
[ -f "/usr/local/bin/zellij" ] && sudo rm /usr/local/bin/zellij

# unzip and install zellij
logger 6 'unzipping zellij'
tar -xvf "$pkg"
[ $? -eq 0 ] && logger 6 'unzip successful...'
logger 6 'changing permissions for zellij binary'
chmod +x zellij
[ $? -eq 0 ] && logger 6 'successfully changed permission for zellij binary'
logger 6 'copying zellij to /usr/local/bin'
sudo cp zellij /usr/local/bin/
[ $? -eq 0 ] && logger 6 'copying successfull...'
[ -f "/usr/local/bin/zellij" ] && logger 6 'zellij is installed in $(which zellij)'

logger 5 'cleaning up installation...'
cleanupTempDirectory $tempDirectoryName
[ $? -eq 0 ] && logger 6 'clean up successful...'
logger 6 'Bye... :)'
