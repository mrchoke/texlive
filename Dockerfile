FROM  python:3.11-slim

ARG TARGETARCH
ARG VERSION=2023

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
  && curl https://mirror.kku.ac.th/CTAN/systems/texlive/tlnet/install-tl-unx.tar.gz \
  | tar -xzC /tmp/install-tl --strip-components 1


ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8  


ADD texlive.profile.${TARGETARCH} /tmp/install-tl/texlive.profile
RUN sed --in-place "s/VERSION/${VERSION}/g" /tmp/install-tl/texlive.profile
RUN cd /tmp/install-tl && ./install-tl --profile=texlive.profile && cd ../ && rm -rf install-tl

# ENV PATH="/usr/local/texlive/${VERSION}/bin/x86_64-linux:$PATH"
# ENV MANPATH="/usr/local/texlive/${VERSION}/texmf-dist/doc/man:$MANPATH"
# ENV INFOPATH="/usr/local/texlive/${VERSION}/texmf-dist/doc/info:$INFOPATH"

# RUN echo "export PATH=/usr/local/texlive/${VERSION}/bin/x86_64-linux:$PATH" >> ~/.bashrc
RUN echo "export MANPATH=/usr/local/texlive/${VERSION}/texmf-dist/doc/man:$MANPATH" >> ~/.bashrc
RUN echo "exportINFOPATH=/usr/local/texlive/${VERSION}/texmf-dist/doc/info:$INFOPATH" >> ~/.bashrc

RUN if [[ "${TARGETARCH}" = "amd64" ]] ; then \
  echo "export PATH=/usr/local/texlive/${VERSION}/bin/x86_64-linux:$PATH" >> ~/.bashrc; \
  fi

RUN if [[ "${TARGETARCH}" = "arm64" ]] ; then \
  echo "export PATH=/usr/local/texlive/${VERSION}/bin/aarch64-linux:$PATH" >> ~/.bashrc; \
  fi

RUN cp /usr/local/texlive/${VERSION}/texmf-var/fonts/conf/texlive-fontconfig.conf /etc/fonts/conf.d/09-texlive.conf
RUN fc-cache -fsv

CMD ["/bin/sh"]
