

docker-compose -f ./artifacts/channel/create-certificate-with-ca/docker-compose.yaml up -d

docker-compose -f ./artifacts/docker-compose.yaml up -d

sleep 3

./createChannel.sh && ./createChannel2.sh && ./createChannel3.sh && ./createChannel4.sh 

./deployChaincode.sh && ./deployChaincode2.sh && ./deployChaincode3.sh && ./deployChaincode4.sh 