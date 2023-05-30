# Badges

[![Code style check](https://github.com/blooo-io/LedgerHQ-app-plugin-lido/actions/workflows/lint-workflow.yml/badge.svg)](https://github.com/blooo-io/LedgerHQ-app-plugin-lido/actions/workflows/lint-workflow.yml)
[![Compilation & tests](https://github.com/blooo-io/LedgerHQ-app-plugin-lido/actions/workflows/ci-workflow.yml/badge.svg)](https://github.com/blooo-io/LedgerHQ-app-plugin-lido/actions/workflows/ci-workflow.yml)

# Ledger Lido Plugin

This is a plugin for the Ethereum application which helps parsing and displaying relevant information when signing a Lido transaction.

## Prerequisite

Clone the plugin to a new folder.

```shell
git clone --recurse-submodules https://github.com/blooo-io/LedgerHQ-app-plugin-lido.git
```

Then in the same folder clone two more repositories, which is the plugin-tools and app-ethereum.

```shell
git clone https://github.com/LedgerHQ/plugin-tools.git                          #plugin-tools
git clone --recurse-submodules https://github.com/LedgerHQ/app-ethereum.git     #app-ethereum
```

## Documentation

Need more information about the interface, the architecture, or general stuff about ethereum plugins? You can find more about them in the [ethereum-app documentation](https://github.com/LedgerHQ/app-ethereum/blob/master/doc/ethapp_plugins.asc).

## Smart Contracts

Smart contracts covered by this plugin are:

| Network  | Version | Smart Contract                               |
| -------- | ------- | -------------------------------------------- |
| Goerli   | V8      | `0xCF117961421cA9e546cD7f50bC73abCdB3039533` |
| Ethereum | V4      | `0xae7ab96520de3a18e5e111b5eaab095312d7fe84` |
| Ethereum | V6      | `0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0` |

On these smart contracts, the functions covered by this plugin are:

| Function                               | Selector   | Displayed Parameters                                                                                                                |
| -------------------------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| Claim Withdrawals                      | 0xe3afe0a3 | <code>uint256[] \_requestIds</code>                                                                                                 |
| Request Withdrawals                    | 0xd6681042 | <table> <tbody> <tr><td><code>address \_owner</code></td></tr> <tr><td><code>uint256[] \_amounts</code></td></tr> </tbody> </table> |
| Request Withdrawals wstETH             | 0x19aa6257 | <table> <tbody> <tr><td><code>address \_owner</code></td></tr> <tr><td><code>uint256[] \_amounts</code></td></tr> </tbody> </table> |
| Request Withdrawals With Permit        | 0xacf41e4d | <table> <tbody> <tr><td><code>address \_owner</code></td></tr> <tr><td><code>uint256[] \_amounts</code></td></tr> </tbody> </table> |
| Request Withdrawals wstETH With Permit | 0x7951b76f | <table> <tbody> <tr><td><code>address \_owner</code></td></tr> <tr><td><code>uint256[] \_amounts</code></td></tr> </tbody> </table> |
| Submit                                 | 0xa1903eab | <code>uint256 \_Amount</code>                                                                                                       |
| Wrap                                   | 0xea598cb0 | <code>uint256[] \_wstETHAmount</code>                                                                                               |
| Unwrap                                 | 0xde0e9a3e | <code>uint256[] \_wstETHAmount</code>                                                                                               |

## Build

Go to the plugin-tools folder and run the "./start" script.

```shell
cd plugin-tools  # go to plugin folder
./start.sh       # run the script start.sh
```

The script will build a docker image and attach a console.
When the docker image is running go to the "LedgerHQ-app-plugin-lido" folder and build the ".elf" files.

```shell
cd LedgerHQ-app-plugin-lido/tests       # go to the tests folder in LedgerHQ-app-plugin-lido
./build_local_test_elfs.sh              # run the script build_local_test_elfs.sh
```

## Tests

To test the plugin go to the tests folder from the "LedgerHQ-app-plugin-lido" and run the script "test"
Make sure both sdk submodule commit match in your plugin folder & on app-ethereum folder !

```shell
cd LedgerHQ-app-plugin-lido/tests       # go to the tests folder in LedgerHQ-app-plugin-lido
docker pull zondax/builder-zemu@sha256:8d7b06cedf2d018b9464f4af4b7a8357c3fbb180f3ab153f8cb8f138defb22a4 
yarn install                    # install packages
yarn test                       # run the script test
```

## Continuous Integration

The flow processed in [GitHub Actions](https://github.com/features/actions) is the following:

- Code formatting with [clang-format](http://clang.llvm.org/docs/ClangFormat.html)
- Compilation of the application for Ledger Nano S in [ledger-app-builder](https://github.com/LedgerHQ/ledger-app-builder)
