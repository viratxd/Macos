#Credit: https://github.com/Area69Lab
#setup.sh VNC_USER_PASSWORD VNC_PASSWORD NGROK_AUTH_TOKEN

sudo dscl . -create /Users/lardex
sudo dscl . -create /Users/lardex UserShell /bin/bash
sudo dscl . -create /Users/lardex RealName "LardeX"
sudo dscl . -create /Users/lardex UniqueID 1001
sudo dscl . -create /Users/lardex PrimaryGroupID 80
sudo dscl . -create /Users/lardex NFSHomeDirectory /Users/lardex
sudo dscl . -passwd /Users/lardex $1
sudo dscl . -passwd /Users/lardex $1
sudo createhomedir -c -u lardex > /dev/null

# Download the NoMachine package for macOS
curl -O https://download.nomachine.com/download/8.10/MacOSX/nomachine_8.10.1_1.pkg

# Install the package
sudo installer -pkg nomachine_8.10.1_1.pkg -target / -verboseR

# Start the nxserver service
sudo /Applications/NoMachine.app/Contents/Frameworks/bin/nxserver --start

# Create a user account for nxserver
sudo /Applications/NoMachine.app/Contents/Frameworks/bin/nxserver --useradd lardex --system --password 010206

# Enable the user account for nxserver
sudo /Applications/NoMachine.app/Contents/Frameworks/bin/nxserver --userenable lardex

#install ngrok
brew install --cask ngrok

#configure ngrok and start it
ngrok authtoken $3
ngrok tcp 4001 &




