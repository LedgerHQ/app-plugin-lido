#include "lido_plugin.h"

void handle_query_contract_id(void *parameters) {
    ethQueryContractID_t *msg = (ethQueryContractID_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;

    strlcpy(msg->name, PLUGIN_NAME, msg->nameLength);

    switch (context->selectorIndex) {
        case SUBMIT:
            strlcpy(msg->version, "Stake", msg->versionLength);
            break;
        case WRAP:
            strlcpy(msg->version, "Wrap", msg->versionLength);
            break;
        case UNWRAP:
            strlcpy(msg->version, "Unwrap", msg->versionLength);
            break;
        default:
            PRINTF("Selector Index :%d not supported\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    msg->result = ETH_PLUGIN_RESULT_OK;
}