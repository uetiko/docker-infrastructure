FROM node:12.16.2

WORKDIR /opt/source

RUN apt-get update

RUN apt-get install -y \
    vim curl zip zsh git

RUN apt autoremove

RUN wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh;

RUN sh ./install.sh; 

RUN rm ./install.sh