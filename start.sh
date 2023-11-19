

docker-compose -f ./artifacts/channel/create-certificate-with-ca/docker-compose.yaml up -d

docker-compose -f ./artifacts/docker-compose.yaml up -d

sleep 3

./createChannel.sh && ./deployChaincode.sh 
./createChannel2.sh && ./deployChaincode2.sh 
./createChannel3.sh && ./deployChaincode3.sh 
./createChannel4.sh && ./deployChaincode4.sh 