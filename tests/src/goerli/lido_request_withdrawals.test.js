import { processTest, populateTransaction } from "../test.fixture";

const contractName = "OssifiableProxy"; // <= Name of the smart contract

const testLabel = "goerli_request_withdrawals_method"; // <= Name of the test
const testDirSuffix = "request_withdrawals_method"; // <= directory to compare device snapshots to
const testNetwork = "goerli";
const signedPlugin = false;

const contractAddr = "0xcf117961421ca9e546cd7f50bc73abcdb3039533"; // <= Address of the smart contract
const chainID = 1;

// From : https://goerli.etherscan.io/tx/0xc0aa45706b49ff5eb86ad62fe58a7d0274211c02df111037ad7e4a82dcf28e86
const inputData =
  "0xd66810420000000000000000000000000000000000000000000000000000000000000040000000000000000000000000ad79579eecef31f4719426232d7b527b17b84f85000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000001617eb90b26c000";
// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID);
const devices = [
  {
    name: "nanos",
    label: "Nano S",
    steps: 7, // <= Define the number of steps for this test case and this device
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
