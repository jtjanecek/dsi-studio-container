FROM ubuntu:20.04 as builder-stage

ENV DEBIAN_FRONTEND noninteractive

# Prepare environment
RUN apt update && apt full-upgrade -y && \
  apt install -y --no-install-recommends \
  unzip \
  curl \
  make \
  git \
  libboost-all-dev \
  zlib1g-dev \
  ca-certificates \
  qt5-qmake \
  qt5-default \
  libqt5charts5-dev \
  libqt5opengl5-dev \
  gcc-7 \
  g++-7 && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -s /usr/bin/g++-7 /usr/bin/g++
RUN ln -s /usr/bin/gcc-7 /usr/bin/gcc

RUN mkdir /opt/dsi-studio
WORKDIR /opt/dsi-studio
RUN git clone https://github.com/frankyeh/DSI-Studio.git && cd DSI-Studio && git reset --hard 4ab34edf4152bab66dd3cb5b38d498ba7d199e99
RUN mv DSI-Studio src
RUN git clone https://github.com/frankyeh/TIPL.git && cd TIPL && git reset --hard 66146827c41b03d2fb77774524e7e5e1475918f7
RUN mv TIPL src/tipl
RUN mkdir -p /opt/dsi-studio/build
WORKDIR /opt/dsi-studio/build
RUN qmake ../src/dsi_studio.pro
RUN make

WORKDIR /opt/dsi-studio
RUN mv build/dsi_studio .
RUN chmod 755 dsi_studio
#RUN cp -R src/other/* .
RUN rm -rf src build
RUN git clone https://github.com/frankyeh/DSI-Studio-atlas.git
RUN rm -fr DSI-Studio-atlas/.git
RUN mv DSI-Studio-atlas atlas
ENV PATH="$PATH:/opt/dsi-studio" 

WORKDIR /data
ENTRYPOINT ["/opt/dsi-studio/dsi_studio"]
