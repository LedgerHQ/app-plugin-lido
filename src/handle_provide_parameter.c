#include "lido_plugin.h"

// Store the amount sent in the form of a string, without any ticker or
// decimals. These will be added when displaying.
static void handle_amount_sent(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    memset(context->amount_sent, 0, sizeof(context->amount_sent));

    // Convert to string.
    amountToString(msg->parameter,
                   PARAMETER_LENGTH,
                   0,
                   "",
                   (char *) context->amount_sent,
                   sizeof(context->amount_sent));
    PRINTF("AMOUNT SENT: %s\n", context->amount_sent);
}

static void handle_referral(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    memset(context->referral, 0, sizeof(context->referral));
    memcpy(context->referral,
           &msg->parameter[PARAMETER_LENGTH - ADDRESS_LENGTH],
           sizeof(context->referral));
    PRINTF("REFERRAL: %.*H\n", ADDRESS_LENGTH, context->referral);
}

static void handle_stake(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    // Describe ABI submit(address _referral)
    switch (context->next_param) {
        case REFERRAL:
            handle_referral(msg, context);
            context->next_param = NONE;
        default:
            PRINTF("Param not supported\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

static void handle_wrap(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    // ABI for wrap is: wrap(uint256 amount)
    // ABI for unwrap is: unwrap(uint256 amount)
    switch (context->next_param) {
        case TOKEN_RECEIVED:  // fromToken
            handle_amount_sent(msg, context);
            context->next_param = NONE;
            break;
        default:
            PRINTF("Param not supported\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

void handle_provide_parameter(void *parameters) {
    ethPluginProvideParameter_t *msg = (ethPluginProvideParameter_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
    PRINTF("plugin provide parameter %d %.*H\n",
           msg->parameterOffset,
           PARAMETER_LENGTH,
           msg->parameter);

    msg->result = ETH_PLUGIN_RESULT_OK;

    switch (context->selectorIndex) {
        case STAKE:
            handle_stake(msg, context);
            break;
        case UNWRAP:
        case WRAP:
            handle_wrap(msg, context);
            break;
        default:
            PRINTF("Selector Index %d not supported\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}