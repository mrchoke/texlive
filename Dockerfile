FROM  debian:bullseye-slim

ARG TARGETARCH

LABEL maintainer="Supphachoke Suntiwichaya <mrchoke@gmail.com>"

ENV TZ=Asia/Bangkok

RUN apt update \
  && apt install -y \
  curl \
  wget \
  locales \
  git \
  fontconfig \
  python3-pygments \
  python3-pip \
  python3-venv \
  swath \
  liblog-log4perl-perl \
  libyaml-tiny-perl \
  libfile-homedir-perl \
  libunicode-linebreak-perl \
  && apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
  &&  sed --in-place '/en_US.UTF-8/s/^#//' /etc/locale.gen  \
  &&  sed --in-place '/th_TH.UTF-8/s/^#//' /etc/locale.gen \
  &&  locale-gen \
  &&  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
  &&  mkdir /tmp/install-tl  \
  && curl https://download.nus.edu.sg/mirror/ctan/systems/texlive/tlnet/install-tl-unx.tar.gz \
  | tar -xzC /tmp/install-tl --strip-components 1


ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  


ADD texlive.profile.$TARGETARCH /tmp/install-tl/texlive.profile
RUN cd /tmp/install-tl && ./install-tl --profile=texlive.profile && cd ../ && rm -rf install-tl

CMD ["/bin/sh"]
