import { processTest, populateTransaction } from "../test.fixture";

const contractName = "Lido"; // <= Name of the smart contract

const testLabel = "ethereum_unwrap_method"; // <= Name of the test
const testDirSuffix = "unwrap_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0"; // <= Address of the smart contract
const chainID = 1;

// From : https://etherscan.io/tx/0x400d0f4fd77ae905b082b6ed6ae4690eff431c7bd5e46e10bdaa2ec341920c6e
const inputData = "0xde0e9a3e0000000000000000000000000000000000000000000000000c57cb754df12c19";
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
