#!/bin/sh

players="$1"

sleep $TMOD_IDLE_CHECK_OFFSET

echo "" > "$players"
inject playing && sleep .2
if ! grep -q "[1-9]" "$players"; then
    inject "exit"
fi