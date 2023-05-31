import { processTest, populateTransaction } from "../test.fixture";

const contractName = "OssifiableProxy"; // <= Name of the smart contract

const testLabel = "goerli_claim_withdrawals_two_method"; // <= Name of the test
const testDirSuffix = "claim_withdrawals_two_method"; // <= directory to compare device snapshots to
const testNetwork = "goerli";
const signedPlugin = false;

const contractAddr = "0xcf117961421ca9e546cd7f50bc73abcdb3039533"; // <= Address of the smart contract
const chainID = 1;

// From : https://goerli.etherscan.io/tx/0xa2454ab7622b4b2ae3c06ef6f290fe93354bb1ad78ad13b941f40fb656d66813
const inputData =
  "0xe3afe0a3000000000000000000000000000000000000000000000000000000000000004000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000041a000000000000000000000000000000000000000000000000000000000000041b000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000850000000000000000000000000000000000000000000000000000000000000085";
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
