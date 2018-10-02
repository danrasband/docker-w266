FROM ubuntu:18.04

RUN apt update \
  && apt upgrade -y \
  && apt install -y bzip2 wget gnupg \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir /compute
WORKDIR /compute

ENV ANACONDA_INSTALLER Anaconda3-5.2.0-Linux-x86_64.sh
RUN wget "https://repo.continuum.io/archive/$ANACONDA_INSTALLER"
RUN printf '\nyes\n\nyes\nno\nyes\nno\n' | bash "$ANACONDA_INSTALLER"
RUN /bin/bash -c "source $HOME/.bashrc"

ENV TF_BINARY_URL https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.10.1-cp36-cp36m-linux_x86_64.whl
RUN $HOME/anaconda3/bin/pip install --upgrade pip \
  && $HOME/anaconda3/bin/pip install $TF_BINARY_URL \
  && $HOME/anaconda3/bin/jupyter notebook --generate-config

COPY support/jupyter_notebook_config.py /root/.jupyter/

RUN apt update && apt install -y graphviz && rm -rf /var/lib/apt/lists/*
