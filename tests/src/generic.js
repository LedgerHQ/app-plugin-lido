const sim_options_nanos = {
  model: "nanos",
  logging: true,
  start_delay: 2000,
  X11: true,
  custom: "",
};

const sim_options_nanox = {
  model: "nanox",
  logging: true,
  start_delay: 2000,
  X11: true,
  custom: "",
};

const Resolve = require("path").resolve;
const NANOS_ETH_ELF_PATH = Resolve("elfs/ethereum_nanos.elf");
const NANOX_ETH_ELF_PATH = Resolve("elfs/ethereum_nanox.elf");
const NANOS_LIDO_LIB = { Lido: Resolve("elfs/lido_nanos.elf") };
const NANOX_LIDO_LIB = { Lido: Resolve("elfs/lido_nanox.elf") };

const TIMEOUT = 1000000;

module.exports = {
    NANOS_ETH_ELF_PATH,
    NANOX_ETH_ELF_PATH,
    NANOS_LIDO_LIB,
    NANOX_LIDO_LIB,
    sim_options_nanos,
    sim_options_nanox,
    TIMEOUT,
}