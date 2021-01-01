#!/bin/bash


if [ "${DB_URL}" != "unset" ] ; then 
	export DB_URL="mongodb://${DB_URL}":27017
else
    export DB_URL="mongodb://localhost":27017
fi

GEN_KEYS=`node src/cli.js keypair`
GEN_PUB_KEY=`echo "${GEN_KEYS}" | jq '.pub'`
GEN_PRI_KEY=`echo "${GEN_KEYS}" | jq '.priv'`

echo "generated keys: ${GEN_KEYS}"

if [ "${NODE_OWNER}" == "unset" ] ; then 
	export NODE_OWNER='default user' 
	sed -i -e "s/export NODE_OWNER=.*/export NODE_OWNER=${NODE_OWNER}/g" ./scripts/start.sh
else 
	export NODE_OWNER="${NODE_OWNER}" 
	sed -i -e "s/export NODE_OWNER=.*/export NODE_OWNER=${NODE_OWNER}/g" ./scripts/start.sh
fi

echo "Node Owner set to: ${NODE_OWNER}"

if [ "${NODE_OWNER_PUB}" == "unset" ] ; then
	export NODE_OWNER_PUB='Invalid Key'
	sed -i -e "s/export NODE_OWNER_PUB=.*/export NODE_OWNER_PUB=${GEN_PUB_KEY}/g" ./scripts/start.sh
else 
	export NODE_OWNER_PUB="${NODE_OWNER_PUB}"
	sed -i -e "s/export NODE_OWNER_PUB=.*/export NODE_OWNER_PUB=${NODE_OWNER_PUB}/g" ./scripts/start.sh
fi

echo "Node Owner Public Key set to: ${NODE_OWNER_PUB}"

if [ "${NODE_OWNER_PRIV}" == "unset" ] ; then 
	export NODE_OWNER_PRIV='Invalid Key'
	sed -i -e "s/export NODE_OWNER_PRIV=.*/export NODE_OWNER_PRIV=${GEN_PRI_KEY}/g" ./scripts/start.sh
else 
	export NODE_OWNER_PRIV="${NODE_OWNER_PRIV}"
	sed -i -e "s/export NODE_OWNER_PRIV=.*/export NODE_OWNER_PRIV=${NODE_OWNER_PRIV}/g" ./scripts/start.sh
fi

echo "Node Owner Private Key set to: ${NODE_OWNER_PRIV}"


if [ "${NODE_LEADER_PUB}" != "unset" ] ; then
	if [ "${NODE_LEADER_PRIV}" != "unset" ] ; then
		echo "{\"pub\":\"${NODE_LEADER_PUB}\",\"priv\":\"${NODE_LEADER_PRIV}\"}" > leader-key.json
		
		echo "leader-key set to: "
		cat leader-key.json
	fi
fi

if [ "$SET_CONTAINER_TIMEZONE" = "true" ]; then
	echo ${CONTAINER_TIMEZONE} >/etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata
	echo "Container timezone set to: $CONTAINER_TIMEZONE"
else
	echo "Container timezone not modified"
fi

echo "Node Version is"
node -v

#ntpd -gq
ntpq -pn
#service ntp start
/etc/init.d/ntp start

#node src/cli key > leader-key.json

#echo "Leader key:"
#cat leader-key.json


# Transaction if leader
# node src/cli enable-node ${NODE_OWNER_PUB} -M ${NODE_OWNER} -K YOUR_MASTER_KEY

./scripts/start.sh
