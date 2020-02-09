FROM frolvlad/alpine-glibc:alpine-3.10 as build

ARG TMOD_VERSION=0.11.6.2
ARG TERRARIA_VERSION=1353

RUN apk update &&\
    apk add --no-cache --virtual build curl unzip

WORKDIR /terraria-server

RUN curl -SLO "http://terraria.org/server/terraria-server-${TERRARIA_VERSION}.zip" &&\
    unzip terraria-server-*.zip &&\
    rm terraria-server-*.zip &&\
    cp --verbose -a "${TERRARIA_VERSION}/Linux/." . &&\
    rm -rf "${TERRARIA_VERSION}" &&\
    rm TerrariaServer.bin.x86 TerrariaServer.exe

RUN curl -SL "https://github.com/tModLoader/tModLoader/releases/download/v${TMOD_VERSION}/tModLoader.Linux.v${TMOD_VERSION}.tar.gz" | tar -xvz &&\
    chmod u+x tModLoaderServer* Terraria TerrariaServer.* &&\
    mv TerrariaServer.bin.x86_64 tModLoaderServer.bin.x86_64 &&\
    rm *.txt *.jar

FROM frolvlad/alpine-glibc:alpine-3.10

WORKDIR /terraria-server
COPY --from=build /terraria-server ./

RUN apk update &&\
    apk add --no-cache procps tmux
RUN ln -s ${HOME}/.local/share/Terraria/ /terraria
COPY inject.sh /usr/local/bin/inject
COPY handle-idle.sh /usr/local/bin/handle-idle

EXPOSE 7777
ENV TMOD_SHUTDOWN_MSG="Shutting down!"
ENV TMOD_AUTOSAVE_INTERVAL="*/10 * * * *"
ENV TMOD_IDLE_CHECK_INTERVAL=""
ENV TMOD_IDLE_CHECK_OFFSET=0

COPY config.txt entrypoint.sh ./
RUN chmod +x entrypoint.sh /usr/local/bin/inject /usr/local/bin/handle-idle

ENTRYPOINT [ "/terraria-server/entrypoint.sh" ]
