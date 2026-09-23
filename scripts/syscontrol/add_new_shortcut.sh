#!/bin/bash
# Team 3: Adds global GNOME shortcuts

# ─────────────────────────────────────────────────────────────
# WHY two different mechanisms?
#
# GNOME has two types of keybindings:
#
# 1. org.gnome.shell.keybindings
#    - For features that live INSIDE gnome-shell itself
#      (screenshot overlay, overview, activities, etc.)
#    - These are NOT separate processes — they're JS objects
#      running within the gnome-shell process.
#    - You can't "spawn" them; you can only tell the already-
#      running gnome-shell to activate them.
#    - So you just append your key to the existing binding list.
#
# 2. org.gnome.settings-daemon.plugins.media-keys.custom-keybindings
#    - For standalone applications (ptyxis, firefox, etc.)
#    - These are their own processes with their own binary.
#    - You CAN spawn them from a command string.
#    - So you create a custom keybinding entry with a COMMAND.
#
# Rule of thumb: if `which <app>` returns a path, use mechanism 2.
# If it's a feature of the desktop itself, use mechanism 1.
# ─────────────────────────────────────────────────────────────

# ═══════════════════════════════════════════════════════════
# CASE 1: gnome-shell internal feature (screenshot overlay)
# ═══════════════════════════════════════════════════════════

# The screenshot overlay is Main.screenshotUI — a JS object
# living inside the gnome-shell process. There is no binary.
# We simply add our key to the existing show-screenshot-ui binding.

SCREENSHOT_KEY="<Super><Shift>S"

# Get the current list (e.g. ['<Print>'])
CURRENT=$(gsettings get org.gnome.shell.keybindings show-screenshot-ui)

# Append our key if not already present
if [[ "$CURRENT" != *"$SCREENSHOT_KEY"* ]]; then
    NEW_LIST=$(echo "$CURRENT" | sed "s/]/, '$SCREENSHOT_KEY']/" | sed "s/\[, /\[/")
    gsettings set org.gnome.shell.keybindings show-screenshot-ui "$NEW_LIST"
    echo "✓ Screenshot overlay bound to $SCREENSHOT_KEY"
else
    echo "✓ Screenshot overlay already has $SCREENSHOT_KEY"
fi

# ═══════════════════════════════════════════════════════════
# CASE 2: Standalone application (ptyxis terminal)
# ═══════════════════════════════════════════════════════════
# ptyxis is its own process → we use the custom-keybinding
# mechanism which spawns a command.

NAME="Open Terminal"
COMMAND="ptyxis --new-window"
BINDING="<Super><Shift>T"
ID="team3-terminal"
KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/$ID/"

echo "Adding GNOME shortcut: $NAME ($BINDING)..."

CURRENT_LIST=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
if [ "$CURRENT_LIST" = "@as []" ]; then
    NEW_LIST="['$KEY_PATH']"
else
    NEW_LIST=$(echo "$CURRENT_LIST" | sed "s/]/, '$KEY_PATH']/" | sed "s/\[, /\[/")
fi
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NEW_LIST"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEY_PATH" name "$NAME"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEY_PATH" command "$COMMAND"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$KEY_PATH" binding "$BINDING"

echo "✓ Terminal shortcut added: $BINDING"