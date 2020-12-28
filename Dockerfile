FROM node:10-buster-slim
MAINTAINER KM6HRD <robb@km6hrd.com>
LABEL "project.home"="https://github.com/dtube/avalon"

RUN apt-get update
RUN apt-get install -y git wget ntp gnupg nano jq ntp

# Set this environment variable to true to set timezone on container start.
ENV SET_CONTAINER_TIMEZONE true
# Default container timezone as found under the directory /usr/share/zoneinfo/.
ENV CONTAINER_TIMEZONE America/Chicago

RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add 	
RUN echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
RUN apt-get update
RUN apt-get install -y mongodb-org-tools mongodb-org-shell

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

ENV PEERS 'ws://35.203.60.208:6001,ws://dseed.techcoderx.com:6001,ws://139.59.209.189:6001' 
ENV MONGO_IP unset

RUN mkdir /avalon/genesis && \
    cd /avalon/genesis && \
    wget https://backup.d.tube/genesis.zip

# RUN mkdir /avalon/dump && \
#	cd /avalon/dump && \
#	wget https://avalon.oneloved.tube/blocks.zip

CMD ["./scripts/entry.sh"]
