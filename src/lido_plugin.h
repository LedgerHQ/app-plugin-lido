#pragma once

#include <string.h>
#include <stdbool.h>
#include "eth_plugin_interface.h"

#define PARAMETER_LENGTH 32
#define SELECTOR_SIZE    4

#define NUM_LIDO_SELECTORS 8

#define PLUGIN_NAME "lido"

#define STETH_TICKER   "stETH"
#define STETH_DECIMALS WEI_TO_ETHER

#define WSTETH_TICKER   "wstETH"
#define WSTETH_DECIMALS WEI_TO_ETHER

#define TOKEN_SENT_FOUND     1       // REMOVE IF NOT USED
#define TOKEN_RECEIVED_FOUND 1 << 1  // REMOVE IF NOT USED

extern const uint8_t PLUGIN_ETH_ADDRESS[ADDRESS_LENGTH];  // REMOVE IF NOT USED
extern const uint8_t NULL_ETH_ADDRESS[ADDRESS_LENGTH];    // REMOVE IF NOT USED

// Returns 1 if corresponding address is the address for the chain token (ETH, BNB, MATIC,
#define ADDRESS_IS_NETWORK_TOKEN(_addr)                    \
    (!memcmp(_addr, PLUGIN_ETH_ADDRESS, ADDRESS_LENGTH) || \
     !memcmp(_addr, NULL_ETH_ADDRESS, ADDRESS_LENGTH))

typedef enum {
    SUBMIT,
    WRAP,
    UNWRAP,
    REQUEST_WITHDRAWALS_WITH_PERMIT,
    REQUEST_WITHDRAWALS_WSTETH_WITH_PERMIT,
    CLAIM_WITHDRAWALS,
    REQUEST_WITHDRAWALS,
    REQUEST_WITHDRAWALS_WSTETH,
} lidoSelector_t;

typedef enum {
    SEND_SCREEN,
    ADDRESS_SCREEN,
    ERROR,
} screens_t;
typedef enum {
    AMOUNT_SENT,
    ADDRESS_SENT,
    REFERRAL,
    NONE,
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
    uint8_t address_sent[ADDRESS_LENGTH];
    uint8_t contract_address_sent[ADDRESS_LENGTH];
    uint8_t contract_address_received[ADDRESS_LENGTH];
    char ticker_sent[MAX_TICKER_LEN];
    char ticker_received[MAX_TICKER_LEN];
    // 32 + 60 + 11 + 11 = 114
                                        
    uint16_t offset;
    uint16_t checkpoint;
    // 2 * 4 = 8

    uint8_t tokens_found;
    uint8_t decimals_sent;
    uint8_t decimals_received;
    uint8_t skip;
    uint8_t amount_length;
    uint8_t next_param;
    uint8_t selectorIndex;
    uint8_t valid;
    // 1 * 8 = 8
    // 114 + 8 + 8 = 130 --- MAX is 160 (5 * 32)
} lido_parameters_t;

_Static_assert(sizeof(lido_parameters_t) <= 5 * 32, "Structure of parameters too big.");

void handle_provide_parameter(void *parameters);
void handle_query_contract_ui(void *parameters);
void handle_init_contract(void *parameters);
void handle_finalize(void *parameters);
void handle_provide_token(void *parameters);
void handle_query_contract_id(void *parameters);

static inline void printf_hex_array(const char *title __attribute__((unused)),
                                    size_t len __attribute__((unused)),
                                    const uint8_t *data __attribute__((unused))) {
    PRINTF(title);
    for (size_t i = 0; i < len; ++i) {
        PRINTF("%02x", data[i]);
    };
    PRINTF("\n");
}