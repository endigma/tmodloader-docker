#!/usr/bin/env bash
# DedicatedServerUtils/Setup_tModLoaderServer.sh


input="install.txt"
if [ -f "$input" ] ; then
	str="+force_install_dir /root/terraria-server/workshop-mods +login anonymous"
	while read -r line
	do
		str="$str +workshop_download_item 1281930 $line"
	done < "$input"
	str="$str +quit"
	
	steamcmd $str
fi

./start-tModLoaderServer.sh -steamworkshopfolder /root/terraria-server/workshop-mods/steamapps/workshop