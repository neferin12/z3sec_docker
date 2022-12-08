FROM ubuntu:16.10

COPY ./Z3sec /Z3sec

WORKDIR /Z3sec

RUN chmod +x install_dependencies.sh

RUN bash ./install_dependencies.sh
