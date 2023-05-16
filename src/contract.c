#include "lido_plugin.h"

// Need more information about the interface for plugins? Please read the README.md!

// Lido contract
// function submit(address _referral) returns (uint256)
static const uint8_t LIDO_SUBMIT_SELECTOR[SELECTOR_SIZE] = {0xa1, 0x90, 0x3e, 0xab};

// wstETH contract
// function wrap(uint256 _stETHAmount) returns (uint256)
static const uint8_t LIDO_WRAP_STETH_SELECTOR[SELECTOR_SIZE] = {0xea, 0x59, 0x8c, 0xb0};
// function unwrap(uint256 _wstETHAmount) returns (uint256)
static const uint8_t LIDO_UNWRAP_WSTETH_SELECTOR[SELECTOR_SIZE] = {0xde, 0x0e, 0x9a, 0x3e};

// Function: requestWithdrawalsWithPermit(uint256[] _amounts,address _owner,tuple _permit)
// exemple : https://goerli.etherscan.io/tx/0x1e3c618b0ec519dbafff8e00758e83de9b0c3c9f067e1b441886ba5fc828213c
static const uint8_t LIDO_REQUEST_WITHDRAWALS_WITH_PERMIT_SELECTOR[SELECTOR_SIZE] = {0xac, 0xf4, 0x1e, 0x4d};


// Array of all the different lido selectors.
const uint8_t *const LIDO_SELECTORS[NUM_LIDO_SELECTORS] = {
    LIDO_SUBMIT_SELECTOR,
    LIDO_WRAP_STETH_SELECTOR,
    LIDO_UNWRAP_WSTETH_SELECTOR,
    LIDO_REQUEST_WITHDRAWALS_WITH_PERMIT_SELECTOR,
};
