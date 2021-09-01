#include "lido_plugin.h"

// Called once to init.
void handle_init_contract(void *parameters) {
    ethPluginInitContract_t *msg = (ethPluginInitContract_t *) parameters;

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

    // Set `next_param` to be the first field we expect to parse.
    switch (context->selectorIndex) {
        case SUBMIT:
            context->next_param = REFERRAL;
            break;
        case UNWRAP:
        case WRAP:
            context->next_param = AMOUNT_SENT;
            break;
        default:
            PRINTF("Missing selectorIndex\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    context->valid = true;
    msg->result = ETH_PLUGIN_RESULT_OK;
}
