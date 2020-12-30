#!/bin/bash

# fetch list of all locations 
az account list-locations -o table

# fetch list of all vm sizes
az vm list-sizes -l centralindia -o table
