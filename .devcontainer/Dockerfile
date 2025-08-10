# can't use alpine since HLS doesn't have binaries for alpine :(((
FROM mcr.microsoft.com/devcontainers/base:debian-12 AS base

ENV LANG=C.UTF-8

ARG STACK_VERSION
ARG HLS_VERSION

ENV DEBIAN_FRONTEND=noninteractive \
    USERNAME=vscode \
    STACK_VERSION=${STACK_VERSION} \
    HLS_VERSION=${HLS_VERSION}

RUN apt-get update
RUN apt-get -y install libgmp-dev

FROM base AS haskell

USER ${USERNAME}

ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1 \
    BOOTSTRAP_HASKELL_MINIMAL=1 \
    BOOTSTRAP_HASKELL_NO_UPGRADE=1

RUN curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
ENV PATH="/home/${USERNAME}/.local/bin:/home/${USERNAME}/.ghcup/bin:$PATH"
RUN echo "export PATH=${PATH}" >> /home/${USERNAME}/.profile

RUN ghcup install stack ${STACK_VERSION} --set
RUN ghcup install hls ${HLS_VERSION} --set

ENV DEBIAN_FRONTEND=dialog
