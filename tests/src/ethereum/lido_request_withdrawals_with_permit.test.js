import { processTest, populateTransaction } from "../test.fixture";

const contractName = "stETH"; // <= Name of the smart contract

const testLabel = "ethereum_request_withdrawals_with_permit_method"; // <= Name of the test
const testDirSuffix = "request_withdrawals_with_permit_method"; // <= directory to compare device snapshots to
const testNetwork = "ethereum";
const signedPlugin = false;

const contractAddr = "0x077b60752864b3e5291863cf8890603f9ab335d3"; // <= Address of the smart contract
const chainID = 1;

// From : https://goerli.etherscan.io/tx/0x1e3c618b0ec519dbafff8e00758e83de9b0c3c9f067e1b441886ba5fc828213c
const inputData =
  "0xacf41e4d00000000000000000000000000000000000000000000000000000000000000e0000000000000000000000000d8720b92d8a9e4ee8a39477e3b3883c542996bbf0000000000000000000000000000000000000000000000000027147114878000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000001b24ff1c4174b0208527492f269428db160f51157fb03587915a9535a3691c8efc1e275d4b0881b7020d32bca1b6f2a9b6dcee0c5cc8d320af1a372f2e0feb58a100000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000027147114878000";
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
