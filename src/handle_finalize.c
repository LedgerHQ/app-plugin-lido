#include "lido_plugin.h"

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
                if (context->amount_length > 1) {
                    msg->numScreens = 2;
                } else {
                    msg->numScreens = 1;
                }
                break;
            case REQUEST_WITHDRAWALS_WITH_PERMIT:
            case REQUEST_WITHDRAWALS_WSTETH_WITH_PERMIT:
                msg->numScreens = 2;
                break;
            case REQUEST_WITHDRAWALS:
            case REQUEST_WITHDRAWALS_WSTETH:
                if (context->amount_length > 1) {
                    msg->numScreens = 3;
                } else {
                    msg->numScreens = 2;
                }
                break;
            default:
                break;
        }

        msg->tokenLookup1 = context->token_received;

        msg->uiType = ETH_UI_TYPE_GENERIC;
        msg->result = ETH_PLUGIN_RESULT_OK;
    } else {
        PRINTF("Invalid context\n");
        msg->result = ETH_PLUGIN_RESULT_FALLBACK;
    }
}
