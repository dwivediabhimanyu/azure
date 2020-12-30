#!/bin/bash

# set params for deployment
SUBSCRIPTION_NAME=demo-sub
APP_NAME=demo-linux 
LOCATION=centralindia

# login to azure account
az login

# set subscription 
az account set --subscription $SUBSCRIPTION_NAME


# create resource group
az group create \
    --name $APP_NAME-rg \
    --location $LOCATION

# create a Windows vm 
az vm create \
    --resource-group $APP_NAME-rg \
    --name $APP_NAME-vm \
    --size "Standard_B1ls" \
    --image "UbuntuLTS" \
    --admin-username "demoadmin" \
    --authentication-type "ssh" \
    --ssh-key-value ~/.ssh/id_rsa.pub

# openSSH port 22 to be able to connect to VM
az vm open-port \
    --resource-group $APP_NAME-rg \
    --name $APP_NAME-vm \
    --port "22"

# get IP address associated with VM
az vm list-ip-addresses \
    --resource-group $APP_NAME-rg \
    --name $APP_NAME-vm \
    --output table

#login to VM
ssh demoadmin@<PUBLIC_IP_ADDRESS>
