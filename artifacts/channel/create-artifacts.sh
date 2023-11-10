
# Delete existing artifacts
rm genesis.block mychannel.tx
rm -rf ../../channel-artifacts/*


# System channel
SYS_CHANNEL="sys-channel"

# channel name defaults to "mychannel"
CHANNEL_NAME="mychannel"
CHANNEL_NAME2="mychannel2"
CHANNEL_NAME3="mychannel3"
CHANNEL_NAME4="mychannel4"

echo $CHANNEL_NAME

# Generate System Genesis block
configtxgen -profile OrdererGenesis -configPath . -channelID $SYS_CHANNEL  -outputBlock ./genesis.block


# Generate channel configuration block
configtxgen -profile BasicChannel -configPath . -outputCreateChannelTx ./mychannel.tx -channelID $CHANNEL_NAME

echo "#######    Generating anchor peer update for Org1MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP

echo "#######    Generating anchor peer update for Org2MSP  ##########"
configtxgen -profile BasicChannel -configPath . -outputAnchorPeersUpdate ./Org2MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org2MSP

# --------------------------------------------------
# Channel2
# Generate channel configuration block
configtxgen -profile BasicChannel2 -configPath . -outputCreateChannelTx ./mychannel2.tx -channelID $CHANNEL_NAME2

echo "#######    Generating anchor peer update for Org1MSP  ##########"
configtxgen -profile BasicChannel2 -configPath . -outputAnchorPeersUpdate ./Org1MSPanchors2.tx -channelID $CHANNEL_NAME2 -asOrg Org1MSP


echo "#######    Generating anchor peer update for Org3MSP  ##########"
configtxgen -profile BasicChannel2 -configPath . -outputAnchorPeersUpdate ./Org3MSPanchors2.tx -channelID $CHANNEL_NAME2 -asOrg Org3MSP

# ---------------------------------------
# Channel3
# Generate channel configuration block
configtxgen -profile BasicChannel3 -configPath . -outputCreateChannelTx ./mychannel3.tx -channelID $CHANNEL_NAME3

echo "#######    Generating anchor peer update for Org1MSP  ##########"
configtxgen -profile BasicChannel3 -configPath . -outputAnchorPeersUpdate ./Org1MSPanchors3.tx -channelID $CHANNEL_NAME3 -asOrg Org1MSP

echo "#######    Generating anchor peer update for Org4MSP  ##########"
configtxgen -profile BasicChannel3 -configPath . -outputAnchorPeersUpdate ./Org4MSPanchors3.tx -channelID $CHANNEL_NAME3 -asOrg Org4MSP

# -----------------------------------------
# ---------------------------------------
# Channel4
# Generate channel configuration block
configtxgen -profile BasicChannel4 -configPath . -outputCreateChannelTx ./mychannel4.tx -channelID $CHANNEL_NAME4

echo "#######    Generating anchor peer update for Org1MSP  ##########"
configtxgen -profile BasicChannel4 -configPath . -outputAnchorPeersUpdate ./Org1MSPanchors4.tx -channelID $CHANNEL_NAME4 -asOrg Org1MSP

echo "#######    Generating anchor peer update for Org5MSP  ##########"
configtxgen -profile BasicChannel4 -configPath . -outputAnchorPeersUpdate ./Org5MSPanchors4.tx -channelID $CHANNEL_NAME4 -asOrg Org5MSP

# -----------------------------------------