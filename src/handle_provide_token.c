#include "lido_plugin.h"

void handle_provide_token(void *parameters) {
    ethPluginProvideToken_t *msg = (ethPluginProvideToken_t *) parameters;
    PRINTF("plugin provide token: 0x%p, 0x%p\n", msg->token1, msg->token2);

    msg->result = ETH_PLUGIN_RESULT_OK;
}