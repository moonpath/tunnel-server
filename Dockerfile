FROM ubuntu:22.04 as base

ARG DEBIAN_FRONTEND noninteractive
ARG USER=admin

ENV TIMES=-1
ENV INTERVAL=5

RUN adduser $USER --disabled-password --gecos ''

RUN apt update

RUN apt install -y sudo && \
    echo "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN apt install -y openssh-server && \
    sed -i 's/^#\?PermitRootLogin .*$/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/^#\?PermitEmptyPasswords .*$/PermitEmptyPasswords no/' /etc/ssh/sshd_config && \
    echo "AllowUsers $USER" >> /etc/ssh/sshd_config

RUN apt install -y vim && \
    echo 'set expandtab' > /etc/vim/vimrc && \
    echo 'set shiftwidth=4' >> /etc/vim/vimrc && \
    echo 'set ts=4' >> /etc/vim/vimrc && \
    echo 'set hlsearch' >> /etc/vim/vimrc && \
    echo 'set fileencodings=utf-8' >> /etc/vim/vimrc && \
    echo 'set termencoding=utf-8' >> /etc/vim/vimrc && \
    echo 'set encoding=utf-8' >> /etc/vim/vimrc

RUN apt install -y \
    curl \
    iproute2 \
    iputils-ping \
    netcat \
    nmap \ 
    rsync \
    socat \
    wget

RUN apt -y autoclean && \
    apt -y autoremove && \
    rm -rf /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*

COPY scripts /usr/local/bin
RUN chmod +x /usr/local/bin/set_gateway_host
RUN chmod +x /usr/local/bin/start_tunnel_server

USER $USER
CMD ["--help"]
ENTRYPOINT ["/usr/local/bin/start_tunnel_server"]
