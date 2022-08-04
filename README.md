Build & run with docker-compose :
`docker-compose up --build`

Build & run with docker :
`docker build -t tmodloader . && docker run -p 7777:7777 --name tmodloader --rm -v /path/to/worlds/folder:/root/.local/share/Terraria/tModLoader/Worlds -v /path/to/mods/folder:/root/.local/share/Terraria/tModLoader/Worlds -v /path/to/serverconfig.txt:/root/terraria-server/serverconfig.txt tmodloader`