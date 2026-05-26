#!/bin/bash
id=$(hyprctl activeworkspace -j | jq -r '.id' 2>/dev/null)
if [ -n "$id" ] && [ "$id" != "null" ]; then
    echo "[$id]"
else
    echo "[-]"
fi
