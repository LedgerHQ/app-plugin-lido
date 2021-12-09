#include "lido_plugin.h"

void handle_provide_token(void *parameters) {
    ethPluginProvideInfo_t *msg = (ethPluginProvideInfo_t *) parameters;
    PRINTF("plugin provide token: 0x%p, 0x%p\n", msg->item1, msg->item2);

    msg->result = ETH_PLUGIN_RESULT_OK;
}
