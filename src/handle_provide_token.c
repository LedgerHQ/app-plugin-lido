#include "lido_plugin.h"

void handle_provide_token(void *parameters) {
    ethPluginProvideInfo_t *msg = (ethPluginProvideInfo_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
    PRINTF("Plugin provide tokens : 0x%p, 0x%p\n", msg->item1, msg->item2);

    if (msg->item1 != NULL) {
        context->decimals_sent = msg->item1->token.decimals;
        strlcpy(context->ticker_sent,
                (char *) msg->item1->token.ticker,
                sizeof(context->ticker_sent));
        context->tokens_found |= TOKEN_SENT_FOUND;
    } else {
        // CAL did not find the token and token is not ETH.
        context->decimals_sent = DEFAULT_DECIMAL;
        strlcpy(context->ticker_sent, DEFAULT_TICKER, sizeof(context->ticker_sent));
        // // We will need an additional screen to display a warning message.
        msg->additionalScreens++;
    }

    msg->result = ETH_PLUGIN_RESULT_OK;
}