'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

const {nanoid} = require('nanoid')



const colors = ['blue', 'red', 'green', 'yellow', 'black', 'purple', 'white', 'violet', 'indigo', 'brown'];
const makes = ['Toyota', 'Ford', 'Hyundai', 'Volkswagen', 'Tesla', 'Peugeot', 'Chery', 'Fiat', 'Tata', 'Holden'];
const models = ['Prius', 'Mustang', 'Tucson', 'Passat', 'S', '205', 'S22L', 'Punto', 'Nano', 'Barina'];
const owners = ['Tomoko', 'Brad', 'Jin Soo', 'Max', 'Adrianna', 'Michel', 'Aarav', 'Pari', 'Valeria', 'Shotaro'];

/**
 * Workload module for the benchmark round.
 */
class CreateCarWorkload extends WorkloadModuleBase {
    /**
     * Initializes the workload module instance.
     */
    constructor() {
        super();
        this.txIndex = 7000;
    }

    /**
     * Assemble TXs for the round.
     * @return {Promise<TxStatus[]>}
     */
    async submitTransaction() {
        this.txIndex++;
        // let carNumber = 'Client' + this.workerIndex + '_CAR' + this.txIndex.toString();
        // let carColor = colors[Math.floor(Math.random() * colors.length)];
        // let carMake = makes[Math.floor(Math.random() * makes.length)];
        // let carModel = models[Math.floor(Math.random() * models.length)];
        // let carOwner = owners[Math.floor(Math.random() * owners.length)];


        let data = {
            id: 'c'+nanoid(),
            make: makes[Math.floor(Math.random() * makes.length)],
            addedAt: + new Date(),
            model: models[Math.floor(Math.random() * models.length)],
            color: colors[Math.floor(Math.random() * colors.length)],
            owner: owners[Math.floor(Math.random() * owners.length)]
        }

        let args = {
            contractId: 'fabcar',
            contractVersion: 'v1',
            contractFunction: 'createCar',
            contractArguments: [JSON.stringify(data)],
            timeout: 30
        };

        await this.sutAdapter.sendRequests(args);
    }
}

/**
 * Create a new instance of the workload module.
 * @return {WorkloadModuleInterface}
 */
function createWorkloadModule() {
    return new CreateCarWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;