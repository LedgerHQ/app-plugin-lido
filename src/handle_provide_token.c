#include "lido_plugin.h"

void handle_provide_token(ethPluginProvideInfo_t *msg) {
    PRINTF("Plugin provide tokens : 0x%p, 0x%p\n", msg->item1, msg->item2);

    msg->result = ETH_PLUGIN_RESULT_OK;
}
