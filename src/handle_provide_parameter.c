#include "lido_plugin.h"

// Store the amount sent in the form of a string, without any ticker or
// decimals. These will be added right before display.
static void handle_amount_sent(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    memset(context->amount_sent, 0, sizeof(context->amount_sent));
    memcpy(context->amount_sent, msg->parameter, PARAMETER_LENGTH);
    context->amount_length = PARAMETER_LENGTH;
}

static void handle_submit(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    // ABI for submit is: submit(address referral)
    if (context->next_param == REFERRAL) {
        // Should be done parsing
        context->next_param = NONE;
    } else {
        PRINTF("Param not supported\n");
        msg->result = ETH_PLUGIN_RESULT_ERROR;
    }
}

// Similar to handle_amount_sent but takes the amount from the transaction data (in ETH).
static void copy_eth_amount(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    memset(context->amount_sent, 0, sizeof(context->amount_sent));
    memcpy(context->amount_sent,
           &msg->pluginSharedRO->txContent->value.value,
           msg->pluginSharedRO->txContent->value.length);
    context->amount_length = msg->pluginSharedRO->txContent->value.length;
}

static void handle_wrap(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    // ABI for wrap is: wrap(uint256 amount)
    // ABI for unwrap is: unwrap(uint256 amount)
    switch (context->next_param) {
        case AMOUNT_SENT:
            handle_amount_sent(msg, context);
            // Should be done parsing
            context->next_param = NONE;
            break;
        default:
            PRINTF("Param not supported\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

static void handle_permit(ethPluginProvideParameter_t *msg, lido_parameters_t *context) {
    // ABI for wrap is: wrap(uint256 amount)
    // ABI for unwrap is: unwrap(uint256 amount)
    switch (context->next_param) {
        case OFFSET:
            // Offset to the args amounts
            context->offset = U2BE(msg->parameter, PARAMETER_LENGTH - sizeof(context->offset));
            context->next_param = AMOUNT_LENGTH;
            break;
        case AMOUNT_LENGTH:  // _pairPath length
            if (!U2BE_from_parameter(msg->parameter, &(context->array_len)) &&
                context->array_len == 0) {
                msg->result = ETH_PLUGIN_RESULT_ERROR;
                break;
            }
            context->tmp_len = context->array_len;
            context->next_param = AMOUNT_FIRST;
            break;
        case AMOUNT_FIRST:
            context->tmp_len--;

            if (!U2BE_from_parameter(msg->parameter, &context->amount_sent)) {
                msg->result = ETH_PLUGIN_RESULT_ERROR;
                break;
            }

            if (context->tmp_len == 0) {
                context->next_param = AMOUNT_LENGTH;
            } else {
                context->skip = context->tmp_len - 1;
                context->next_param = AMOUNT_LAST;
            }
            break;

        case AMOUNT_LAST:
            if (!U2BE_from_parameter(msg->parameter, &context->amount_received)) {
                msg->result = ETH_PLUGIN_RESULT_ERROR;
                break;
            }
            context->next_param = AMOUNT_LENGTH;
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

    if ((context->offset) &&
            msg->parameterOffset != context->checkpoint + context->offset + SELECTOR_SIZE) {
            PRINTF("offset: %d, checkpoint: %d, parameterOffset: %d\n",
                   context->offset,
                   context->checkpoint,
                   msg->parameterOffset);
            return;
        }
    context->offset = 0;  // Reset offset

    switch (context->selectorIndex) {
        case SUBMIT:
            handle_submit(msg, context);
            copy_eth_amount(msg, context);
            break;
        case UNWRAP:
        case WRAP:
            handle_wrap(msg, context);
            break;
        case REQUEST_WITHDRAWALS_WITH_PERMIT:
            handle_permit(msg, context);
            break;
        default:
            PRINTF("Selector Index %d not supported\n", context->selectorIndex);
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}