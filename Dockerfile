FROM ubuntu:18.04

COPY ./TriangleEarthSociety.conf /root/.TriangleEarthSociety/TriangleEarthSociety.conf

COPY . /TriangleEarthSociety
WORKDIR /TriangleEarthSociety

#shared libraries and dependencies
RUN apt update
RUN apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 curl libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev libboost-all-dev libboost-program-options-dev libminiupnpc-dev libzmq3-dev libgmp3-dev libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler libqrencode-dev unzip doxygen cmake nsis wine-stable wine64 bc -y
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils
RUN apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev

#BerkleyDB for wallet support
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install -y libdb4.8-dev libdb4.8++-dev

#upnp
RUN apt-get install -y libminiupnpc-dev

#ZMQ
RUN apt-get install -y libzmq3-dev

#build TriangleEarthSociety source
RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install

#open service port
EXPOSE 35222

CMD ["TriangleEarthSocietyd", "--printtoconsole"]
