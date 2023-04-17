chmod -R 0755 ./crypto-config
# Delete existing artifacts
rm -rf ./crypto-config
rm -rf ./genesis.block
rm genesis.block mychannel.tx
rm -rf ../../channel-artifacts/*

#Generate Crypto artifactes for organizations
cryptogen generate --config=./crypto-config.yaml --output=./crypto-config/



# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "mychannel"
CHANNEL_NAME_1="mychannel"
CHANNEL_NAME_2="notmychannel"

echo Channels working on
echo $CHANNEL_NAME_1
echo $CHANNEL_NAME_2
# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./genesis.block


# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./$CHANNEL_NAME_1.tx -channelID $CHANNEL_NAME_1
configtxgen -profile ExtendedChannel -configPath . -outputCreateChannelTx ./$CHANNEL_NAME_2.tx -channelID $CHANNEL_NAME_2

echo "#######    Generating anchor peer update for Org1MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org1MSPanchors.tx -channelID $CHANNEL_NAME_1 -asOrg Org1MSP

echo "#######    Generating anchor peer update for Org2MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org2MSPanchors.tx -channelID $CHANNEL_NAME_1 -asOrg Org2MSP

echo "#######    Generating anchor peer update for Org3MSP  ##########"
configtxgen -profile ExtendedChannel -configPath . -outputAnchorPeersUpdate ./Org3MSPanchors.tx -channelID $CHANNEL_NAME_2 -asOrg Org3MSP