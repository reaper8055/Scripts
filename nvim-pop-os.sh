#!/usr/bin/env bash

source <(curl -sSL "https://raw.githubusercontent.com/reaper8055/scripts/main/helpers/helper.sh")

printf "${White}[INFO]: ${Green}setting up tmp directory...\n"
setTempDirectoryName 'nvim_temp'
setupTempDirectory $tempDirectoryName
[ $? -eq 0 ] && printf "${White}[INFO]: ${Green}setup successful...\n"

# cd into tmp dir
cd $HOME/Downloads/nvim-tmp
[ $? -eq 0 ] && printf "${White}[INFO]: ${Green}Current Working Wirectory: $PWD\n"

printf "${White}[INFO]: ${Green}Downloading neovim stable...\n"
wget -q https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
[ $? -eq 0 ] && printf "${White}[INFO]: ${Green}Download successful...\n"

# remove existing install
printf "${White}[INFO]: ${Yellow}removing existing installation...\n"
[ -d "/opt/nvim-linux64" ] && sudo rm -rf /opt/nvim-linux64
[ -f "/usr/local/bin/nvim" ] && sudo rm /usr/local/bin/nvim

# extrating and installing nvim
printf "${White}[INFO]: ${Yellow}extracting nvim-linux64.tar.gz into /opt/...\n"
sudo tar xzvf nvim-linux64.tar.gz -C /opt/
[ $? -eq 0 ] && printf "${White}[INFO]: ${Yellow}extracting successful...\n"

printf "${White}[INFO]: ${Yellow}creating symlink for the neovim under /usr/local/bin/nvim from /opt/nvim-linux64/\n"
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
[ $? -eq 0 ] && printf "${White}[INFO]: ${Yellow}successfully created symlink for neovim...\n"

# cleanup
printf "${White}[INFO]: ${Yellow}cleaning up...\n"
rm -rf $HOME/Downloads/nvim-tmp
[ $? -eq 0 ] && printf "${White}[INFO]: ${BGreen}cleanup successful, exiting :)\n"
