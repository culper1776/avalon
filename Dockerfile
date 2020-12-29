FROM raspbian/stretch:latest
LABEL "project.home"="https://github.com/dtube/avalon"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y curl 
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
# RUN apt-get install -y npm
RUN apt-get install -y git wget tmux htop jq gpg build-essential screen mongodb

COPY ./ /avalon
WORKDIR /avalon


#RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
#RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
#RUN apt-get update
#RUN apt-get install -y mongodb-org-shell mongodb-org-tools

# Arm64
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 4B7C549A058F8B6B
#RUN echo "deb [arch=amd64] http://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
#RUN apt-get update
#RUN apt-get install -y mongodb-org

# AMD64
#RUN curl -fsSL https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add 
#RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list
#RUN apt-get update
#RUN apt-get install -y mongodb-org-shell mongodb-database-tools

#RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash \
#    && export NVM_DIR="$HOME/.nvm" \
#	&& [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
#	&& [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
#    && nvm install v14 \
#	&& nvm alias default v14 \
#    && nvm use v14 \
#	&& npm install
 
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

#RUN mkdir /avalon/dump && \
#	cd /avalon/dump && \
#	wget https://avalon.oneloved.tube/blocks.zip

CMD ["./scripts/entry.sh"]
