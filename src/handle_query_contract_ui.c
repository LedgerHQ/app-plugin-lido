#include "lido_plugin.h"

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

    amountToString(context->amount_sent,
                   context->amount_length,
                   decimals,
                   ticker,
                   msg->msg,
                   msg->msgLength);
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
