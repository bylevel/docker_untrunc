FROM ubuntu:16.04

RUN apt update
RUN apt-get install -y libavformat-dev libavcodec-dev libavutil-dev

WORKDIR /root

RUN wget https://github.com/ponchio/untrunc/archive/master.zip
RUN unzip master.zip
RUN cd untrunc-master && g++ -o untrunc file.cpp main.cpp track.cpp atom.cpp mp4.cpp -L/usr/local/lib -lavformat -lavcodec -lavutil
