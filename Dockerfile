# METADATA
FROM debian:testing-slim
LABEL maintainer="joe.stratton@asu.edu"

ARG TMOD_VERSION=0.11.5
ARG TERRARIA_VERSION=1353

# system update
RUN apt-get -y update &&\
    apt-get -y install wget unzip &&\
    apt-get -y clean

WORKDIR /terraria-server

# get vanilla server
RUN wget "http://terraria.org/server/terraria-server-${TERRARIA_VERSION}.zip" &&\
    unzip terraria-server-*.zip &&\
    rm terraria-server-*.zip &&\
    cp --verbose -a "${TERRARIA_VERSION}/Linux/." . &&\
    rm -rf "${TERRARIA_VERSION}"

# add in tModLoader
RUN  wget -qO - "https://github.com/tModLoader/tModLoader/releases/download/v${TMOD_VERSION}/tModLoader.Linux.v${TMOD_VERSION}.tar.gz" | tar -xvz &&\
    chmod u+x tModLoaderServer* Terraria TerrariaServer.*

# access data directory
RUN ln -s ${HOME}/.local/share/Terraria/ /terraria

# ports used
EXPOSE 7777

# start server
CMD [ "/terraria-server/tModLoaderServer" ]
