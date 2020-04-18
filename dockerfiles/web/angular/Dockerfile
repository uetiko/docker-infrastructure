FROM node:12.16.2

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
        wget curl zip git zsh

RUN apt-clean

RUN set -uex;

RUN wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh;

RUN sh ./install.sh; 

RUN rm ./install.sh
