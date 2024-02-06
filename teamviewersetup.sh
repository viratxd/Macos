# Set the username
username=$1

# Set the download URL for TeamViewer
url="https://download.teamviewer.com/download/TeamViewerHost.dmg"

# Set the destination path
dest="/Users/$username/Desktop"

# Download TeamViewer
echo "Downloading TeamViewer..."
sudo curl -L $url -o $dest/TeamViewer.dmg

# Mount the dmg file
echo "Mounting the dmg file..."
mount_output=$(sudo hdiutil attach $dest/TeamViewer.dmg)

# Get the mount point
mount_point=$(echo $mount_output | grep -o '/Volumes/.*' | awk '{print $1}')

# Get the name of the app
app_name=$(ls $mount_point | grep '.app')

# Move the TeamViewer app to the Desktop
echo "Moving TeamViewer to the Desktop..."
sudo cp -R "$mount_point/$app_name" $dest/

# Unmount the dmg file
echo "Unmounting the dmg file..."
sudo hdiutil detach $mount_point

echo "TeamViewer has been successfully installed on the Desktop."

# Check if TeamViewerHost.app exists in the Applications folder
while true; do
    if [[ -d "/Applications/TeamViewerHost.app" ]]; then
        sudo mv "/Applications/TeamViewerHost.app" "/Users/$1/Desktop/"
        break
    else
        sleep 5
    fi
done
