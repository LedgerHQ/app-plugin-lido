#include "lido_plugin.h"

// Called once to init.
void handle_init_contract(ethPluginInitContract_t *msg) {
    if (msg->interfaceVersion != ETH_PLUGIN_INTERFACE_VERSION_LATEST) {
        msg->result = ETH_PLUGIN_RESULT_UNAVAILABLE;
        return;
    }

    if (msg->pluginContextLength < sizeof(lido_parameters_t)) {
        msg->result = ETH_PLUGIN_RESULT_ERROR;
        return;
    }

    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
    memset(context, 0, sizeof(*context));

    for (int i = 0; i < NUM_LIDO_SELECTORS; i++) {
        if (memcmp(PIC(LIDO_SELECTORS[i]), msg->selector, SELECTOR_SIZE) == 0) {
            context->selectorIndex = i;
            break;
        }
    }

    if (context->selectorIndex == NUM_LIDO_SELECTORS) {
        msg->result = ETH_PLUGIN_RESULT_ERROR;
        return;
    }

    context->valid = 0;  // init on false for security
    // Set `next_param` to be the first field we expect to parse.
    switch (context->selectorIndex) {
        case SUBMIT:
            context->next_param = REFERRAL;
            break;
        case UNWRAP:
        case WRAP:
            context->next_param = AMOUNT_SENT;
            break;
        case REQUEST_WITHDRAWALS_WITH_PERMIT:
        case REQUEST_WITHDRAWALS_WSTETH_WITH_PERMIT:
        case REQUEST_WITHDRAWALS:
        case REQUEST_WITHDRAWALS_WSTETH:
            context->skip = 1;  // skip offset
            context->next_param = ADDRESS_SENT;
            break;
        case CLAIM_WITHDRAWALS:
            context->skip = 2;  // skip offset
            context->next_param = AMOUNT_LENGTH;
            break;
        default:
            PRINTF("Missing selectorIndex\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
    msg->result = ETH_PLUGIN_RESULT_OK;
}
