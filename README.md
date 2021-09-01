# app-plugin-lido

Lightweight plugin that goes hand-in-hand with the [ethereum app](https://github.com/LedgerHQ/app-ethereum).
This plugin provides support for the following contracts:

[wstETH](https://etherscan.io/address/0x7f39c581f595b53c5cb19bd0b3f8da6c935e2ca0) for wrapping and unwrapping wsteth.
[stETH](https://etherscan.io/address/0xae7ab96520de3a18e5e111b5eaab095312d7fe84) for staking ETH.

## Running tests

First [install yarn](https://classic.yarnpkg.com/en/docs/install/#debian-stable).
Then, install js dependancies:
```
cd tests
yarn install
```

Then you can run the tests with:
```
yarn test
```

### Building test elfs
By default, tests are run against precompiled binaries located in `tests/elfs`.
If you want to run the test suite against your changes in the plugin codebase (or against changes in your app-ethereum repository), there is a helper script to rebuild the elfs required by tests and to move them at the right place with the right name.
Open `tests/build_local_test_elfs.sh` and add your BOLOS SDKs path to `NANOS_SDK` and `NANOX_SDK`, and the path to the ethereum repo you would like to use to `APP_ETHEREUM`.
Then, run it from within the `tests` folder:
```
cd test
./build_local_test_elfs.sh
```

You can then run the tests normaly with:
```
yarn test
```