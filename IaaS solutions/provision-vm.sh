#!/bin/bash

# set params for deployment
SUBSCRIPTION_NAME=demo-sub
APP_NAME=demo-win 
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
    --image "win2019datacenter" \
    --admin-username "demoadmin" \
    --admin-password "password1234%^&*"

# open RDP port 3389 to be able to connect to VM
az vm open-port \
    --resource-group $APP_NAME-rg \
    --name $APP_NAME-vm \
    --port "3389"

# get IP address associated with VM
az vm list-ip-addresses \
    --resource-group $APP_NAME-rg \
    --name $APP_NAME-vm \
    --output table

# clean up deployment
az group delete \
    --name $APP_NAME-rg
