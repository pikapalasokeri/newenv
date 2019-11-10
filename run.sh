sudo apt update
sudo apt -y upgrade
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt -y install git emacs26 htop xclip global meld libavcodec-extra tkcvs python3-pip
pip3 install pandas

echo "Setting up git and github..."
git config --global user.name pikapalasokeri
git config --global user.email noemail
echo "Enter email for github ssh key generation."
read EMAIL
echo "Just press return to use default values in the following steps."
ssh-keygen -t rsa -b 4096 -C ${EMAIL}
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

xclip -sel clip < ~/.ssh/id_rsa.pub
echo "Key is now in clipboard."
echo "Copy it to github.com, then press return to continue."

read DUMMY
echo "Done setting up git."

cd ~

# Clone and set up newenv git path.
mkdir -p src
pushd src
git clone git@github.com:pikapalasokeri/newenv.git
git clone git@github.com:pikapalasokeri/tools.git

NEWENV_DIR=${PWD}/newenv
TOOLS_DIR=${PWD}/tools
popd

# Bashrc and aliases
mv ~/.bashrc ~/.bashrc_bak
ln -s ${NEWENV_DIR}/dot_bashrc ~/.bashrc
ln -s ${NEWENV_DIR}/dot_bash_aliases ~/.bash_aliases

# Bin
mkdir -p ~/bin
ln -s ${TOOLS_DIR}/s.py ~/bin/s.py
ln -s ${TOOLS_DIR}/easyplot.py ~/bin/easyplot.py

# Spacemacs without customizations
mv ~/.emacs.d ~/.emacs.d_bak
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d

# Gtags
${NEWENV_DIR}/setup_gtags.sh ${NEWENV_DIR}
ln -s ${NEWENV_DIR}/cron_create_gtags.sh ~/bin/cron_create_gtags.sh
ln -s ${NEWENV_DIR}/create_gtags.sh ~/bin/create_gtags.sh

# Crontab
cp ${NEWENV_DIR}/crontab_template ${NEWENV_DIR}/crontab
USER=$(whoami)
sed "s/__USER__/${USER}/g" -i ${NEWENV_DIR}/crontab
sudo mv ${NEWENV_DIR}/crontab /etc/crontab

# Keyboard
sudo mv /usr/share/X11/xkb/symbols/altwin /usr/share/X11/xkb/symbols/altwin_bak
sudo mv /usr/share/X11/xkb/symbols/pc /usr/share/X11/xkb/symbols/pc_bak
sudo cp ${NEWENV_DIR}/altwin /usr/share/X11/xkb/symbols/
sudo cp ${NEWENV_DIR}/pc /usr/share/X11/xkb/symbols/


echo "Automated steps done."
echo "Manual steps:"
echo " * Install vimium for Firefox."
echo " * Add repos to cron_create_gtags.sh."
echo " * Copy password database container."
echo " * Customize spacemacs."
echo " * Set alt-tab behavior to something reasonable."

# TODO:
# dotspacemacs customizations
# emacs daemon systemd
# keyboard capslock->ctrl, maybe some info in https://linoxide.com/linux-how-to/configure-keyboard-ubuntu/
# add us keyboard layout, maybe some info in https://linoxide.com/linux-how-to/configure-keyboard-ubuntu/
# dropbox
# keepass
# vimium
