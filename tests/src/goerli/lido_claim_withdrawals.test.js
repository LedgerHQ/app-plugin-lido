import { processTest, populateTransaction } from "../test.fixture";

const contractName = "OssifiableProxy"; // <= Name of the smart contract

const testLabel = "goerli_claim_withdrawals_method"; // <= Name of the test
const testDirSuffix = "claim_withdrawals_method"; // <= directory to compare device snapshots to
const testNetwork = "goerli";
const signedPlugin = false;

const contractAddr = "0xcf117961421ca9e546cd7f50bc73abcdb3039533"; // <= Address of the smart contract
const chainID = 1;

// From : https://goerli.etherscan.io/tx/0x185544ade172813f84b903656d4e207da7abfed68ba4efc0f940541eeb472565
const inputData =
  "0xe3afe0a300000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000002a200000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000072";
// Create serializedTx and remove the "0x" prefix
const serializedTx = populateTransaction(contractAddr, inputData, chainID);
const devices = [
  {
    name: "nanos",
    label: "Nano S",
    steps: 4, // <= Define the number of steps for this test case and this device
  },
  {
    name: "nanox",
    label: "Nano X",
    steps: 4, // <= Define the number of steps for this test case and this device
  },
  {
    name: "nanosp",
    label: "Nano S+",
    steps: 4, // <= Define the number of steps for this test case and this device
  },
];

devices.forEach((device) =>
  processTest(device, contractName, testLabel, testDirSuffix, "", signedPlugin, serializedTx, testNetwork)
);
