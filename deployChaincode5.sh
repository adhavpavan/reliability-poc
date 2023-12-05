export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/artifacts/channel/crypto-config/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem
export PEER0_ORG2_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
export PEER0_ORG6_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/org6.example.com/peers/peer0.org6.example.com/tls/ca.crt
export PEER0_ORG7_CA=${PWD}/artifacts/channel/crypto-config/peerOrganizations/org7.example.com/peers/peer0.org7.example.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/artifacts/channel/config/

export CHANNEL_NAME=mychannel5


setGlobalsForPeer0Org2(){
    export CORE_PEER_LOCALMSPID="Org2MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
    export CORE_PEER_ADDRESS=localhost:9051
    
}

setGlobalsForPeer0Org6(){
    export CORE_PEER_LOCALMSPID="Org6MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG6_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/org6.example.com/users/Admin@org6.example.com/msp
    export CORE_PEER_ADDRESS=localhost:14051
}

setGlobalsForPeer0Org7(){
    export CORE_PEER_LOCALMSPID="Org7MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG7_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/artifacts/channel/crypto-config/peerOrganizations/org7.example.com/users/Admin@org7.example.com/msp
    export CORE_PEER_ADDRESS=localhost:15051
}



presetup() {
    echo Vendoring Go dependencies ...
    pushd ./artifacts/src/github.com/patient
    GO111MODULE=on go mod vendor
    popd
    echo Finished vendoring Go dependencies
}
# presetup

CHANNEL_NAME="mychannel5"
CC_RUNTIME_LANGUAGE="golang"
VERSION="1"
SEQUENCE="1"
CC_SRC_PATH="./artifacts/src/github.com/patient"
CC_NAME="contract5"
CC_POLICY="OR('Org2MSP.member','Org6MSP.member','Org7MSP.member')" 

packageChaincode() {
    rm -rf ${CC_NAME}.tar.gz
    setGlobalsForPeer0Org2
    peer lifecycle chaincode package ${CC_NAME}.tar.gz \
        --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} \
        --label ${CC_NAME}_${VERSION}
    echo "===================== Chaincode is packaged ===================== "
}
# packageChaincode

installChaincode() {
    setGlobalsForPeer0Org2
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.org1 ===================== "

    setGlobalsForPeer0Org6
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.org5 ===================== "

    setGlobalsForPeer0Org7
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.org5 ===================== "
}

# installChaincode

queryInstalled() {
    setGlobalsForPeer0Org2
    peer lifecycle chaincode queryinstalled >&log.txt
    cat log.txt
    PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo PackageID is ${PACKAGE_ID}
    echo "===================== Query installed successful on peer0.org1 on channel ===================== "
}

# queryInstalled

# --collections-config ./artifacts/private-data/collections_config.json \
#         --signature-policy "OR('Org1MSP.member','Org2MSP.member')" \

approveForMyOrg2() {
    setGlobalsForPeer0Org2
    set -x
    peer lifecycle chaincode approveformyorg -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com --tls \
        --signature-policy ${CC_POLICY} \
        --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${VERSION} \
        --package-id ${PACKAGE_ID} \
        --sequence ${SEQUENCE}
    set +x

    echo "===================== chaincode approved from org 1 ===================== "

}
# queryInstalled
# approveForMyOrg1


approveForMyOrg6() {
    setGlobalsForPeer0Org6
    set -x
    peer lifecycle chaincode approveformyorg -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com --tls \
        --signature-policy ${CC_POLICY} \
        --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${VERSION} \
        --package-id ${PACKAGE_ID} \
        --sequence ${SEQUENCE}
    set +x
    echo "===================== chaincode approved from org 5 ===================== "
}

# queryInstalled
# approveForMyOrg3

approveForMyOrg7() {
    setGlobalsForPeer0Org7
    set -x
    peer lifecycle chaincode approveformyorg -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com --tls \
        --signature-policy ${CC_POLICY} \
        --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} --version ${VERSION} \
        --package-id ${PACKAGE_ID} \
        --sequence ${SEQUENCE}
    set +x
    echo "===================== chaincode approved from org 5 ===================== "
}


# checkCommitReadyness

commitChaincodeDefination() {
    setGlobalsForPeer0Org2
    peer lifecycle chaincode commit -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA \
        --signature-policy ${CC_POLICY} \
        --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA \
        --peerAddresses localhost:14051 --tlsRootCertFiles $PEER0_ORG6_CA \
        --version ${VERSION} --sequence ${SEQUENCE}

        
}

# commitChaincodeDefination

queryCommitted() {
    setGlobalsForPeer0Org2
    peer lifecycle chaincode querycommitted --channelID $CHANNEL_NAME --name ${CC_NAME}

}

# queryCommitted

chaincodeInvoke() {
    setGlobalsForPeer0Org2
# id string, department string, amount int, patient string, appraisedValue int

    # Create Patient
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA \
        -C $CHANNEL_NAME -n ${CC_NAME}  \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA \
        --peerAddresses localhost:14051 --tlsRootCertFiles $PEER0_ORG6_CA \
        -c '{"function": "CreateAsset","Args":["123", "department1", "test address","Patient 1", 22, "8888888888"]}'

}


chaincodeInvoke1() {
    setGlobalsForPeer0Org2
    # Create Patient
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA \
        -C $CHANNEL_NAME -n ${CC_NAME}  \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA \
        --peerAddresses localhost:14051 --tlsRootCertFiles $PEER0_ORG6_CA \
        -c '{"function": "CreateData","Args":["3","{\"id\":\"3\",\"department\":\"department1\",\"age\":22,\"address\":\"test address\", \"name\":\"patient1\", \"phoneNumber\":\"8888888888\", \"billAmount\":222}"]}'

}

testABAC() {
    setGlobalsForPeer0Org2
    # Create Patient
    peer chaincode invoke -o localhost:7050 \
        --ordererTLSHostnameOverride orderer.example.com \
        --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA \
        -C $CHANNEL_NAME -n ${CC_NAME}  \
        --peerAddresses localhost:9051 --tlsRootCertFiles $PEER0_ORG2_CA \
        --peerAddresses localhost:14051 --tlsRootCertFiles $PEER0_ORG6_CA \
        -c '{"function": "ABACTest","Args":["P-123","{\"id\":\"3\",\"department\":\"department1\",\"age\":22,\"address\":\"test address\", \"name\":\"patient1\", \"phoneNumber\":\"8888888888\",  \"billAmount\":222}"]}'

}

# testABAC

# chaincodeInvoke

chaincodeQuery() {
    setGlobalsForPeer0Org2
    peer chaincode query -C $CHANNEL_NAME -n ${CC_NAME} -c '{"function": "ReadAsset","Args":["3"]}'
}

# chaincodeQuery

# Run this function if you add any new dependency in chaincode
presetup

packageChaincode
installChaincode
queryInstalled
approveForMyOrg2
approveForMyOrg6
approveForMyOrg7
commitChaincodeDefination
queryCommitted
sleep 5
chaincodeInvoke
chaincodeInvoke1
sleep 3
chaincodeQuery
