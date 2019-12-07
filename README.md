# tmodloader-docker

Terraria server 1.3.5.3 with tModLoader v0.11.5

## Quick Start

    docker run -it --name terraria -p 7777:7777 j123ss/tmodloader

# Adding worlds

    docker run -it --name terraria -p 7777:7777 -v /path/to/.../terraria:/terraria j123ss/tmodloader

# Config File

You can mount a config file in order to prevent the server requiring input on startup. See [wiki][0] for file format details.

    docker run -it --name terraria -p 7777:7777 -v /path/to/.../terraria:/terraria -v /path/to/.../config.txt:/terraria-server/config.txt j123ss/tmodloader

# More info

How to run and manipulate [a vanilla terraria container][1]. Most of these apply here.
Original walkthrough [on reddit by GhostInThePrompt][2].

[0]: https://terraria.gamepedia.com/Guide:Setting_up_a_Terraria_server#Making_a_configuration_file
[1]: https://store.docker.com/community/images/ryshe/terraria
[2]: https://www.reddit.com/r/Terraria/comments/7dbkfe/how_to_create_a_tmodloadermodded_server_on_linux