# Mongo-CloudWatch-Custom-Alarms


# mongo-cloudwatch-custom-metrics.sh

The first code is a bash script that collects MongoDB performance metrics and pushes them to Amazon CloudWatch. The script begins by obtaining the EC2 instance ID and region using metadata from the instance. It then collects MongoDB server status metrics, including the number of current connections, available connections, current queue, active clients, concurrent writes, concurrent reads, and memory consumed.

Each metric is pushed to CloudWatch using the "aws cloudwatch put-metric-data" command with the appropriate metric name, dimensions, and value. The "namespace" parameter is set to "Services", and the EC2 instance ID is used as a dimension to differentiate the metrics between different MongoDB instances.


# mongo-alarm-creation.sh

The second code is also a bash script that sets up CloudWatch alarms based on the MongoDB performance metrics collected by the first script. The script begins by defining an array of MongoDB instances, each with a name and ID. It then iterates through the array and sets up alarms for each instance based on the same MongoDB performance metrics collected by the first script.

For each metric, an alarm is created with a specific name and description. The alarm is triggered if the metric exceeds a certain threshold, such as 500 for concurrent connections or falls below a certain threshold, such as 50 for available connections. The "aws cloudwatch put-metric-alarm" command is used to create the alarm with the appropriate parameters, including the metric name, statistic, period, threshold, dimensions, evaluation periods, and alarm actions.

The alarm actions are defined as an SNS topic ARN that is passed in as a parameter to the script. This topic is notified when an alarm is triggered, allowing for immediate intervention by the appropriate team to resolve the issue.


In summary, the two scripts work together to collect MongoDB performance metrics and create CloudWatch alarms based on those metrics. This provides an automated monitoring solution for MongoDB instances running on AWS EC2 instances.
