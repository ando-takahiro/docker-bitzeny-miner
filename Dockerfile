FROM ubuntu:16.04

RUN apt update -y && \
  apt install -y git build-essential libcurl4-openssl-dev autotools-dev automake && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir /bitzeny && \
  git clone https://github.com/macchky/cpuminer.git /bitzeny/cpuminer

WORKDIR /bitzeny/cpuminer
RUN ./autogen.sh && \
  ./configure CFLAGS="-O3 -march=native -funroll-loops -fomit-frame-pointer" && \
  make

ENV STRATUM "stratum+tcp://lycheebit.com:6234"
ENV USER "ZopBSBeZMxdbnWPFgKGDjwVtSn7KEydneY"
ENV PASSWORD "c=ZNY"
CMD ./minerd -a yescrypt -o $STRATUM -u $USER -p $PASSWORD

