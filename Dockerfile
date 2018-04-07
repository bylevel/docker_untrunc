FROM alpine:3.7

RUN apk update && apk add build-base

WORKDIR /root

ADD https://libav.org/releases/libav-12.3.tar.xz /root
ADD https://github.com/ponchio/untrunc/archive/master.zip /root
RUN unzip master.zip
RUN tar -xJf libav-12.3.tar.xz -C untrunc-master

WORKDIR /root/untrunc-master/libav-12.3
RUN ./configure --disable-yasm
RUN make
WORKDIR /root/untrunc-master
RUN g++ -o untrunc file.cpp main.cpp track.cpp atom.cpp mp4.cpp -L/usr/local/lib -lavformat -lavcodec -lavutil
