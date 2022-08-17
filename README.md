# Docker container for dedicated tmodloader server.
tModLoader repo : [https://github.com/tModLoader/tModLoader/](https://github.com/tModLoader/tModLoader/)
Hopefully the tmod team will come up with a better implementation that they can maintain.

### Before you run
Currently, you need the following files and directories on your local machine before starting the server :
 * `serverconfig.txt`
 * a folder with all your mod files (`.tmod`) and the `enabled.json` file
 * a folder with all your maps
 * if you want to download mods from the steam workshop, the `install.txt` file
All those files are described [in the tmodloader wiki](https://github.com/tModLoader/tModLoader/wiki/Starting-a-modded-server).

### Build & run with docker-compose
**READ AND EDIT THE `docker-compose.yaml` FILE FIRST**. It contains mount paths for the files and directories mentioned above. Then run :
```
docker-compose up --build
```

### Build & run with docker
Edit the following commands to match the paths on the host :
```
export MODS_DIRECTORY=/path/to/mods/directory
export WORLDS_DIRECTORY=/path/to/worlds/directory
export SERVERCONFIG_PATH=/path/to/serverconfig.txt
export INSTALL_TXT=/path/to/install.txt
docker build -t tmodloader . 
docker run -p 7777:7777 --name tmodloader --rm \
  -v $WORLDS_FOLDER:/root/.local/share/Terraria/tModLoader/Worlds \
  -v $MODS_FOLDER:/root/.local/share/Terraria/tModLoader/Mods \
  -v $SERVERCONFIG_PATH:/root/terraria-server/serverconfig.txt \
  -v $INSTALL_TXT:/root/terraria-server/install.txt \
  tmodloader
```
