#! /bin/bash

##################################################################################################################
####  Description: Wrapper Script to create a AWS Cloudformation Stack for ec2 instance with eip attached     ####
####  Version: 1.0v                                                                                           ####
####  Usage: ./provision.sh -n stackname                                                                      ####
##################################################################################################################


#### Function for help
usage() {
    echo "Usage: $0 [options]"
    
    echo " -n, --name  name of stack"
}

#### To validate the Arguments
if [ $# -ne 2 ]
then
    usage
    exit
fi

#### Varible Initialization
echo "EC2_STACK_NAME=$2-ec2" >asg/vars.sh
source asg/vars.sh
set -ex

# EC2 Stack Creation
aws cloudformation deploy --template-file asg/asg.yaml --stack-name $EC2_STACK_NAME --no-fail-on-empty-changeset --capabilities CAPABILITY_IAM
