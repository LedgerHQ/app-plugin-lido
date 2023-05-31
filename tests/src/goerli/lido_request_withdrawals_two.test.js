import { processTest, populateTransaction } from "../test.fixture";

const contractName = "OssifiableProxy"; // <= Name of the smart contract

const testLabel = "goerli_request_withdrawals_two_method"; // <= Name of the test
const testDirSuffix = "request_withdrawals_two_method"; // <= directory to compare device snapshots to
const testNetwork = "goerli";
const signedPlugin = false;

const contractAddr = "0xcf117961421ca9e546cd7f50bc73abcdb3039533"; // <= Address of the smart contract
const chainID = 1;

// MethodID: 0xd6681042
// [0]:  0000000000000000000000000000000000000000000000000000000000000040
// [1]:  000000000000000000000000ad79579eecef31f4719426232d7b527b17b84f85
// [2]:  0000000000000000000000000000000000000000000000000000000000000002
// [3]:  00000000000000000000000000000000000000000000000001617eb90b26c000
// [4]:  0000000000000000000000000000000000000000000000000e4158f529480000
const inputData =
  "0xd66810420000000000000000000000000000000000000000000000000000000000000040000000000000000000000000ad79579eecef31f4719426232d7b527b17b84f85000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000001617eb90b26c0000000000000000000000000000000000000000000000000000e4158f529480000";
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
    steps: 6, // <= Define the number of steps for this test case and this device
  },
  {
    name: "nanosp",
    label: "Nano S+",
    steps: 6, // <= Define the number of steps for this test case and this device
  },
];

devices.forEach((device) =>
  processTest(device, contractName, testLabel, testDirSuffix, "", signedPlugin, serializedTx, testNetwork)
);
