#include "lido_plugin.h"

// Returns true if `address` corresponds to the ethereum address `0x000...`.
bool eth_address_is_zero(char *address) {
	for (size_t i = 0; i < ADDRESS_LENGTH; i++) {
		if (address[i] != '0') {
			return false;
		}
	}
	return true;
}