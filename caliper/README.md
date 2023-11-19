# ContainerisingCaliperForFabricBenchmark

1) npm install -g --only=prod @hyperledger/caliper-cli@0.3.1
2) caliper bind --caliper-bind-sut fabric:1.4.4 --caliper-bind-args=-g
3) caliper launch master --caliper-workspace ./ --caliper-benchconfig ./benchmarks/scenario/simple/pavan/config.yaml --caliper-networkconfig ./networks/fabric/pavan/network-config_1.4.yaml





caliper launch master \
--caliper-benchconfig benchmarks/samples/fabric/marbles/config.yaml \
--caliper-networkconfig networks/fabric/fabric-v1.4.1/2org1peergoleveldb/fabric-go.yaml \
--caliper-workspace <path_to_caliper_benchmarks_root_directory>





Criteria
1) Machine Configuration: 16GB , 50GB SSD, 4 cors(e2-standard-4)
    1) Check Performance for 4 channel
        1) Policy (AND - OR)
        2) Block Time and Size

2) MAchine Configuration 8GB, 50GB, 2 core
     1) Check Performance for 4 channel
        1) Policy (AND - OR)
        2) Block Time and Size