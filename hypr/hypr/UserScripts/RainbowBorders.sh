#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# for rainbow borders animation
#
# function random_hex() {
# 	random_hex=("0xff$(openssl rand -hex 3)")
# 	echo $random_hex
# }
#
# rainbow colors only for active window
#hyprctl keyword general:col.active_border $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) 270deg

#black and white border
hyprctl keyword general:col.active_border "rgb(000000) rgb(000000) rgb(000000) rgb(000000) rgb(000000) rgb(FFFFFF) rgb(FFFFFF) rgb(FFFFFF) rgb(FFFFFF) rgb(FFFFFF) 270deg"

# rainbow colors for inactive window (uncomment to take effect)
#hyprctl keyword general:col.inactive_border $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) $(random_hex) 270deg
