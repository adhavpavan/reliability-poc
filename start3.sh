

docker-compose -f ./artifacts/channel/create-certificate-with-ca/docker-compose.yaml up -d

docker-compose -f ./artifacts/docker-compose.yaml up -d

sleep 3

./createChannel3.sh 

./deployChaincode3.sh