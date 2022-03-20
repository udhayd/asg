#! /bin/bash

##################################################################################################################
####  Description: Wrapper Script to create a AWS Cloudformation Stack for ec2 instance with eip attached     ####
####  Version: 1.0v                                                                                           ####
####  Usage: ./provision.sh -n stackname                                                                      ####
##################################################################################################################


## Function for help
usage() {
    echo -e '\n' "Usage: $0 -n 'name_of_stack'" '\n'

    echo -e '\n' "Example: $0 -n 'test'" '\n'
}

## To validate Arguments
if [ $# -ne 2 ]
then
    usage
    exit
fi

## To validate AWS Credentials
env|egrep -w 'AWS_CONTAINER_AUTHORIZATION_TOKEN' >/dev/null 2>&1 || env|egrep -w 'AWS_ACCESS_KEY_ID|AWS_SECRET_ACCESS_KEY|AWS_DEFAULT_REGION' >/tmp/aws 2>&1
cnt=$(wc -l /tmp/aws|awk '{print $1}')
if [ $cnt -ne 3 ]
then
    echo -e '\n' "One of following variables missing 'AWS_ACCESS_KEY_ID|AWS_SECRET_ACCESS_KEY|AWS_DEFAULT_REGION', Please configure the same" '\n'
    exit
fi

## Stack Function
vpc ()
{
echo -e '\n' "Network stack doesnt exist, Executing VPC Stack ..." '\n'
export VPC_STACK_NAME=$1-vpc;echo "VPC_STACK_NAME=$1-vpc" >vars.sh && bash vpc/provision.sh -n $1
}

ec2 ()
{
echo -e '\n' "Executing EC2 Stack ..." '\n'
export EC2_STACK_NAME=$1-ec2;echo "EC2_STACK_NAME=$1-ec2" >>vars.sh && bash asg/provision.sh -n $1
}

## Stack Execution
echo "Executing Script"
aws cloudformation list-exports|grep "MyVPCID" >/dev/null 2>&1
if [ $? -ne 0 ]
then
    vpc "$2"
    ec2 "$2"
else
    ec2 "$2"
fi
