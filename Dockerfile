FROM debian:8 AS builder

RUN apt-get update && apt-get install -y build-ess* unzip

WORKDIR /root

ADD https://libav.org/releases/libav-12.3.tar.xz /root
ADD https://github.com/ponchio/untrunc/archive/master.zip /root
RUN unzip master.zip
RUN tar -xJf libav-12.3.tar.xz -C untrunc-master

WORKDIR /root/untrunc-master/libav-12.3
RUN ./configure --disable-yasm
RUN make
WORKDIR /root/untrunc-master
RUN apt-get install zlib1g-dev
RUN g++ -o untrunc -I./libav-12.3 file.cpp main.cpp track.cpp atom.cpp mp4.cpp -L./libav-12.3/libavformat -lavformat -L./libav-12.3/libavcodec -lavcodec -L./libav-12.3/libavresample -lavresample -L./libav-12.3/libavutil -lavutil -lpthread -lz

FROM debian:8

WORKDIR /root
COPY --from=builder /root/untrunc-master/untrunc /root/
