#!/bin/bash

EC2_INSTANCE_ID=$(wget -q -O - http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(wget -q -O - http://169.254.169.254/latest/meta-data/placement/availability-zone | awk '{print substr($1, 1, length($1)-1)}')

CONN_CUR=$(mongo -u mongoAdmin -p mongo@password --authenticationDatabase admin --eval "printjson(db.serverStatus().connections.current)" | tail -1)
CONN_AVAILABLE=$(mongo -u mongoAdmin -p mongo@password --authenticationDatabase admin --eval "printjson(db.serverStatus().connections.available)" | tail -1)
CURQUE=$(mongo -u mongoAdmin -p mongo@password --authenticationDatabase admin --eval "printjson(db.serverStatus().globalLock.currentQueue.total)" | tail -1)
ACTCLI=$(mongo -u mongoAdmin -p mongo@password --authenticationDatabase admin --eval "printjson(db.serverStatus().globalLock.activeClients.total)" | tail -1)
CONWRI=$(mongo -u mongoAdmin -p mongo@password --authenticationDatabase admin --eval "printjson(db.serverStatus().wiredTiger.concurrentTransactions.write.out)" | tail -1)
CONRD=$(mongo -u mongoAdmin -p mongo@password --authenticationDatabase admin --eval "printjson(db.serverStatus().wiredTiger.concurrentTransactions.read.out)" | tail -1)
MONMEM=$(mongo -u mongoAdmin -p mongo@password --authenticationDatabase admin --eval "printjson(db.serverStatus().mem.resident)" | tail -1)

# Current Connections
aws cloudwatch put-metric-data --region=$REGION --namespace Services --dimensions MongoDB=$EC2_INSTANCE_ID --metric-name 'CurrentConn' --unit 'Count' --value=$CONN_CUR

# Available Connections
aws cloudwatch put-metric-data --region=$REGION --namespace Services --dimensions MongoDB=$EC2_INSTANCE_ID --metric-name 'AvailableConn' --unit 'Count' --value=$CONN_AVAILABLE

# Current Queue
aws cloudwatch put-metric-data --region=$REGION --namespace Services --dimensions MongoDB=$EC2_INSTANCE_ID --metric-name 'CurrentQueue' --unit 'Count' --value=$CURQUE

# Active Clients
aws cloudwatch put-metric-data --region=$REGION --namespace Services --dimensions MongoDB=$EC2_INSTANCE_ID --metric-name 'ActiveClients' --unit 'Count' --value=$ACTCLI

# Concurrent Writes
aws cloudwatch put-metric-data --region=$REGION --namespace Services --dimensions MongoDB=$EC2_INSTANCE_ID --metric-name 'ConcurrentWrite' --unit 'Count' --value=$CONWRI

# Concurrent Reads
aws cloudwatch put-metric-data --region=$REGION --namespace Services --dimensions MongoDB=$EC2_INSTANCE_ID --metric-name 'ConcurrentRead' --unit 'Count' --value=$CONRD

# Memory Consumed
aws cloudwatch put-metric-data --region=$REGION --namespace Services --dimensions MongoDB=$EC2_INSTANCE_ID --metric-name 'MongoMemory' --unit 'Megabytes' --value=$MONMEM
