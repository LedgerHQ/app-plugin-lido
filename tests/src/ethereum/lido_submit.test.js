import { processTest, populateTransaction } from "../test.fixture";

const contractName = "Lido"; // <= Name of the smart contract

const testLabel = "ethereum_claim_submit_method"; // <= Name of the test
const testDirSuffix = "claim_submit_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0xae7ab96520de3a18e5e111b5eaab095312d7fe84"; // <= Address of the smart contract
const chainID = 1;

// From : https://etherscan.io/tx/0x867f8421dd3eafa445e0d07489263f4205d8c315e0b71cbcf95affe10b75c63d
const inputData = "0xa1903eab0000000000000000000000006dc9657c2d90d57cadffb64239242d06e6103e43";
// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID);
const devices = [
  {
    name: "nanos",
    label: "Nano S",
    steps: 5, // <= Define the number of steps for this test case and this device
  },
  {
    name: "nanox",
    label: "Nano X",
    steps: 5, // <= Define the number of steps for this test case and this device
  },
  {
    name: "nanosp",
    label: "Nano S+",
    steps: 5, // <= Define the number of steps for this test case and this device
  },
];

devices.forEach((device) =>
  processTest(device, contractName, testLabel, testDirSuffix, "", signedPlugin, serializedTx, testNetwork)
);
