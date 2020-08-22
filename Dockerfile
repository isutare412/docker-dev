FROM ubuntu:20.04

# Language
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# alias
ARG APT_INSTALL="apt-get install -y --no-install-recommends"

##########################################################################
# Packages
##########################################################################

# Install tools
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive ${APT_INSTALL} \
        sudo \
        git \
        vim \
        tree \
        && \
# Install custom packages
    DEBIAN_FRONTEND=noninteractive ${APT_INSTALL} \
        erlang

##########################################################################
# User settings
##########################################################################

# User arguments
ARG USER
ARG GROUP
ARG PASSWD
ARG UID
ARG GID

# Add an user if given
RUN if [ "${USER:-nouser}" != "nouser" ] && \
        [ "${GROUP:-nogroup}" != "nogroup" ] && \
        [ "${PASSWD:-nopasswd}" != "nopasswd" ]; then \
    groupadd -g ${GID} ${GROUP} && \
    useradd -u ${UID} -g ${GID} -m -s /bin/bash ${USER} && \
    echo "${USER}:${PASSWD}" | chpasswd && \
    usermod -aG sudo ${USER}; \
  fi

# Set prompt color
ENV TERM=xterm-256color

##########################################################################
# Source code
##########################################################################

WORKDIR /workspace
COPY src .
