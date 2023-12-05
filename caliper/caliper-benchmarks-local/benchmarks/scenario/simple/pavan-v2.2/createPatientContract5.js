'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

const { nanoid } = require('nanoid')
let IdArray5 = [];

const departments = ["Xray","BloodCheck","Consultation","MRI","Inpatient","Outpatient"];
const ages = [23,29,22,34,21,11,24,5,32,34,54,43,22,23,24,25,65,61,62];
const names = ["Tomoko","Bradd","Jin","Max","Adriana","Michel"];
const phoneNumbers = ["9999999999","9999449999", "9999999555", "9999999991","2999999999", "6599999999", "4499999999","5599999999", "6699999999", "7699999999"];
const addresses = ["Dubai", "Delhi", "Banglore", "Mumbai", "Kolkata", "Tokyo"]
const billAmounts = [234,2345,35,4456,456,36,234,467,567,678,678,678,476,456,456,346345,345,3454]

// id string, department string, address string, name string, age int, phoneNumber string
/**
 * Workload module for the benchmark round.
 */
class CreatePatientWorkload extends WorkloadModuleBase {
  /**
   * Initializes the workload module instance.
   */
  constructor() {
    super();
    // this.txIndex = 7000;
  }

  /**
   * Assemble TXs for the round.
   * @return {Promise<TxStatus[]>}
   */
  async submitTransaction() {
    // this.txIndex++;
    let id = 'c' + nanoid();
    let department = departments[Math.floor(Math.random() * departments.length)]
    let address =  addresses[Math.floor(Math.random() * addresses.length)]
    let name = names[Math.floor(Math.random() * names.length)]
    let age = ages[Math.floor(Math.random() * ages.length)]
    let phoneNumber = phoneNumbers[Math.floor(Math.random() * phoneNumbers.length)]
    let billAmount = billAmounts[Math.floor(Math.random() * billAmounts.length)]

    IdArray5.push(id)
    let args = {
      contractId: 'contract5',
      contractVersion: 'v1',
      contractFunction: 'CreateAsset',
      contractArguments: [id, department, address, name, age, phoneNumber, billAmount],
      channel: 'mychannel5',
      invokerIdentity: 'client0.org2.example.com',
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
  return new CreatePatientWorkload();
}

module.exports ={
  createWorkloadModule,
  IdArray5
}