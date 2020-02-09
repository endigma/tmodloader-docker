#!/bin/sh

# If no worlds exist, don't bother sending any commands
ls /terraria/ModLoader/Worlds/*.wld >/dev/null || exit

tmux send-keys "$1" Enter
