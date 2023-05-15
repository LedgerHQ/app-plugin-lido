#pragma once

#include "eth_plugin_interface.h"
#include <stdbool.h>

#define PARAMETER_LENGTH 32
#define SELECTOR_SIZE    4

#define NUM_LIDO_SELECTORS 4

#define PLUGIN_NAME "Lido"

#define STETH_TICKER   "stETH"
#define STETH_DECIMALS WEI_TO_ETHER

#define WSTETH_TICKER   "wstETH"
#define WSTETH_DECIMALS WEI_TO_ETHER

typedef enum {
    SUBMIT,
    WRAP,
    UNWRAP,
    REQUEST_WITHDRAWALS_WITH_PERMIT,
} lidoSelector_t;

typedef enum {
    AMOUNT_SENT,
    AMOUNT_LENGTH,
    AMOUNT_FIRST,
    AMOUNT_LAST,
    ADDRESS_SENT,
    DEADLINE,
    PERMIT_V,
    PERMIT_R,
    PERMIT_S,
    REFERRAL,
    NONE,
    OFFSET,
} selectorField;

extern const uint8_t *const LIDO_SELECTORS[NUM_LIDO_SELECTORS];

// Number of decimals used when the token wasn't found in the CAL.
#define DEFAULT_DECIMAL WEI_TO_ETHER

// Ticker used when the token wasn't found in the CAL.
#define DEFAULT_TICKER ""

#define MAXIMUM_STR_SIZE_OF_INT256 80

// Shared global memory with Ethereum app. Must be at most 5 * 32 bytes.
typedef struct lido_parameters_t {
    uint8_t amount_sent[INT256_LENGTH];  // This could be reduced down to 20 bytes if conversion to
                                         // string was done in ETH_QUERY_CONTRAT_UI in
                                         // ETH_QUERY_CONTRAT_UI
    uint8_t amount_received[INT256_LENGTH];
    uint8_t address_sent[ADDRESS_LENGTH];

    char bytes[INT256_LENGTH];
    // 32 * 2 + 20 + 32 = 116
                                        
    uint16_t offset;
    uint16_t checkpoint;
    uint16_t tmp_len;
    uint16_t array_len;
    // 2 * 4 = 8

    uint8_t skip;
    uint8_t amount_length;
    uint8_t next_param;
    uint8_t selectorIndex;
    bool valid;
    // 1 * 4 = 4
    // 116 + 8 + 5 = 129 --- MAX is 160 (5 * 32)
} lido_parameters_t;

_Static_assert(sizeof(lido_parameters_t) <= 5 * 32, "Structure of parameters too big.");

void handle_provide_parameter(void *parameters);
void handle_query_contract_ui(void *parameters);
void handle_init_contract(void *parameters);
void handle_finalize(void *parameters);
void handle_provide_token(void *parameters);
void handle_query_contract_id(void *parameters);
