import fs from "fs";

const sim_options_nanos = {
  model: "nanos",
  logging: true,
  X11: false,
  startDelay: 15000,
  startText: "Ready",
  approveKeyword: "APPROVE",
  rejectKeyword: "REJECT",
  custom: "",
  caseSensitive: false,
  sdk: "",
};

const sim_options_nanox = {
  model: "nanox",
  logging: true,
  X11: false,
  startDelay: 15000,
  startText: "Ready",
  approveKeyword: "APPROVE",
  rejectKeyword: "REJECT",
  custom: "",
  caseSensitive: false,
  sdk: "",
};

const Resolve = require("path").resolve;
const NANOS_ETH_ELF_PATH = Resolve("elfs/ethereum_nanos.elf");
const NANOX_ETH_ELF_PATH = Resolve("elfs/ethereum_nanox.elf");
const NANOS_LIDO_LIB = { lido: Resolve("elfs/lido_nanos.elf") };
const NANOX_LIDO_LIB = { lido: Resolve("elfs/lido_nanox.elf") };

const TIMEOUT = 1000000;

const getTmpPath = (testName) => {
  let date = new Date();
  let tmpPath = `snapshots/tmp/${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}@${testName}/`;
  fs.mkdir(tmpPath, { recursive: true }, (err) => {
    if (err) {
      console.log("couldn't create tmp folder at path: " + tmpPath);
    }
  });
  return tmpPath;
};

module.exports = {
  NANOS_ETH_ELF_PATH,
  NANOX_ETH_ELF_PATH,
  NANOS_LIDO_LIB,
  NANOX_LIDO_LIB,
  sim_options_nanos,
  sim_options_nanox,
  TIMEOUT,
  getTmpPath,
};
