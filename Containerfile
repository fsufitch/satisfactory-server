##########
# Intermediate/base target for setting up a system containing `steamcmd` as an executable
# See the manual setup here: https://developer.valvesoftware.com/wiki/SteamCMD#Linux
FROM docker.io/ubuntu:24.04 AS steamcmd
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        lib32gcc-s1 curl ca-certificates locales

ENV STEAMDIR=/opt/steam
WORKDIR ${STEAMDIR}

RUN curl -L https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar xvvz

# A wrapper 'steamcmd' entrypoint that can be put on PATH
COPY steamcmd-wrapper.sh ${STEAMDIR}/bin/steamcmd
ENV PATH=${STEAMDIR}/bin:${PATH}

# Create a steam user that is sudo-capable
RUN useradd -m steam && \
    chown -R steam:steam ${STEAMDIR}
USER steam

# Test steamcmd
RUN steamcmd +quit

ENTRYPOINT [ "steamcmd" ]
CMD [ "+quit" ]

##########
# Main target with a Satisfactory server
FROM steamcmd AS satisfactory

ENV GAMEDIR=/opt/satisfactory

USER root
WORKDIR ${GAMEDIR}
RUN chown -R steam:steam ${GAMEDIR}
USER steam

RUN steamcmd \
        +force_install_dir ${GAMEDIR} \
        +login anonymous \
        +app_update 1690800 -beta public \
        +quit
