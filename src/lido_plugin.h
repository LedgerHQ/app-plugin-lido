#pragma once

#include <string.h>
#include <stdbool.h>
#include "eth_plugin_interface.h"

#define PARAMETER_LENGTH 32
#define SELECTOR_SIZE    4

#define NUM_LIDO_SELECTORS 8

#define PLUGIN_NAME "lido"

#define STETH_TICKER   "stETH"
#define WSTETH_TICKER  "wstETH"

#define TOKEN_SENT_FOUND 1  // REMOVE IF NOT USED

// Number of decimals used when the token wasn't found in the CAL.
#define DEFAULT_DECIMAL WEI_TO_ETHER

// Ticker used when the token wasn't found in the CAL.
#define DEFAULT_TICKER             ""

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
    SEND_SCREEN_TWO,
    ADDRESS_SCREEN,
    ERROR,
} screens_t;
typedef enum {
    AMOUNT_SENT,
    AMOUNT_SENT_TWO,
    AMOUNT_LENGTH,
    ADDRESS_SENT,
    REFERRAL,
    NONE,
} selectorField;

extern const uint8_t *const LIDO_SELECTORS[NUM_LIDO_SELECTORS];

// Shared global memory with Ethereum app. Must be at most 5 * 32 bytes.
typedef struct lido_parameters_t {
    uint8_t amount_sent[INT256_LENGTH];
    uint8_t amount_sent_two[INT256_LENGTH];
    uint8_t address_sent[ADDRESS_LENGTH];
    char ticker_sent[MAX_TICKER_LEN];
    // 2 * 32 + 20 + 11 = 95
    uint16_t offset;
    uint16_t checkpoint;
    uint16_t amount_length;
    // 3 * 4 = 12
    uint8_t tokens_found;
    uint8_t decimals_sent;
    uint8_t skip;
    uint8_t next_param;
    uint8_t selectorIndex;
    uint8_t valid;
    // 7 * 1 = 7
    // 95 + 12 + 7 = 114 --- MAX is 160 (5 * 32)
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