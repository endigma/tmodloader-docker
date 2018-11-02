# METADATA
FROM debian:testing-slim
LABEL maintainer="jmm@yavook.de"

RUN \
	# system update \
	apt-get -y update &&\
	apt-get -y install wget unzip &&\
	apt-get -y clean &&\
	\
	# prepare directory \
	mkdir /terraria-server &&\
	cd /terraria-server &&\
	\
	# get vanilla server \
	wget http://terraria.org/server/terraria-server-1353.zip &&\
	unzip terraria-server-*.zip &&\
	rm terraria-server-*.zip &&\
	cp --verbose -a 1353/. . &&\
	rm -rf 1353 &&\
	\
	# add in tModLoader \
	cd Linux &&\
	wget https://github.com/blushiemagic/tModLoader/releases/download/v0.10.1.5/tModLoader.Linux.v0.10.1.5.zip &&\
	unzip tModLoader.Linux.v*.zip &&\
	rm tModLoader.Linux.v*.zip &&\
	chmod u+x tModLoaderServer* &&\
	\
	# access data directory \
	ln -s ${HOME}/.local/share/Terraria/ /terraria &&\
	# remove Leftovers \
	cd .. &&\
	rm -rf Windows Mac

# ports used
EXPOSE 7777

# start server
CMD [ "/terraria-server/Linux/tModLoaderServer" ]
