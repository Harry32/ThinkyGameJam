FROM ubuntu:jammy

USER root

ARG GODOT_VERSION="4.2"
ARG RELEASE_NAME="stable"
ARG GODOT_PLATFORM="linux.x86_64"

RUN mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && mkdir -p ~/.local/share/godot/templates/${GODOT_VERSION}.${RELEASE_NAME} \
    && mkdir /game \
    && mkdir /build \   
    && mkdir -p /opt/butler/bin

# UPDATING IMAGE
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libfontconfig \
    git git-lfs \
    zip unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

# GETTING GODOT DEPENDENCIES
RUN wget https://github.com/godotengine/godot/releases/download/4.2-stable/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip \
    && wget https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}-${RELEASE_NAME}/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz \
    && ln -s ~/.local/share/godot/templates ~/.local/share/godot/export_templates \
    && unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip \
    && mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM} /usr/local/bin/godot \
    && unzip Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz \
    && mv templates/* ~/.local/share/godot/templates/${GODOT_VERSION}.${RELEASE_NAME} \
    && rm -f Godot_v${GODOT_VERSION}-${RELEASE_NAME}_export_templates.tpz Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip

# GETTING BUTLER
RUN cd /opt/butler/bin \
    && wget -O butler.zip https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default \
    && unzip butler.zip \
    && chmod +x butler \
    && rm butler.zip

WORKDIR /game

COPY . .
RUN chmod +x entrypoint.sh

ENTRYPOINT /bin/bash entrypoint.sh
