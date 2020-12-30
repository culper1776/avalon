FROM raspbian/stretch:latest
LABEL "project.home"="https://github.com/dtube/avalon"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y curl 
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN apt-get install -y git wget tmux htop jq gpg build-essential screen mongodb ntp tzdata

COPY ./ /avalon
WORKDIR /avalon
 
RUN npm install

EXPOSE 6001
EXPOSE 3001
ENV DB_URL 'mongodb://10.0.0.40:27017'
ENV DB_NAME 'avalon'
ENV NODE_OWNER unset
ENV NODE_OWNER_PUB unset
ENV NODE_OWNER_PRIV unset
ENV NODE_LEADER_PUB unset
ENV NODE_LEADER_PRIV unset

ENV SET_CONTAINER_TIMEZONE true
ENV CONTAINER_TIMEZONE America/Chicago

ENV PEERS 'ws://35.203.60.208:6001,ws://dseed.techcoderx.com:6001,ws://139.59.209.189:6001' 
ENV MONGO_IP unset

RUN mkdir /avalon/genesis && \
    cd /avalon/genesis && \
    wget https://backup.d.tube/genesis.zip

#RUN mkdir /avalon/dump && \
#	cd /avalon/dump && \
#	wget https://avalon.oneloved.tube/blocks.zip

CMD ["./scripts/entry.sh"]
