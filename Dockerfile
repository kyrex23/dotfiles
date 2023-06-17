FROM ubuntu:22.04
LABEL author="kyrex23"

RUN apt update && apt install -y sudo git python3 curl

RUN mkdir /root/dotfiles
COPY . /root/dotfiles

WORKDIR /root/dotfiles
CMD ["bash"]
