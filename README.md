# reliability-poc





Network Topology

Org1 - Insurence
Org2 - Oppolo Group
Org3 - Sunrise
Org4 - Nobel Hospital
Org5 - Aster
Org6
Org7
1 Orderer org


channel1 - [1,2] - contract1
channel2 - [1,3] - contract2
channel3 - [1,4] - contract3
channel3 - [1,5] - contract4
channel5 - [2,6,7] - contract5



Create CA
Create Certificates
Create Artifacts
---------------------
Create All Services
Create Channels 1,2,3,4,
Deploy Chainocde 1,2,3,4
Invoke Tx

------------------------------------------------------------------------

Criteria
1) Machine Configuration: 16GB , 50GB SSD, 4 cors
    1) Check Performance for 4 channel
        1) Policy (AND - OR)
        2) Block Time and Size

2) Machine Configuration 8GB, 50GB, 2 core
     1) Check Performance for 4 channel
        1) Policy (AND - OR)
        2) Block Time and Size
Create All Services
Create Channels 1,2,3,4,5
Deploy Chainocde 1,2,3,4,5
Invoke Tx
