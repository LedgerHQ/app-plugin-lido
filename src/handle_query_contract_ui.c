#include "lido_plugin.h"

// Prepend `dest` with `ticker`.
// Dest must be big enough to hold `ticker` + `dest` + `\0`.
static void prepend_ticker(char *dest, uint8_t destsize, char *ticker) {
    if (dest == NULL || ticker == NULL) {
        THROW(0x6503);
    }
    uint8_t ticker_len = strlen(ticker);
    uint8_t dest_len = strlen(dest);

    if (dest_len + ticker_len >= destsize) {
        THROW(0x6503);
    }

    // Right shift the string by `ticker_len` bytes.
    while (dest_len != 0) {
        dest[dest_len + ticker_len] = dest[dest_len];  // First iteration will copy the \0
        dest_len--;
    }
    // Don't forget to null terminate the string.
    dest[ticker_len] = dest[0];

    // Copy the ticker to the beginning of the string.
    memcpy(dest, ticker, ticker_len);
}

// Set UI for the "Send" screen.
static void set_send_ui(ethQueryContractUI_t *msg, lido_parameters_t *context) {
    uint8_t decimals = 0;
    char *ticker;

    switch (context->selectorIndex) {
        case STAKE:
            strncpy(msg->title, "Stake", msg->titleLength);
            decimals = WEI_TO_ETHER;
            ticker = "ETH ";
            break;
        case UNWRAP:
            strncpy(msg->title, "Unwrap", msg->titleLength);
            decimals = WSTETH_DECIMALS;
            ticker = WSTETH_TICKER;
            break;
        case WRAP:
            strncpy(msg->title, "Wrap", msg->titleLength);
            decimals = STETH_DECIMALS;
            ticker = STETH_TICKER;
            break;
        default:
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    adjustDecimals((char *) context->amount_sent,
                   strnlen((char *) context->amount_sent, sizeof(context->amount_sent)),
                   msg->msg,
                   msg->msgLength,
                   decimals);

    prepend_ticker(msg->msg, msg->msgLength, ticker);
}

// Set UI for "Beneficiary" screen.
static void set_referral_ui(ethQueryContractUI_t *msg, lido_parameters_t *context) {
    if (context->selectorIndex != STAKE) {
        PRINTF("Invalid selector index (%d) for screen number %d\n",
               context->selectorIndex,
               msg->screenIndex);
        return;
    }
    strncpy(msg->title, "Referrer", msg->titleLength);

    msg->msg[0] = '0';
    msg->msg[1] = 'x';

    chain_config_t chainConfig = {0};

    getEthAddressStringFromBinary((uint8_t *) context->referral,
                                  (uint8_t *) msg->msg + 2,
                                  msg->pluginSharedRW->sha3,
                                  &chainConfig);
}

void handle_query_contract_ui(void *parameters) {
    ethQueryContractUI_t *msg = (ethQueryContractUI_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;

    memset(msg->title, 0, msg->titleLength);
    memset(msg->msg, 0, msg->msgLength);
    msg->result = ETH_PLUGIN_RESULT_OK;

    switch (msg->screenIndex) {
        case 0:
            set_send_ui(msg, context);
            break;
        case 1:
            set_referral_ui(msg, context);
            break;
        default:
            PRINTF("Screen %d not supported\n", msg->screenIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}
