#include "lido_plugin.h"

// Store the amount sent in the form of a string, without any ticker or
// decimals. These will be added right before display.
static void handle_amount_sent(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    memset(context->amount_sent, 0, sizeof(context->amount_sent));
    memcpy(context->amount_sent, msg->parameter, PARAMETER_LENGTH);
    context->amount_length = PARAMETER_LENGTH;
}

static void handle_referral(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    memset(context->referral, 0, sizeof(context->referral));
    memcpy(context->referral,
           &msg->parameter[PARAMETER_LENGTH - ADDRESS_LENGTH],
           ADDRESS_LENGTH);
    PRINTF("REFERRAL: %.*H\n", ADDRESS_LENGTH, context->referral);
}

static void handle_stake(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    // ABI for stake is: submit(address referral)
    switch (context->next_param) {
        case REFERRAL:
            handle_referral(msg, context);
            context->next_param = NONE;
            break;
        default:
            PRINTF("Param not supported\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

// Similar to handle_amount_sent but takes the amount from the transaction data (in ETH).
static void copy_eth_amount(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    memset(context->amount_sent, 0, sizeof(context->amount_sent));
    memcpy(context->amount_sent, (uint8_t *)&msg->pluginSharedRO->txContent->value.value, msg->pluginSharedRO->txContent->value.length);
    context->amount_length = msg->pluginSharedRO->txContent->value.length;
}

static void handle_wrap(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    // ABI for wrap is: wrap(uint256 amount)
    // ABI for unwrap is: unwrap(uint256 amount)
    switch (context->next_param) {
        case AMOUNT_SENT:
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
            copy_eth_amount(msg, context);

            // Should be done parsing.
            context->next_param = NONE;
            break;
        case UNWRAP:
        case WRAP:
            handle_wrap(msg, context);

            // Should be done parsing.
            context->next_param = NONE;
            break;
        default:
            PRINTF("Selector Index %d not supported\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}