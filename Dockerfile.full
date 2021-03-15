FROM  debian:bullseye-slim

ARG TARGETARCH

LABEL maintainer="Supphachoke Suntiwichaya <mrchoke@gmail.com>"

RUN apt update \
  && apt install -y ssh \
  curl \
  wget \
  locales \
  tmux \
  git \
  build-essential \
  libmariadb-dev \
  fontconfig \
  python3-pygments \
  python3-pip \
  python3-venv \
  && apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
  &&  sed --in-place '/en_US.UTF-8/s/^#//' /etc/locale.gen  \
  &&  sed --in-place '/th_TH.UTF-8/s/^#//' /etc/locale.gen \
  &&  locale-gen \
  &&  mkdir /var/run/sshd \
  &&  echo 'root:123456' | chpasswd \
  &&  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  &&  sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
  &&  echo "export VISIBLE=now" >> /etc/profile \
  &&  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
  &&  mkdir /tmp/install-tl  \
  && curl https://download.nus.edu.sg/mirror/ctan/systems/texlive/tlnet/install-tl-unx.tar.gz \
  | tar -xzC /tmp/install-tl --strip-components 1


ENV NOTVISIBLE "in users profile"

ENV TZ=Asia/Bangkok

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  


ADD texlive.profile.$TARGETARCH /tmp/install-tl/texlive.profile
RUN cd /tmp/install-tl && ./install-tl --profile=texlive.profile && cd ../ && rm -rf install-tl

ENV PATH="/usr/local/texlive/2020/bin/x86_64-linux:${PATH}"

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
