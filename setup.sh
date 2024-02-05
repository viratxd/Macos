#Credit: https://github.com/Area69Lab
#setup.sh VNC_USER_PASSWORD VNC_PASSWORD NGROK_AUTH_TOKEN

# create your user
sudo dscl . -create /Users/$1
sudo dscl . -create /Users/$1 UserShell /bin/bash
sudo dscl . -create /Users/$1 RealName $2
sudo dscl . -create /Users/$1 UniqueID 1001
sudo dscl . -create /Users/$1 PrimaryGroupID 80
sudo dscl . -create /Users/$1 NFSHomeDirectory /Users/$1
sudo dscl . -passwd /Users/$1 $3
sudo dscl . -passwd /Users/$1 $3
sudo createhomedir -c -u $1 > /dev/null

# Enable the built-in VNC server 
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy no
echo $4 | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' |
sudo tee /Library/Preferences/com.apple.VNCSettings.txt
sudo -u root defaults write /Library/LaunchDaemons/com.startup.sysctl Label com.startup.sysctl
sudo -u root defaults write /Library/LaunchDaemons/com.startup.sysctl LaunchOnlyOnce -bool true
sudo -u root defaults write /Library/LaunchDaemons/com.startup.sysctl ProgramArguments -array /usr/sbin/sysctl net.inet.tcp.delayed_ack=0
sudo -u root defaults write /Library/LaunchDaemons/com.startup.sysctl RunAtLoad -bool true
sudo chmod 644 /Library/LaunchDaemons/com.startup.sysctl.plist
sudo chown root:wheel /Library/LaunchDaemons/com.startup.sysctl.plist
sudo launchctl load /Library/LaunchDaemons/com.startup.sysctl.plist

# Install ngrok using Homebrew
brew install ngrok

# Start ngrok tunnel
ngrok authtoken $5
ngrok tcp 5900 &

sudo chmod 777 /Users/$1/Desktop

# Set the username
username=$1

# Download the file from Google Drive
file_id="1saqhkHbhDcz4uF66asQVu6rYsYsvPCne"
destination="/Users/$1/Desktop/TeamViewer.zip"
wget --no-check-certificate 'https://docs.google.com/uc?export=download&id='$file_id -O $destination

# Unzip the file
unzip $destination -d /Users/$1/Desktop/
mv /Users/$1/Desktop/TeamViewer /Users/$1/Desktop/TeamViewer.app

# Open the app
open /Users/$1/Desktop/TeamViewer.app

# Set the screensaver idle time to 0
sudo defaults write /Library/Preferences/com.apple.screensaver loginWindowIdleTime 0

