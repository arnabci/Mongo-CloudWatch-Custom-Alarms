#!/bin/bash

sns_arn= <AWS_SNS_ARN>

# Add the Instances that have MongoDB installed locally and the 'mongo-cloudwatch-custom-metrics.sh' running every 5 mins.
ARRAY=( "<Instance_Name_1>:Instance_ID_1"
        "<Instance_Name_2>:Instance_ID_2"
        "<Instance_Name_3>:Instance_ID_3")


for ec2 in "${ARRAY[@]}" ; do
    instancename="${ec2%%:*}"
    instanceid="${ec2##*:}"


# Current Connections
aws cloudwatch put-metric-alarm --alarm-name "Concurrent connections of MongoDB running on "$instancename" is critical." --alarm-description "Concurrent connections of MongoDB running on "$instancename" is critical and has reached above 500. Please take care of this on priority." --metric-name CurrentConn --namespace Services --statistic Average --period 300 --threshold 500 --comparison-operator GreaterThanThreshold  --dimensions "Name=InstanceId,Value=$instanceid" --evaluation-periods 2 --alarm-actions $sns_arn --unit Count


# Available Connections
aws cloudwatch put-metric-alarm --alarm-name "Available connections of MongoDB running on "$instancename" is critical." --alarm-description "Available connections of MongoDB running on "$instancename" is critical and has reached below 50. Please take care of this on priority." --metric-name AvailableConn --namespace Services --statistic Average --period 300 --threshold 50 --comparison-operator LessThanThreshold  --dimensions "Name=InstanceId,Value=$instanceid" --evaluation-periods 2 --alarm-actions $sns_arn --unit Count


# Current Queue
aws cloudwatch put-metric-alarm --alarm-name "Current Queue of MongoDB running on "$instancename" is critical." --alarm-description "Current Queue of MongoDB running on "$instancename" is critical and has reached above 500. Please take care of this on priority." --metric-name CurrentQueue --namespace Services --statistic Average --period 300 --threshold 500 --comparison-operator GreaterThanThreshold  --dimensions "Name=InstanceId,Value=$instanceid" --evaluation-periods 2 --alarm-actions $sns_arn --unit Count


# Active Clients
aws cloudwatch put-metric-alarm --alarm-name "Active Clients of MongoDB running on "$instancename" is critical." --alarm-description "Active Clients of MongoDB running on "$instancename" is critical and has reached above 500. Please take care of this on priority." --metric-name ActiveClients --namespace Services --statistic Average --period 300 --threshold 500 --comparison-operator GreaterThanThreshold  --dimensions "Name=InstanceId,Value=$instanceid" --evaluation-periods 2 --alarm-actions $sns_arn --unit Count

# Concurrent Writes
aws cloudwatch put-metric-alarm --alarm-name "Concurrent Writes of MongoDB running on "$instancename" is critical." --alarm-description "Concurrent Writes of MongoDB running on "$instancename" is critical and has reached above 500. Please take care of this on priority." --metric-name ConcurrentWrite --namespace Services --statistic Average --period 300 --threshold 500 --comparison-operator GreaterThanThreshold  --dimensions "Name=InstanceId,Value=$instanceid" --evaluation-periods 2 --alarm-actions $sns_arn --unit Count


# Concurrent Reads
aws cloudwatch put-metric-alarm --alarm-name "Concurrent Reads of MongoDB running on "$instancename" is critical." --alarm-description "Concurrent Reads of MongoDB running on "$instancename" is critical and has reached above 500. Please take care of this on priority." --metric-name ConcurrentRead --namespace Services --statistic Average --period 300 --threshold 500 --comparison-operator GreaterThanThreshold  --dimensions "Name=InstanceId,Value=$instanceid" --evaluation-periods 2 --alarm-actions $sns_arn --unit Count


# Memory Consumed
aws cloudwatch put-metric-alarm --alarm-name "Memory Consumption of MongoDB running on "$instancename" is critical." --alarm-description "Memory Consumption of MongoDB running on "$instancename" is critical and has reached above 10GiB. Please take care of this on priority." --metric-name MongoMemory --namespace Services --statistic Average --period 300 --threshold 10 --comparison-operator GreaterThanThreshold  --dimensions "Name=InstanceId,Value=$instanceid" --evaluation-periods 2 --alarm-actions $sns_arn --unit Megabytes

done