#!/bin/bash
cd artifacts/channel/ && ./create-artifacts.sh
cd .. && docker-compose up -d
echo Sleeping 15 seconds to allow Raft to complete booting up
sleep 15
cd .. && ./createChannel.sh