import { processTest, populateTransaction } from "../test.fixture";

const contractName = "OssifiableProxy"; // <= Name of the smart contract

const testLabel = "ethereum_request_withdrawals_wsteth_method"; // <= Name of the test
const testDirSuffix = "request_withdrawals_wsteth_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0xcf117961421ca9e546cd7f50bc73abcdb3039533"; // <= Address of the smart contract
const chainID = 1;

// From : https://goerli.etherscan.io/tx/0xed441dfe79cd05758fe8c4d9e479bd8662702ca16bdfe41b6016ce9880d14987
const inputData =
  "0x19aa62570000000000000000000000000000000000000000000000000000000000000040000000000000000000000000ad79579eecef31f4719426232d7b527b17b84f85000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000005af3107a4000";
// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID);
const devices = [
  {
    name: "nanos",
    label: "Nano S",
    steps: 8, // <= Define the number of steps for this test case and this device
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