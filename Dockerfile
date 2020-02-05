FROM ubuntu:16.04
MAINTAINER daniel.le@czbiohub.org (Daniel D. Le)

RUN apt-get -y update && \
    apt-get -y install \
    software-properties-common \
    build-essential \
    make \
    cmake \
    git-core \
    zlib1g \
    zlib1g-dev \
    wget
    
# python install
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -y update && \
    apt-get -y install \
        python3.6 \
        libpython3.6 \
        python3.6-dev \
        python3-pip && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 2 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1 && \
    rm /usr/bin/python3 && \
    ln -s python3.6 /usr/bin/python3
    
# install packages
RUN pip3 install numpy==1.13.3

# racon build
RUN git clone --recursive https://github.com/isovic/racon.git racon && \
    cd racon && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make && \
    cd
ENV PATH $PATH:/racon/build/bin/racon

# poaV2 build
RUN git clone https://github.com/tanghaibao/bio-pipeline.git && \
    cd bio-pipeline/poaV2 && \
    make poa && \
    cd
ENV PATH $PATH:/bio-pipeline/poaV2/poa
    
# minimap2 build
RUN git clone https://github.com/lh3/minimap2 --branch v2.7 && \
    cd minimap2 && \
    make && \
    cd
ENV PATH $PATH:/minimap2/minimap2
    
# gonk build
RUN git clone https://github.com/rvolden/gonk && \
    cd gonk && \
    make && \
    cd
ENV PATH $PATH:/gonk/gonk
    
# golang build
RUN wget https://dl.google.com/go/go1.13.6.linux-amd64.tar.gz && \
    tar -xvf go1.13.6.linux-amd64.tar.gz && \
    mv go /usr/local
ENV PATH $PATH:/usr/local/go/bin

# blat build 
RUN mkdir blat && \
    cd blat &&\
    wget http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/blat/blat && \
    chmod 755 ./blat
ENV PATH $PATH:/blat/blat
    
# add scripts
ADD C3POa_preprocessing.py ./
ADD C3POa.py ./
ADD C3POa_postprocessing.py ./
ADD consensus.py ./
ENV PATH $PATH:consensus.py
