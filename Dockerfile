FROM ubuntu:16.04

WORKDIR /root

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y --purge && \
    apt-get install -y cpio python3 gawk wget git-core diffstat unzip texinfo gcc-multilib \
        build-essential chrpath python vim locales
RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN git clone -b morty git://git.yoctoproject.org/poky.git poky-morty && \
    cd poky-morty && \
    git clone -b morty git://git.openembedded.org/meta-openembedded --depth=1 && \
    git clone -b morty git://git.yoctoproject.org/meta-raspberrypi --depth=1 && \
    git clone -b morty https://github.com/meta-qt5/meta-qt5.git --depth=1 && \
    cd /root && \
    mkdir rpi && \
    cd rpi && \
    git clone -b morty git://github.com/jumpnow/meta-rpi --depth=1

COPY build.sh /root/build.sh

CMD ["/bin/bash", "/root/build.sh"]
