#! /bin/bash


# create a security group and store ssh key to my-key-pair3.pem
ec2-create-keypair my-key-pair4 > ~/keys/my-key-pair4.pem

# set permissions on the the key pair
chmod 400 my-key-pair4.pem

#create a VPC security group that holds firewall settings using account default Virtual Private Cloud
ec2-create-group ssh-only -d "ssh-only" -c vpc-9ec266fb

#uses group id from previous command
ec2-authorize sg-a8d8a1cf -P tcp -p 22 -s 0.0.0.0/32

# start instance - use string from keypair creation - not the .pem file name
ec2-run-instances ami-00a11e68 -t t2.micro -k my-key-pair4 -g ssh-only

ec2-describe-instances i-5df8dbf6

ssh -i ~/keys/my-key-pair4.pem ec2-user@52.20.213.93 