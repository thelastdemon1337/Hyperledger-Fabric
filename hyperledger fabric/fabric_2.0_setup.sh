#!/bin/bash

echo " ____    ____  ________  _________     _       _____       ___   ___  ____    
|_   \  /   _||_   __  ||  _   _  |   / \     |_   _|    .'   `.|_  ||_  _|   
  |   \/   |    | |_ \_||_/ | | \_|  / _ \      | |     /  .-.  \ | |_/ /     
  | |\  /| |    |  _| _     | |     / ___ \     | |   _ | |   | | |  __'.     
 _| |_\/_| |_  _| |__/ |   _| |_  _/ /   \ \_  _| |__/ |\  `-'  /_| |  \ \_   
|_____||_____||________|  |_____||____| |____||________| `.___.'|____||____|  
                                                                              "

# Update package lists
sudo apt-get update

# Install curl and golang
sudo apt-get install -y curl golang

# Set up GOPATH and PATH environment variables
if ! grep -q "GOPATH" ~/.bashrc ; then
  echo 'export GOPATH=$HOME/go' >> ~/.bashrc
fi

if ! grep -q "PATH.*GOPATH" ~/.bashrc ; then
  echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
fi

source ~/.bashrc


# Install Node.js and npm
sudo apt-get install -y nodejs npm

# Install Python
sudo apt-get install -y python2

# Display versions of installed packages
echo "Curl version:"
curl --version | head -n 1
echo "Go version:"
go version
echo "Node.js version:"
node --version
echo "npm version:"
npm --version
echo "Python version:"
python --version

# Hyperledger fabric and Couch DB
# curl sSL https://bit.ly/2ysbOFE | bash -s -- fabric_version fabric-ca_version thirdparty_version
if [ ! -d "fabric-samples" ]; then
  curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.0.1 1.4.6 0.4.18
else
  echo "fabric-samples directory already exists, skipping installation."
fi

if ! grep -q "$(pwd)/fabric-samples/bin" ~/.bashrc ; then
  echo 'export PATH=$PATH:'$(pwd)'/fabric-samples/bin' >> ~/.bashrc
fi

source ~/.bashrc