FROM ubuntu:18.04
# Caching
RUN rm -f /etc/apt/apt.conf.d/docker-clean; echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache
# Install apt packages with docker BuildKit cache
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
    build-essential \
    cmake \
    doxygen \
    git \
    gnuradio \
    gnuradio-dev \
    ipython \
    libarmadillo-dev \
    libblas-dev \
    libboost-chrono-dev \
    libboost-date-time-dev \
    libboost-dev \
    libboost-filesystem-dev \
    libboost-program-options-dev \
    libboost-serialization-dev \
    libboost-system-dev \
    libboost-test-dev \
    libboost-thread-dev \
    libcppunit-dev \
    libcppunit-subunit-dev \
    libgcrypt-dev \
    libgflags-dev \
    libgnutls-openssl-dev \
    libgoogle-glog-dev \
    libgtest-dev \
    liblapack-dev \
    liblog4cpp5-dev \
    mercurial \
    python-cairo \
    python-crypto \
    python-dev \
    python-gtk2 \
    python-numpydoc \
    python-serial \
    python-setuptools \
    python-sphinx \
    python-tk \
    python-usb \
    swig \
    swig3.0 \
    tcpdump \
    xterm \
    sudo \
    wireshark \
    software-properties-common \
    python-setuptools


# Creating global gnuradio config
COPY ./Z3sec/patch/grc.conf /etc/gnuradio/conf.d/grc.conf

# Installing scapy-radio
COPY ./dependencies/scapy-radio/ /Z3sec/dependencies/scapy-radio/
WORKDIR /Z3sec/dependencies/scapy-radio
RUN ./install.sh
COPY ./Z3sec/patch/dot15d4.py /usr/local/lib/python2.7/dist-packages/scapy/layers/dot15d4.py

# Installing KillerBee
COPY ./dependencies/killerbee/ /Z3sec/dependencies/killerbee/
WORKDIR /Z3sec/dependencies/killerbee
COPY ./Z3sec/patch/scapy_extensions.py killerbee/scapy_extensions.py
RUN python setup.py install

# Installing gr-foo
COPY ./dependencies/gr-foo/ /Z3sec/dependencies/gr-foo/
WORKDIR /Z3sec/dependencies/gr-foo/build
RUN cmake .. && make
RUN make install
RUN ldconfig

# Installing gr-ieee802.15.4
COPY ./dependencies/gr-ieee802-15-4/ /Z3sec/dependencies/gr-ieee802-15-4/
WORKDIR /Z3sec/dependencies/gr-ieee802-15-4/build
RUN cmake .. && make
RUN make install
RUN ldconfig

# Downloading UHD image
COPY ./Z3sec /Z3sec/source
WORKDIR /Z3sec/source
RUN uhd_images_downloader

# Installing z3sec_zigbee.grc
COPY ./Z3sec/patch/z3sec_zigbee.grc ~/.scapy/radio/

# Installing Z3sec
RUN python setup.py install

WORKDIR /root