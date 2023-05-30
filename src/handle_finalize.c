#include "lido_plugin.h"

static void sent_network_token(lido_parameters_t *context) {
    context->decimals_sent = WEI_TO_ETHER;
    context->tokens_found |= TOKEN_SENT_FOUND;
}

void handle_finalize(void *parameters) {
    ethPluginFinalize_t *msg = (ethPluginFinalize_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
    PRINTF("handle finalize\n");
    if (context->valid) {
        switch (context->selectorIndex) {
            case SUBMIT:
            case UNWRAP:
            case WRAP:
            case CLAIM_WITHDRAWALS:
                if (context->amount_length == 2) {
                    msg->numScreens = 2;
                } else {
                    msg->numScreens = 1;
                }
                break;
            case REQUEST_WITHDRAWALS_WITH_PERMIT:
            case REQUEST_WITHDRAWALS_WSTETH_WITH_PERMIT:
            case REQUEST_WITHDRAWALS:
            case REQUEST_WITHDRAWALS_WSTETH:
                msg->numScreens = 2;
                break;
            default:
                break;
        }
        msg->uiType = ETH_UI_TYPE_GENERIC;
        msg->result = ETH_PLUGIN_RESULT_OK;

        if (!ADDRESS_IS_NETWORK_TOKEN(context->contract_address_sent)) {
            // Address is not network token (0xeee...) so we will need to look up the token in the
            // CAL.
            printf_hex_array("Setting address sent to: ",
                             ADDRESS_LENGTH,
                             context->contract_address_sent);
            msg->tokenLookup1 = context->contract_address_sent;
        } else {
            sent_network_token(context);
            msg->tokenLookup1 = NULL;
        }

        msg->uiType = ETH_UI_TYPE_GENERIC;
        msg->result = ETH_PLUGIN_RESULT_OK;
    } else {
        PRINTF("Invalid context\n");
        msg->result = ETH_PLUGIN_RESULT_FALLBACK;
    }
}
