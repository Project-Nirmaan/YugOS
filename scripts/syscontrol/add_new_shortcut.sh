#!/bin/bash
# Team 3: Adds a global GNOME shortcut to open the Ptyxis terminal

# Define the shortcut properties
NAME="Open Terminal"
COMMAND="ptyxis --new-window"
BINDING="<Ctrl><Shift>t" 
ID="team3-terminal"
KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$ID/"

echo "Adding GNOME shortcut: $NAME ($BINDING)..."

# Safely append to the existing list of shortcuts

#"gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings" returns the current list of custom keybindings in GNOME.
CURRENT_LIST=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
if [ "$CURRENT_LIST" = "@as []" ]; then
    NEW_LIST="['$KEY_PATH']"
else
    # Appends the new path to the end of the existing array
    NEW_LIST=$(echo "$CURRENT_LIST" | sed "s/]/, '$KEY_PATH']/" | sed "s/\[, /\[/")
fi
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NEW_LIST"

# Apply the shortcut settings

#these are the main commands

#how fedora works is that it has a list of custom keybindings, and each keybinding has a path. 
#The path is used to set the name, command, and binding for that specific shortcut.
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEY_PATH" name "$NAME"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEY_PATH" command "$COMMAND"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEY_PATH" binding "$BINDING"

echo "we added a shortcut for $NAME :)"