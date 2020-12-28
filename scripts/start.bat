@echo off
::!/bin/bash

:: Ports configuration
setx HTTP_PORT "3001"
setx P2P_PORT "6001"

:: MongoDB configuration
setx DB_NAME "avalon"
setx DB_URL "mongodb://10.0.0.40:27017"

:: Peering configuration
::setx OFFLINE "1"
::setx NO_DISCOVERY "1"
::setx DISCOVERY_EXCLUDE "dtube"

:: Enable more modules
::setx NOTIFICATIONS "1"
::setx RANKINGS "1"

:: Cache warmup option
setx WARMUP_ACCOUNTS "100000"
setx WARMUP_CONTENTS "0"

:: Warn when a transactions takes more than X ms
setx WARN_SLOW_VALID "5"
setx WARN_SLOW_EXEC "5"

:: trace / perf / econ / cons / debug / info / warn
setx LOG_LEVEL "info"

:: groups blocks during replay output to lower screen spam
setx REPLAY_OUTPUT "100"

:: Rebuild chain state from dump, verifying every block and transactions
:: Do not forget to comment this out after rebuild
::setx REBUILD_STATE=1
::setx REBUILD_RESUME_BLK=

:: default peers to connect with on startup
setx PEERS ""
setx MAX_PEERS "20"

:: your user and keys (only useful for active node owners)
setx NODE_OWNER "culper1776"
setx NODE_OWNER_PUB "rbryDv8a8am6YxnWctr4y4ReRN3FPmy6VtoHDZNkeajb"
setx NODE_OWNER_PRIV "4Yj5Tiz2BWYvwyQGNXsZtsnAdz5JyrQHmULs9pQoLi3f"

::src path
cd "C:\Users\Username\Desktop\avalon\src"
start cmd /K node --stack-size=65500 main
