import { processTest, populateTransaction } from "../test.fixture";

const contractName = "Lido"; // <= Name of the smart contract

const testLabel = "ethereum_wrap_method"; // <= Name of the test
const testDirSuffix = "wrap_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0"; // <= Address of the smart contract
const chainID = 1;

// From : https://etherscan.io/tx/0x288e20d9ac7abf722adbe779e41c2ac3fd5770ebd52d1d95057f3dca6d5d741b
const inputData = "0xea598cb00000000000000000000000000000000000000000000000021a1d7aa425b0753e";
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
