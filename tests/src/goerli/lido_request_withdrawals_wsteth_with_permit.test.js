import { processTest, populateTransaction } from "../test.fixture";

const contractName = "OssifiableProxy"; // <= Name of the smart contract

const testLabel = "goerli_request_withdrawals_wsteth_with_permit_method"; // <= Name of the test
const testDirSuffix = "request_withdrawals_wsteth_with_permit_method"; // <= directory to compare device snapshots to
const testNetwork = "goerli";
const signedPlugin = false;

const contractAddr = "0xcf117961421ca9e546cd7f50bc73abcdb3039533"; // <= Address of the smart contract
const chainID = 1;

// From : https://goerli.etherscan.io/tx/0xe34b52441efa82887c87641316cae369567f74d5689710bc5f5123ab8e92ba9e
const inputData =
  "0x7951b76f00000000000000000000000000000000000000000000000000000000000000e0000000000000000000000000af5fc17575c6903ccdb7b5e7f8fdcfe8a5431f10000000000000000000000000000000000000000000000000002386f26fc10000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000001cc2c70bd3f2f89bf24b6c4103f4d191c6bfb88a47d002ae379dc9e01c3018cc35329e0a14083de11090947780d767a1b1ec076720cd6fcb50f258169a1587d1a10000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000002386f26fc10000";
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
