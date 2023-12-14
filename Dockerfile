FROM ubuntu:jammy

USER root

ENV GODOT_VERSION="4.2"
ENV RELEASE_NAME="stable"
ENV GODOT_PLATFORM="linux.x86_64"

RUN mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && mkdir -p ~/.local/share/godot/templates/${GODOT_VERSION}.${RELEASE_NAME} \
    && mkdir -p /opt/butler/bin
    
# UPDATING IMAGE
RUN apt-get -qq update && apt-get -qq install -y --no-install-recommends \
    ca-certificates \
    libfontconfig \
    git \
    git-lfs \
    unzip \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

# GETTING GODOT DEPENDENCIES
RUN wget -q https://github.com/godotengine/godot/releases/download/4.2-stable/Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip \
    && unzip -q Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM}.zip \
    && mv Godot_v${GODOT_VERSION}-${RELEASE_NAME}_${GODOT_PLATFORM} /usr/local/bin/godot
    
# GETTING BUTLER
RUN cd /opt/butler/bin \
    && wget -q -O butler.zip https://broth.itch.ovh/butler/linux-amd64/LATEST/archive/default \
    && unzip -q butler.zip \
    && chmod +x butler

WORKDIR /game

COPY . .
RUN chmod +x entrypoint.sh

ENTRYPOINT /bin/bash entrypoint.sh
