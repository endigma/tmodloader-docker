FROM steamcmd/steamcmd:ubuntu-20

ARG TMOD_VERSION=2022.07.58.8
ARG TERRARIA_VERSION=1436


	# ports used
EXPOSE 7777

	# system update 
RUN apt -y update 
RUN apt -y install wget unzip libicu-dev
RUN apt -y clean

	# helps terraria find the steamclient shared library
RUN mkdir -p /root/.steam/sdk64
RUN ln -s /root/.steam/steamcmd/linux64/steamclient.so /root/.steam/sdk64/steamclient.so


WORKDIR /root/terraria-server 
	

	# add in tModLoader 
RUN wget https://github.com/tModLoader/tModLoader/releases/download/v${TMOD_VERSION}/tModLoader.zip 
RUN unzip -o tModLoader.zip 
RUN rm tModLoader.zip 
RUN chmod u+x DedicatedServerUtils/Setup_tModLoaderServer.sh
RUN chmod u+x ./start-tModLoaderServer.sh


	# install the latest version of tModLoader from steam
RUN steamcmd +force_install_dir /root/tmod +login anonymous +app_update 1281930 +quit

	# deleting the first line of the Setup_tModLoaderServer.sh script
	# this is because that first line will download the newest version of tModLoader, which we've already installed above.
	# note : it's better to install tModLoader at build time rather than execution time to avoid breaking older versions of the container, as well as speeding up execution. hence this cheap workaround. This might break if the script is heavily modified.
RUN sed -i '1d' DedicatedServerUtils/Setup_tModLoaderServer.sh

	# create Worlds and Mods directories
	# should be auto-created if user mounts their local directories to the container, but perhaps for some reason the user wants ephemeral Mods or Worlds folders ?
RUN mkdir -p /root/.local/share/Terraria/tModLoader/Worlds 
RUN mkdir /root/.local/share/Terraria/tModLoader/Mods

	# execution script
COPY entrypoint.sh .

	

	# start server by running the execution script
ENTRYPOINT ["bash", "-c", "./entrypoint.sh"]
