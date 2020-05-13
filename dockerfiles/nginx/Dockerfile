FROM nginx:1.17.6

RUN apt-get update

RUN apt-get install --no-install-recommends -y -q ca-certificates wget vim \
  zsh git

RUN apt autoremove

RUN wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh;

RUN sh ./install.sh; 

RUN rm ./install.sh
