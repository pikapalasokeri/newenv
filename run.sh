sudo apt update
sudo apt -y upgrade
sudo apt -y install git emacs25 htop xclip

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
popd

# Bashrc and aliases
mv ~/.bashrc ~/.bashrc_bak
ln -s ${NEWENV_DIR}/dot_bashrc ~/.bashrc
ln -s ${NEWENV_DIR}/dot_bash_aliases ~/.bash_aliases

