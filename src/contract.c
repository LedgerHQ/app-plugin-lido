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
// https://goerli.etherscan.io/tx/0x1e3c618b0ec519dbafff8e00758e83de9b0c3c9f067e1b441886ba5fc828213c
static const uint8_t LIDO_REQUEST_WITHDRAWALS_WITH_PERMIT_SELECTOR[SELECTOR_SIZE] = {0xac,
                                                                                     0xf4,
                                                                                     0x1e,
                                                                                     0x4d};

// Function: requestWithdrawalsWstETHWithPermit(uint256[] _amounts,address _owner,tuple _permit)
// https://goerli.etherscan.io/tx/0xe34b52441efa82887c87641316cae369567f74d5689710bc5f5123ab8e92ba9e
static const uint8_t LIDO_REQUEST_WITHDRAWALS_WSTETH_WITH_PERMIT_SELECTOR[SELECTOR_SIZE] = {0x79,
                                                                                            0x51,
                                                                                            0xb7,
                                                                                            0x6f};

// Function: claimWithdrawals(uint256[] _requestIds,uint256[] _hints)
// https://goerli.etherscan.io/tx/0x185544ade172813f84b903656d4e207da7abfed68ba4efc0f940541eeb472565
static const uint8_t LIDO_CLAIM_WITHDRAWALS_SELECTOR[SELECTOR_SIZE] = {0xe3, 0xaf, 0xe0, 0xa3};

// Function: requestWithdrawals(uint256[] _amounts,address _owner)
// https://goerli.etherscan.io/tx/0xc0aa45706b49ff5eb86ad62fe58a7d0274211c02df111037ad7e4a82dcf28e86
static const uint8_t LIDO_REQUEST_WITHDRAWALS_SELECTOR[SELECTOR_SIZE] = {0xd6, 0x68, 0x10, 0x42};

// Function: requestWithdrawalsWstETH(uint256[] _amounts,address _owner)
// https://goerli.etherscan.io/tx/0xed441dfe79cd05758fe8c4d9e479bd8662702ca16bdfe41b6016ce9880d14987
static const uint8_t LIDO_REQUEST_WITHDRAWALS_WSTETH_SELECTOR[SELECTOR_SIZE] = {0x19,
                                                                                0xaa,
                                                                                0x62,
                                                                                0x57};

// Array of all the different lido selectors.
const uint8_t *const LIDO_SELECTORS[NUM_LIDO_SELECTORS] = {
    LIDO_SUBMIT_SELECTOR,
    LIDO_WRAP_STETH_SELECTOR,
    LIDO_UNWRAP_WSTETH_SELECTOR,
    LIDO_REQUEST_WITHDRAWALS_WITH_PERMIT_SELECTOR,
    LIDO_REQUEST_WITHDRAWALS_WSTETH_WITH_PERMIT_SELECTOR,
    LIDO_CLAIM_WITHDRAWALS_SELECTOR,
    LIDO_REQUEST_WITHDRAWALS_SELECTOR,
    LIDO_REQUEST_WITHDRAWALS_WSTETH_SELECTOR,
};