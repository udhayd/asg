# first

## Infrastructure As a Code to create VPC, AutoscalingGroup, LaunchTemplate, ELB, TargetGroup, EC2 instance to start with Cloudformation.
## Following scripts creates Network stack and Ec2 instance with 1GB EBS Volume with EIP , webserver installed.

PREQUISITES : aws cli to be installed (Or) please execute below steps from aws cloud shell .

## To download the script
$ git clone  https://github.com/udhayd/asg-ec2

$ cd asg

## To Create the Stack
$ ./provision.sh -n "name of stack"

## To Destroy the Stack
$ ./destroy.sh

## To Access the webserver
Please verify the websever access through ELB DNS Name http://ipaddress
