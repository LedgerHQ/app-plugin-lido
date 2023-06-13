#include "lido_plugin.h"

// Set UI for the "Send" screen.
static void set_send_ui(ethQueryContractUI_t *msg, lido_parameters_t *context) {
    const char *ticker = "ETH";

    switch (context->selectorIndex) {
        case SUBMIT:
            strlcpy(msg->title, "Stake", msg->titleLength);
            break;
        case UNWRAP:
            strlcpy(msg->title, "Unwrap", msg->titleLength);
            ticker = WSTETH_TICKER;
            break;
        case WRAP:
            strlcpy(msg->title, "Wrap", msg->titleLength);
            ticker = STETH_TICKER;
            break;
        case REQUEST_WITHDRAWALS_WITH_PERMIT:
        case REQUEST_WITHDRAWALS:
            strlcpy(msg->title, "Amount", msg->titleLength);
            ticker = STETH_TICKER;
            break;
        case REQUEST_WITHDRAWALS_WSTETH_WITH_PERMIT:
        case REQUEST_WITHDRAWALS_WSTETH:
            strlcpy(msg->title, "Amount", msg->titleLength);
            ticker = WSTETH_TICKER;
            break;
        case CLAIM_WITHDRAWALS:
            strlcpy(msg->title, "Request Ids", msg->titleLength);
            break;
        default:
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }

    switch (context->selectorIndex) {
        case SUBMIT:
            return amountToString(msg->pluginSharedRO->txContent->value.value,
                                  msg->pluginSharedRO->txContent->value.length,
                                  WEI_TO_ETHER,
                                  ticker,
                                  msg->msg,
                                  msg->msgLength);
        case UNWRAP:
        case WRAP:
        case REQUEST_WITHDRAWALS_WITH_PERMIT:
        case REQUEST_WITHDRAWALS_WSTETH_WITH_PERMIT:
        case REQUEST_WITHDRAWALS:
        case REQUEST_WITHDRAWALS_WSTETH:
            return amountToString(context->amount_sent,
                                  INT256_LENGTH,
                                  WEI_TO_ETHER,
                                  ticker,
                                  msg->msg,
                                  msg->msgLength);
        case CLAIM_WITHDRAWALS:
            if (!uint256_to_decimal(context->amount_sent,
                                    INT256_LENGTH,
                                    msg->msg,
                                    msg->msgLength)) {
                msg->result = ETH_PLUGIN_RESULT_ERROR;
                break;
            };
            break;
        default:
            break;
    }
}

static void set_send_ui_two(ethQueryContractUI_t *msg, lido_parameters_t *context) {
    const char *ticker = "ETH";

    switch (context->selectorIndex) {
        case CLAIM_WITHDRAWALS:
            strlcpy(msg->title, "Request Ids", msg->titleLength);
            break;
        case REQUEST_WITHDRAWALS:
            strlcpy(msg->title, "Amount", msg->titleLength);
            ticker = STETH_TICKER;
            break;
        case REQUEST_WITHDRAWALS_WSTETH:
            strlcpy(msg->title, "Amount", msg->titleLength);
            ticker = WSTETH_TICKER;
            break;
        default:
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }

    switch (context->selectorIndex) {
        case CLAIM_WITHDRAWALS:
            if (!uint256_to_decimal(context->amount_sent_two,
                                    INT256_LENGTH,
                                    msg->msg,
                                    msg->msgLength)) {
                msg->result = ETH_PLUGIN_RESULT_ERROR;
                break;
            };
            break;
        case REQUEST_WITHDRAWALS:
        case REQUEST_WITHDRAWALS_WSTETH:
            return amountToString(context->amount_sent_two,
                                  INT256_LENGTH,
                                  WEI_TO_ETHER,
                                  ticker,
                                  msg->msg,
                                  msg->msgLength);
        default:
            break;
    }
}

// Set UI for the "Address" screen.
static void set_address_ui(ethQueryContractUI_t *msg, lido_parameters_t *context) {
    switch (context->selectorIndex) {
        case REQUEST_WITHDRAWALS_WITH_PERMIT:
        case REQUEST_WITHDRAWALS_WSTETH_WITH_PERMIT:
        case REQUEST_WITHDRAWALS:
        case REQUEST_WITHDRAWALS_WSTETH:
            strlcpy(msg->title, "Owner", msg->titleLength);
            break;
        default:
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }

    msg->msg[0] = '0';
    msg->msg[1] = 'x';
    getEthAddressStringFromBinary((uint8_t *) context->address_sent,
                                  msg->msg + 2,
                                  msg->pluginSharedRW->sha3,
                                  0);
}

// Helper function that returns the enum corresponding to the screen that should be displayed.
static screens_t get_screen(ethQueryContractUI_t *msg, lido_parameters_t *context) {
    uint8_t index = msg->screenIndex;

    switch (context->selectorIndex) {
        case SUBMIT:
        case WRAP:
        case UNWRAP:
            switch (index) {
                case 0:
                    return SEND_SCREEN;
                default:
                    return ERROR;
            }
        case REQUEST_WITHDRAWALS_WITH_PERMIT:
        case REQUEST_WITHDRAWALS_WSTETH_WITH_PERMIT:
            switch (index) {
                case 0:
                    return ADDRESS_SCREEN;
                case 1:
                    return SEND_SCREEN;
                default:
                    return ERROR;
            }
            break;
        case REQUEST_WITHDRAWALS:
        case REQUEST_WITHDRAWALS_WSTETH:
            switch (index) {
                case 0:
                    return ADDRESS_SCREEN;
                case 1:
                    return SEND_SCREEN;
                case 2:
                    return SEND_SCREEN_TWO;
                default:
                    return ERROR;
            }
            break;
        case CLAIM_WITHDRAWALS:
            switch (index) {
                case 0:
                    return SEND_SCREEN;
                case 1:
                    return SEND_SCREEN_TWO;
                default:
                    return ERROR;
            }
            break;
        default:
            return ERROR;
    }
    return ERROR;
}

void handle_query_contract_ui(void *parameters) {
    ethQueryContractUI_t *msg = (ethQueryContractUI_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;

    memset(msg->title, 0, msg->titleLength);
    memset(msg->msg, 0, msg->msgLength);
    msg->result = ETH_PLUGIN_RESULT_OK;

    screens_t screen = get_screen(msg, context);
    switch (screen) {
        case SEND_SCREEN:
            set_send_ui(msg, context);
            break;
        case SEND_SCREEN_TWO:
            set_send_ui_two(msg, context);
            break;
        case ADDRESS_SCREEN:
            set_address_ui(msg, context);
            break;
        default:
            PRINTF("Received an invalid screenIndex %d\n", screen);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}
