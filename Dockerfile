FROM ubuntu

RUN apt-get update

RUN apt-get install -y curl

RUN apt-get install -y python
RUN apt-get install -y python-pip

CMD PATH=$PATH:/$HOME/.local/bin

