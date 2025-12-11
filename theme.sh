#!/bin/sh

DARK="false"
current=$(osascript -e 'tell application "System Events" to tell appearance preferences to get dark mode')
if [ "$current" = "false" ]; then
    DARK="true"
fi
osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to $DARK"

TERM_DIR="$HOME/.config/alacritty"
TERM_FILE="$TERM_DIR/alacritty.toml"
ACTIVE_THEME="$TERM_DIR/theme.toml"
INACTIVE_THEME="$TERM_DIR/alt.toml"
TEMP_FILE="$TERM_DIR/alt.toml.temp"

if [ -f "$ACTIVE_THEME" ] && [ -f "$INACTIVE_THEME" ]; then
    mv "$ACTIVE_THEME" "$TEMP_FILE"
    mv "$INACTIVE_THEME" "$ACTIVE_THEME"
    mv "$TEMP_FILE" "$INACTIVE_THEME"
    touch "$TERM_FILE"
fi
