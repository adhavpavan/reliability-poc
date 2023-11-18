

docker-compose -f ./artifacts/channel/create-certificate-with-ca/docker-compose.yaml up -d

docker-compose -f ./artifacts/docker-compose.yaml up -d

sleep 3

./createChannel2.sh 

./deployChaincode2.sh 