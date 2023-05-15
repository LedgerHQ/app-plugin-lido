
build/nanos2/bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0de0000 <main>:
    libcall_params[1] = 0x100;
    libcall_params[2] = RUN_APPLICATION;
    os_lib_call((unsigned int *) &libcall_params);
}

__attribute__((section(".boot"))) int main(int arg0) {
c0de0000:	b5f0      	push	{r4, r5, r6, r7, lr}
c0de0002:	b08f      	sub	sp, #60	; 0x3c
c0de0004:	4605      	mov	r5, r0
    // exit critical section
    __asm volatile("cpsie i");
c0de0006:	b662      	cpsie	i

    // ensure exception will work as planned
    os_boot();
c0de0008:	f000 fc1a 	bl	c0de0840 <os_boot>
c0de000c:	466c      	mov	r4, sp

    BEGIN_TRY {
        TRY {
c0de000e:	4620      	mov	r0, r4
c0de0010:	f000 fe94 	bl	c0de0d3c <setjmp>
c0de0014:	b287      	uxth	r7, r0
c0de0016:	f8ad 002c 	strh.w	r0, [sp, #44]	; 0x2c
c0de001a:	b347      	cbz	r7, c0de006e <main+0x6e>
                if (args[0] != ETH_PLUGIN_CHECK_PRESENCE) {
                    dispatch_plugin_calls(args[0], (void *) args[1]);
                }
            }
        }
        CATCH_OTHER(e) {
c0de001c:	980a      	ldr	r0, [sp, #40]	; 0x28
c0de001e:	2100      	movs	r1, #0
c0de0020:	463e      	mov	r6, r7
c0de0022:	f8ad 102c 	strh.w	r1, [sp, #44]	; 0x2c
c0de0026:	f000 fe3f 	bl	c0de0ca8 <try_context_set>
c0de002a:	f246 5002 	movw	r0, #25858	; 0x6502
            switch (e) {
c0de002e:	4287      	cmp	r7, r0
c0de0030:	d001      	beq.n	c0de0036 <main+0x36>
c0de0032:	2f07      	cmp	r7, #7
c0de0034:	d107      	bne.n	c0de0046 <main+0x46>
    switch (args[0]) {
c0de0036:	6828      	ldr	r0, [r5, #0]
c0de0038:	f5b0 7f83 	cmp.w	r0, #262	; 0x106
c0de003c:	d103      	bne.n	c0de0046 <main+0x46>
            ((ethQueryContractUI_t *) args[1])->result = ETH_PLUGIN_RESULT_ERROR;
c0de003e:	6868      	ldr	r0, [r5, #4]
c0de0040:	2100      	movs	r1, #0
c0de0042:	f880 1034 	strb.w	r1, [r0, #52]	; 0x34
                    handle_query_ui_exception((unsigned int *) arg0);
                    break;
                default:
                    break;
            }
            PRINTF("Exception 0x%x caught\n", e);
c0de0046:	481c      	ldr	r0, [pc, #112]	; (c0de00b8 <main+0xb8>)
c0de0048:	4631      	mov	r1, r6
c0de004a:	4478      	add	r0, pc
c0de004c:	f000 fc20 	bl	c0de0890 <mcu_usb_printf>
        }
        FINALLY {
c0de0050:	f000 fe20 	bl	c0de0c94 <try_context_get>
c0de0054:	42a0      	cmp	r0, r4
c0de0056:	d102      	bne.n	c0de005e <main+0x5e>
c0de0058:	980a      	ldr	r0, [sp, #40]	; 0x28
c0de005a:	f000 fe25 	bl	c0de0ca8 <try_context_set>
            os_lib_end();
c0de005e:	f000 fdf5 	bl	c0de0c4c <os_lib_end>
        }
    }
    END_TRY;
c0de0062:	f8bd 002c 	ldrh.w	r0, [sp, #44]	; 0x2c
c0de0066:	bb00      	cbnz	r0, c0de00aa <main+0xaa>
c0de0068:	2000      	movs	r0, #0

    return 0;
}
c0de006a:	b00f      	add	sp, #60	; 0x3c
c0de006c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0de006e:	4668      	mov	r0, sp
        TRY {
c0de0070:	f000 fe1a 	bl	c0de0ca8 <try_context_set>
c0de0074:	900a      	str	r0, [sp, #40]	; 0x28
// get API level
SYSCALL unsigned int get_api_level(void);

#ifndef HAVE_BOLOS
static inline void check_api_level(unsigned int apiLevel) {
  if (apiLevel < get_api_level()) {
c0de0076:	f000 fdd0 	bl	c0de0c1a <get_api_level>
c0de007a:	280d      	cmp	r0, #13
c0de007c:	d217      	bcs.n	c0de00ae <main+0xae>
            if (!arg0) {
c0de007e:	b145      	cbz	r5, c0de0092 <main+0x92>
                if (args[0] != ETH_PLUGIN_CHECK_PRESENCE) {
c0de0080:	6828      	ldr	r0, [r5, #0]
c0de0082:	f240 11ff 	movw	r1, #511	; 0x1ff
c0de0086:	4288      	cmp	r0, r1
c0de0088:	d0e2      	beq.n	c0de0050 <main+0x50>
                    dispatch_plugin_calls(args[0], (void *) args[1]);
c0de008a:	6869      	ldr	r1, [r5, #4]
c0de008c:	f000 fba8 	bl	c0de07e0 <dispatch_plugin_calls>
c0de0090:	e7de      	b.n	c0de0050 <main+0x50>
    libcall_params[0] = (unsigned int) "Ethereum";
c0de0092:	4808      	ldr	r0, [pc, #32]	; (c0de00b4 <main+0xb4>)
c0de0094:	4478      	add	r0, pc
c0de0096:	900c      	str	r0, [sp, #48]	; 0x30
c0de0098:	f44f 7080 	mov.w	r0, #256	; 0x100
    libcall_params[1] = 0x100;
c0de009c:	900d      	str	r0, [sp, #52]	; 0x34
c0de009e:	2001      	movs	r0, #1
    libcall_params[2] = RUN_APPLICATION;
c0de00a0:	900e      	str	r0, [sp, #56]	; 0x38
c0de00a2:	a80c      	add	r0, sp, #48	; 0x30
    os_lib_call((unsigned int *) &libcall_params);
c0de00a4:	f000 fdc4 	bl	c0de0c30 <os_lib_call>
c0de00a8:	e7de      	b.n	c0de0068 <main+0x68>
    END_TRY;
c0de00aa:	f000 fbcd 	bl	c0de0848 <os_longjmp>
c0de00ae:	20ff      	movs	r0, #255	; 0xff
    os_sched_exit(-1);
c0de00b0:	f000 fdd6 	bl	c0de0c60 <os_sched_exit>
c0de00b4:	00000d19 	.word	0x00000d19
c0de00b8:	00000d74 	.word	0x00000d74

c0de00bc <adjustDecimals>:

bool adjustDecimals(const char *src,
                    size_t srcLength,
                    char *target,
                    size_t targetLength,
                    uint8_t decimals) {
c0de00bc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0de00be:	b081      	sub	sp, #4
c0de00c0:	4617      	mov	r7, r2
c0de00c2:	460e      	mov	r6, r1
    uint32_t startOffset;
    uint32_t lastZeroOffset = 0;
    uint32_t offset = 0;
    if ((srcLength == 1) && (*src == '0')) {
c0de00c4:	2901      	cmp	r1, #1
c0de00c6:	4605      	mov	r5, r0
c0de00c8:	d10a      	bne.n	c0de00e0 <adjustDecimals+0x24>
c0de00ca:	7828      	ldrb	r0, [r5, #0]
c0de00cc:	2830      	cmp	r0, #48	; 0x30
c0de00ce:	d107      	bne.n	c0de00e0 <adjustDecimals+0x24>
        if (targetLength < 2) {
c0de00d0:	2b02      	cmp	r3, #2
c0de00d2:	f04f 0000 	mov.w	r0, #0
c0de00d6:	d363      	bcc.n	c0de01a0 <adjustDecimals+0xe4>
c0de00d8:	2130      	movs	r1, #48	; 0x30
            return false;
        }
        target[0] = '0';
c0de00da:	7039      	strb	r1, [r7, #0]
        target[1] = '\0';
c0de00dc:	7078      	strb	r0, [r7, #1]
c0de00de:	e05e      	b.n	c0de019e <adjustDecimals+0xe2>
c0de00e0:	9906      	ldr	r1, [sp, #24]
        return true;
    }
    if (srcLength <= decimals) {
c0de00e2:	42b1      	cmp	r1, r6
c0de00e4:	d223      	bcs.n	c0de012e <adjustDecimals+0x72>
        }
        target[offset] = '\0';
    } else {
        uint32_t sourceOffset = 0;
        uint32_t delta = srcLength - decimals;
        if (targetLength < srcLength + 1 + 1) {
c0de00e6:	1cb0      	adds	r0, r6, #2
c0de00e8:	4298      	cmp	r0, r3
c0de00ea:	d823      	bhi.n	c0de0134 <adjustDecimals+0x78>
c0de00ec:	ebb6 0c01 	subs.w	ip, r6, r1
            return false;
        }
        while (offset < delta) {
c0de00f0:	d008      	beq.n	c0de0104 <adjustDecimals+0x48>
c0de00f2:	4628      	mov	r0, r5
c0de00f4:	4663      	mov	r3, ip
c0de00f6:	463c      	mov	r4, r7
            target[offset++] = src[sourceOffset++];
c0de00f8:	f810 2b01 	ldrb.w	r2, [r0], #1
        while (offset < delta) {
c0de00fc:	3b01      	subs	r3, #1
            target[offset++] = src[sourceOffset++];
c0de00fe:	f804 2b01 	strb.w	r2, [r4], #1
        while (offset < delta) {
c0de0102:	d1f9      	bne.n	c0de00f8 <adjustDecimals+0x3c>
        }
        if (decimals != 0) {
c0de0104:	2900      	cmp	r1, #0
c0de0106:	bf0f      	iteee	eq
c0de0108:	4660      	moveq	r0, ip
            target[offset++] = '.';
c0de010a:	f10c 0001 	addne.w	r0, ip, #1
c0de010e:	222e      	movne	r2, #46	; 0x2e
c0de0110:	f807 200c 	strbne.w	r2, [r7, ip]
        }
        startOffset = offset;
        while (sourceOffset < srcLength) {
c0de0114:	45b4      	cmp	ip, r6
c0de0116:	d228      	bcs.n	c0de016a <adjustDecimals+0xae>
c0de0118:	eb05 020c 	add.w	r2, r5, ip
c0de011c:	183e      	adds	r6, r7, r0
c0de011e:	2300      	movs	r3, #0
            target[offset++] = src[sourceOffset++];
c0de0120:	5cd5      	ldrb	r5, [r2, r3]
c0de0122:	54f5      	strb	r5, [r6, r3]
        while (sourceOffset < srcLength) {
c0de0124:	3301      	adds	r3, #1
c0de0126:	4299      	cmp	r1, r3
c0de0128:	d1fa      	bne.n	c0de0120 <adjustDecimals+0x64>
c0de012a:	18c1      	adds	r1, r0, r3
c0de012c:	e01e      	b.n	c0de016c <adjustDecimals+0xb0>
        if (targetLength < srcLength + 1 + 2 + delta) {
c0de012e:	1cc8      	adds	r0, r1, #3
c0de0130:	4298      	cmp	r0, r3
c0de0132:	d901      	bls.n	c0de0138 <adjustDecimals+0x7c>
c0de0134:	2000      	movs	r0, #0
c0de0136:	e033      	b.n	c0de01a0 <adjustDecimals+0xe4>
c0de0138:	2030      	movs	r0, #48	; 0x30
c0de013a:	1b8c      	subs	r4, r1, r6
        target[offset++] = '0';
c0de013c:	7038      	strb	r0, [r7, #0]
c0de013e:	f04f 002e 	mov.w	r0, #46	; 0x2e
        target[offset++] = '.';
c0de0142:	7078      	strb	r0, [r7, #1]
        for (uint32_t i = 0; i < delta; i++) {
c0de0144:	d006      	beq.n	c0de0154 <adjustDecimals+0x98>
c0de0146:	1cb8      	adds	r0, r7, #2
            target[offset++] = '0';
c0de0148:	4621      	mov	r1, r4
c0de014a:	2230      	movs	r2, #48	; 0x30
c0de014c:	f000 fdc1 	bl	c0de0cd2 <__aeabi_memset>
        for (uint32_t i = 0; i < delta; i++) {
c0de0150:	1ca0      	adds	r0, r4, #2
c0de0152:	e000      	b.n	c0de0156 <adjustDecimals+0x9a>
c0de0154:	2002      	movs	r0, #2
        for (uint32_t i = 0; i < srcLength; i++) {
c0de0156:	b146      	cbz	r6, c0de016a <adjustDecimals+0xae>
c0de0158:	183a      	adds	r2, r7, r0
c0de015a:	2100      	movs	r1, #0
            target[offset++] = src[i];
c0de015c:	5c6b      	ldrb	r3, [r5, r1]
c0de015e:	5453      	strb	r3, [r2, r1]
        for (uint32_t i = 0; i < srcLength; i++) {
c0de0160:	3101      	adds	r1, #1
c0de0162:	428e      	cmp	r6, r1
c0de0164:	d1fa      	bne.n	c0de015c <adjustDecimals+0xa0>
c0de0166:	4401      	add	r1, r0
c0de0168:	e000      	b.n	c0de016c <adjustDecimals+0xb0>
c0de016a:	4601      	mov	r1, r0
c0de016c:	2300      	movs	r3, #0
        }
        target[offset] = '\0';
    }
    for (uint32_t i = startOffset; i < offset; i++) {
c0de016e:	4288      	cmp	r0, r1
c0de0170:	547b      	strb	r3, [r7, r1]
c0de0172:	d214      	bcs.n	c0de019e <adjustDecimals+0xe2>
c0de0174:	2200      	movs	r2, #0
c0de0176:	bf00      	nop
        if (target[i] == '0') {
c0de0178:	5c3e      	ldrb	r6, [r7, r0]
c0de017a:	2a00      	cmp	r2, #0
c0de017c:	bf08      	it	eq
c0de017e:	4602      	moveq	r2, r0
c0de0180:	2e30      	cmp	r6, #48	; 0x30
    for (uint32_t i = startOffset; i < offset; i++) {
c0de0182:	f100 0001 	add.w	r0, r0, #1
        if (target[i] == '0') {
c0de0186:	bf18      	it	ne
c0de0188:	461a      	movne	r2, r3
    for (uint32_t i = startOffset; i < offset; i++) {
c0de018a:	4281      	cmp	r1, r0
c0de018c:	d1f4      	bne.n	c0de0178 <adjustDecimals+0xbc>
            }
        } else {
            lastZeroOffset = 0;
        }
    }
    if (lastZeroOffset != 0) {
c0de018e:	b132      	cbz	r2, c0de019e <adjustDecimals+0xe2>
        target[lastZeroOffset] = '\0';
        if (target[lastZeroOffset - 1] == '.') {
c0de0190:	1e50      	subs	r0, r2, #1
c0de0192:	5c3b      	ldrb	r3, [r7, r0]
c0de0194:	2100      	movs	r1, #0
c0de0196:	2b2e      	cmp	r3, #46	; 0x2e
        target[lastZeroOffset] = '\0';
c0de0198:	54b9      	strb	r1, [r7, r2]
            target[lastZeroOffset - 1] = '\0';
c0de019a:	bf08      	it	eq
c0de019c:	5439      	strbeq	r1, [r7, r0]
c0de019e:	2001      	movs	r0, #1
        }
    }
    return true;
}
c0de01a0:	b001      	add	sp, #4
c0de01a2:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0de01a4 <uint256_to_decimal>:

bool uint256_to_decimal(const uint8_t *value, size_t value_len, char *out, size_t out_len) {
    if (value_len > INT256_LENGTH) {
c0de01a4:	2920      	cmp	r1, #32
c0de01a6:	bf84      	itt	hi
c0de01a8:	2000      	movhi	r0, #0
        out[pos] = '0' + carry;
    }
    memmove(out, out + pos, out_len - pos);
    out[out_len - pos] = 0;
    return true;
}
c0de01aa:	4770      	bxhi	lr
c0de01ac:	e92d 45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
c0de01b0:	b089      	sub	sp, #36	; 0x24
c0de01b2:	ae01      	add	r6, sp, #4
c0de01b4:	460f      	mov	r7, r1
c0de01b6:	4605      	mov	r5, r0
    uint16_t n[16] = {0};
c0de01b8:	4630      	mov	r0, r6
c0de01ba:	2120      	movs	r1, #32
c0de01bc:	4698      	mov	r8, r3
c0de01be:	4692      	mov	sl, r2
c0de01c0:	f000 fd80 	bl	c0de0cc4 <__aeabi_memclr>
    memcpy((uint8_t *) n + INT256_LENGTH - value_len, value, value_len);
c0de01c4:	1bf0      	subs	r0, r6, r7
c0de01c6:	3020      	adds	r0, #32
c0de01c8:	4629      	mov	r1, r5
c0de01ca:	463a      	mov	r2, r7
c0de01cc:	f000 fd7d 	bl	c0de0cca <__aeabi_memcpy>
} extraInfo_t;

static __attribute__((no_instrument_function)) inline int allzeroes(const void *buf, size_t n) {
    uint8_t *p = (uint8_t *) buf;
    for (size_t i = 0; i < n; ++i) {
        if (p[i]) {
c0de01d0:	f89d 0004 	ldrb.w	r0, [sp, #4]
c0de01d4:	b948      	cbnz	r0, c0de01ea <uint256_to_decimal+0x46>
    for (size_t i = 0; i < n; ++i) {
c0de01d6:	1c71      	adds	r1, r6, #1
c0de01d8:	2000      	movs	r0, #0
c0de01da:	bf00      	nop
        if (p[i]) {
c0de01dc:	5c0a      	ldrb	r2, [r1, r0]
c0de01de:	b912      	cbnz	r2, c0de01e6 <uint256_to_decimal+0x42>
    for (size_t i = 0; i < n; ++i) {
c0de01e0:	3001      	adds	r0, #1
c0de01e2:	281f      	cmp	r0, #31
c0de01e4:	d1fa      	bne.n	c0de01dc <uint256_to_decimal+0x38>
    if (allzeroes(n, INT256_LENGTH)) {
c0de01e6:	281f      	cmp	r0, #31
c0de01e8:	d23c      	bcs.n	c0de0264 <uint256_to_decimal+0xc0>
c0de01ea:	2000      	movs	r0, #0
        n[i] = __builtin_bswap16(*p++);
c0de01ec:	f836 1010 	ldrh.w	r1, [r6, r0, lsl #1]
c0de01f0:	ba09      	rev	r1, r1
c0de01f2:	0c09      	lsrs	r1, r1, #16
c0de01f4:	f826 1010 	strh.w	r1, [r6, r0, lsl #1]
    for (int i = 0; i < 16; i++) {
c0de01f8:	3001      	adds	r0, #1
c0de01fa:	2810      	cmp	r0, #16
c0de01fc:	d1f6      	bne.n	c0de01ec <uint256_to_decimal+0x48>
c0de01fe:	4921      	ldr	r1, [pc, #132]	; (c0de0284 <uint256_to_decimal+0xe0>)
    while (!allzeroes(n, sizeof(n))) {
c0de0200:	1c70      	adds	r0, r6, #1
c0de0202:	4642      	mov	r2, r8
        if (p[i]) {
c0de0204:	f89d 3004 	ldrb.w	r3, [sp, #4]
c0de0208:	b93b      	cbnz	r3, c0de021a <uint256_to_decimal+0x76>
c0de020a:	2300      	movs	r3, #0
c0de020c:	5cc7      	ldrb	r7, [r0, r3]
c0de020e:	b917      	cbnz	r7, c0de0216 <uint256_to_decimal+0x72>
    for (size_t i = 0; i < n; ++i) {
c0de0210:	3301      	adds	r3, #1
c0de0212:	2b1f      	cmp	r3, #31
c0de0214:	d1fa      	bne.n	c0de020c <uint256_to_decimal+0x68>
c0de0216:	2b1e      	cmp	r3, #30
c0de0218:	d818      	bhi.n	c0de024c <uint256_to_decimal+0xa8>
        if (pos == 0) {
c0de021a:	b332      	cbz	r2, c0de026a <uint256_to_decimal+0xc6>
c0de021c:	2300      	movs	r3, #0
c0de021e:	2700      	movs	r7, #0
            int rem = ((carry << 16) | n[i]) % 10;
c0de0220:	f836 5013 	ldrh.w	r5, [r6, r3, lsl #1]
c0de0224:	ea45 4707 	orr.w	r7, r5, r7, lsl #16
            n[i] = ((carry << 16) | n[i]) / 10;
c0de0228:	fba7 5401 	umull	r5, r4, r7, r1
c0de022c:	08e5      	lsrs	r5, r4, #3
c0de022e:	eb05 0485 	add.w	r4, r5, r5, lsl #2
c0de0232:	f826 5013 	strh.w	r5, [r6, r3, lsl #1]
        for (int i = 0; i < 16; i++) {
c0de0236:	3301      	adds	r3, #1
c0de0238:	2b10      	cmp	r3, #16
c0de023a:	eba7 0744 	sub.w	r7, r7, r4, lsl #1
c0de023e:	d1ef      	bne.n	c0de0220 <uint256_to_decimal+0x7c>
        pos -= 1;
c0de0240:	3a01      	subs	r2, #1
        out[pos] = '0' + carry;
c0de0242:	f047 0330 	orr.w	r3, r7, #48	; 0x30
c0de0246:	f80a 3002 	strb.w	r3, [sl, r2]
c0de024a:	e7db      	b.n	c0de0204 <uint256_to_decimal+0x60>
    memmove(out, out + pos, out_len - pos);
c0de024c:	eba8 0502 	sub.w	r5, r8, r2
c0de0250:	eb0a 0102 	add.w	r1, sl, r2
c0de0254:	4650      	mov	r0, sl
c0de0256:	462a      	mov	r2, r5
c0de0258:	f000 fd39 	bl	c0de0cce <__aeabi_memmove>
c0de025c:	2000      	movs	r0, #0
    out[out_len - pos] = 0;
c0de025e:	f80a 0005 	strb.w	r0, [sl, r5]
c0de0262:	e00a      	b.n	c0de027a <uint256_to_decimal+0xd6>
        if (out_len < 2) {
c0de0264:	f1b8 0f02 	cmp.w	r8, #2
c0de0268:	d201      	bcs.n	c0de026e <uint256_to_decimal+0xca>
c0de026a:	2000      	movs	r0, #0
c0de026c:	e006      	b.n	c0de027c <uint256_to_decimal+0xd8>
        strlcpy(out, "0", out_len);
c0de026e:	4906      	ldr	r1, [pc, #24]	; (c0de0288 <uint256_to_decimal+0xe4>)
c0de0270:	4650      	mov	r0, sl
c0de0272:	4479      	add	r1, pc
c0de0274:	4642      	mov	r2, r8
c0de0276:	f000 fd6f 	bl	c0de0d58 <strlcpy>
c0de027a:	2001      	movs	r0, #1
c0de027c:	b009      	add	sp, #36	; 0x24
c0de027e:	e8bd 85f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, pc}
c0de0282:	bf00      	nop
c0de0284:	cccccccd 	.word	0xcccccccd
c0de0288:	00000b44 	.word	0x00000b44

c0de028c <amountToString>:
void amountToString(const uint8_t *amount,
                    uint8_t amount_size,
                    uint8_t decimals,
                    const char *ticker,
                    char *out_buffer,
                    size_t out_buffer_size) {
c0de028c:	e92d 4df0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
c0de0290:	b09a      	sub	sp, #104	; 0x68
c0de0292:	af01      	add	r7, sp, #4
c0de0294:	460c      	mov	r4, r1
c0de0296:	4605      	mov	r5, r0
    char tmp_buffer[100] = {0};
c0de0298:	4638      	mov	r0, r7
c0de029a:	2164      	movs	r1, #100	; 0x64
c0de029c:	461e      	mov	r6, r3
c0de029e:	4690      	mov	r8, r2
c0de02a0:	f000 fd10 	bl	c0de0cc4 <__aeabi_memclr>

    if (uint256_to_decimal(amount, amount_size, tmp_buffer, sizeof(tmp_buffer)) == false) {
c0de02a4:	4628      	mov	r0, r5
c0de02a6:	4621      	mov	r1, r4
c0de02a8:	463a      	mov	r2, r7
c0de02aa:	2364      	movs	r3, #100	; 0x64
c0de02ac:	f7ff ff7a 	bl	c0de01a4 <uint256_to_decimal>
c0de02b0:	b380      	cbz	r0, c0de0314 <amountToString+0x88>
c0de02b2:	e9dd ab22 	ldrd	sl, fp, [sp, #136]	; 0x88
c0de02b6:	a801      	add	r0, sp, #4
        THROW(EXCEPTION_OVERFLOW);
    }

    uint8_t amount_len = strnlen(tmp_buffer, sizeof(tmp_buffer));
c0de02b8:	2164      	movs	r1, #100	; 0x64
c0de02ba:	f000 fd62 	bl	c0de0d82 <strnlen>
c0de02be:	4607      	mov	r7, r0
    uint8_t ticker_len = strnlen(ticker, MAX_TICKER_LEN);
c0de02c0:	4630      	mov	r0, r6
c0de02c2:	210b      	movs	r1, #11
c0de02c4:	f000 fd5d 	bl	c0de0d82 <strnlen>

    memcpy(out_buffer, ticker, MIN(out_buffer_size, ticker_len));
c0de02c8:	b2c5      	uxtb	r5, r0
    uint8_t ticker_len = strnlen(ticker, MAX_TICKER_LEN);
c0de02ca:	4604      	mov	r4, r0
    memcpy(out_buffer, ticker, MIN(out_buffer_size, ticker_len));
c0de02cc:	462a      	mov	r2, r5
c0de02ce:	4650      	mov	r0, sl
c0de02d0:	4631      	mov	r1, r6
c0de02d2:	455d      	cmp	r5, fp
c0de02d4:	bf88      	it	hi
c0de02d6:	465a      	movhi	r2, fp
c0de02d8:	f000 fcf7 	bl	c0de0cca <__aeabi_memcpy>
    if (ticker_len > 0) {
c0de02dc:	b12d      	cbz	r5, c0de02ea <amountToString+0x5e>
        out_buffer[ticker_len++] = ' ';
c0de02de:	1c60      	adds	r0, r4, #1
c0de02e0:	2120      	movs	r1, #32
    }

    if (adjustDecimals(tmp_buffer,
                       amount_len,
                       out_buffer + ticker_len,
c0de02e2:	b2c0      	uxtb	r0, r0
        out_buffer[ticker_len++] = ' ';
c0de02e4:	f80a 1005 	strb.w	r1, [sl, r5]
c0de02e8:	e000      	b.n	c0de02ec <amountToString+0x60>
c0de02ea:	2000      	movs	r0, #0
                       out_buffer + ticker_len,
c0de02ec:	eb0a 0200 	add.w	r2, sl, r0
                       out_buffer_size - ticker_len - 1,
c0de02f0:	43c0      	mvns	r0, r0
                       amount_len,
c0de02f2:	b2f9      	uxtb	r1, r7
                       out_buffer_size - ticker_len - 1,
c0de02f4:	eb00 030b 	add.w	r3, r0, fp
c0de02f8:	a801      	add	r0, sp, #4
    if (adjustDecimals(tmp_buffer,
c0de02fa:	f8cd 8000 	str.w	r8, [sp]
c0de02fe:	f7ff fedd 	bl	c0de00bc <adjustDecimals>
c0de0302:	b138      	cbz	r0, c0de0314 <amountToString+0x88>
                       decimals) == false) {
        THROW(EXCEPTION_OVERFLOW);
    }

    out_buffer[out_buffer_size - 1] = '\0';
c0de0304:	eb0b 000a 	add.w	r0, fp, sl
c0de0308:	2100      	movs	r1, #0
c0de030a:	f800 1c01 	strb.w	r1, [r0, #-1]
}
c0de030e:	b01a      	add	sp, #104	; 0x68
c0de0310:	e8bd 8df0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, fp, pc}
c0de0314:	2007      	movs	r0, #7
c0de0316:	f000 fa97 	bl	c0de0848 <os_longjmp>

c0de031a <copy_address>:
        i--;
        j++;
    }
}

void copy_address(uint8_t* dst, const uint8_t* parameter, uint8_t dst_size) {
c0de031a:	b580      	push	{r7, lr}
    uint8_t copy_size = MIN(dst_size, ADDRESS_LENGTH);
c0de031c:	2a14      	cmp	r2, #20
c0de031e:	bf28      	it	cs
c0de0320:	2214      	movcs	r2, #20
    memmove(dst, parameter + PARAMETER_LENGTH - copy_size, copy_size);
c0de0322:	1a89      	subs	r1, r1, r2
c0de0324:	3120      	adds	r1, #32
c0de0326:	f000 fcd2 	bl	c0de0cce <__aeabi_memmove>
}
c0de032a:	bd80      	pop	{r7, pc}

c0de032c <U2BE_from_parameter>:
        if (p[i]) {
c0de032c:	7802      	ldrb	r2, [r0, #0]
c0de032e:	b95a      	cbnz	r2, c0de0348 <U2BE_from_parameter+0x1c>
    for (size_t i = 0; i < n; ++i) {
c0de0330:	f100 0c01 	add.w	ip, r0, #1
c0de0334:	2200      	movs	r2, #0
c0de0336:	bf00      	nop
        if (p[i]) {
c0de0338:	f81c 3002 	ldrb.w	r3, [ip, r2]
c0de033c:	b913      	cbnz	r3, c0de0344 <U2BE_from_parameter+0x18>
    for (size_t i = 0; i < n; ++i) {
c0de033e:	3201      	adds	r2, #1
c0de0340:	2a1d      	cmp	r2, #29
c0de0342:	d1f9      	bne.n	c0de0338 <U2BE_from_parameter+0xc>
    uint8_t copy_size = MIN(dst_size, PARAMETER_LENGTH);
    memmove(dst, parameter, copy_size);
}

bool U2BE_from_parameter(const uint8_t* parameter, uint16_t* value) {
    if (allzeroes(parameter, PARAMETER_LENGTH - sizeof(uint16_t))) {
c0de0344:	2a1d      	cmp	r2, #29
c0de0346:	d201      	bcs.n	c0de034c <U2BE_from_parameter+0x20>
c0de0348:	2000      	movs	r0, #0
        *value = U2BE(parameter, PARAMETER_LENGTH - sizeof(uint16_t));
        return true;
    }

    return false;
}
c0de034a:	4770      	bx	lr
#endif

#define U2(hi,lo) ((((hi)&0xFFu)<<8) | ((lo)&0xFFu))
#define U4(hi3, hi2, lo1,lo0) ((((hi3)&0xFFu)<<24) | (((hi2)&0xFFu)<<16) | (((lo1)&0xFFu)<<8) | ((lo0)&0xFFu))
static inline uint16_t U2BE(const uint8_t *buf, size_t off) {
  return (buf[off] << 8) | buf[off + 1];
c0de034c:	7f82      	ldrb	r2, [r0, #30]
c0de034e:	7fc0      	ldrb	r0, [r0, #31]
c0de0350:	ea40 2002 	orr.w	r0, r0, r2, lsl #8
        *value = U2BE(parameter, PARAMETER_LENGTH - sizeof(uint16_t));
c0de0354:	8008      	strh	r0, [r1, #0]
c0de0356:	2001      	movs	r0, #1
}
c0de0358:	4770      	bx	lr
	...

c0de035c <handle_finalize>:
#include "lido_plugin.h"

void handle_finalize(void *parameters) {
c0de035c:	b5b0      	push	{r4, r5, r7, lr}
c0de035e:	4604      	mov	r4, r0
    ethPluginFinalize_t *msg = (ethPluginFinalize_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
c0de0360:	6885      	ldr	r5, [r0, #8]
    PRINTF("handle finalize\n");
c0de0362:	480d      	ldr	r0, [pc, #52]	; (c0de0398 <handle_finalize+0x3c>)
c0de0364:	4478      	add	r0, pc
c0de0366:	f000 fa93 	bl	c0de0890 <mcu_usb_printf>
    if (context->valid) {
c0de036a:	f895 0080 	ldrb.w	r0, [r5, #128]	; 0x80
c0de036e:	b128      	cbz	r0, c0de037c <handle_finalize+0x20>
       switch (context->selectorIndex) {
c0de0370:	f895 007f 	ldrb.w	r0, [r5, #127]	; 0x7f
c0de0374:	2803      	cmp	r0, #3
c0de0376:	d207      	bcs.n	c0de0388 <handle_finalize+0x2c>
c0de0378:	2001      	movs	r0, #1
c0de037a:	e007      	b.n	c0de038c <handle_finalize+0x30>
            break;
        }
        msg->uiType = ETH_UI_TYPE_GENERIC;
        msg->result = ETH_PLUGIN_RESULT_OK;
    } else {
        PRINTF("Invalid context\n");
c0de037c:	4807      	ldr	r0, [pc, #28]	; (c0de039c <handle_finalize+0x40>)
c0de037e:	4478      	add	r0, pc
c0de0380:	f000 fa86 	bl	c0de0890 <mcu_usb_printf>
c0de0384:	2006      	movs	r0, #6
c0de0386:	e005      	b.n	c0de0394 <handle_finalize+0x38>
       switch (context->selectorIndex) {
c0de0388:	d101      	bne.n	c0de038e <handle_finalize+0x32>
c0de038a:	2007      	movs	r0, #7
c0de038c:	7760      	strb	r0, [r4, #29]
c0de038e:	2002      	movs	r0, #2
        msg->uiType = ETH_UI_TYPE_GENERIC;
c0de0390:	7720      	strb	r0, [r4, #28]
c0de0392:	2004      	movs	r0, #4
c0de0394:	77a0      	strb	r0, [r4, #30]
        msg->result = ETH_PLUGIN_RESULT_FALLBACK;
    }
}
c0de0396:	bdb0      	pop	{r4, r5, r7, pc}
c0de0398:	00000ac8 	.word	0x00000ac8
c0de039c:	00000bdf 	.word	0x00000bdf

c0de03a0 <handle_init_contract>:
#include "lido_plugin.h"

// Called once to init.
void handle_init_contract(void *parameters) {
c0de03a0:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
c0de03a4:	4604      	mov	r4, r0
    ethPluginInitContract_t *msg = (ethPluginInitContract_t *) parameters;

    if (msg->interfaceVersion != ETH_PLUGIN_INTERFACE_VERSION_LATEST) {
c0de03a6:	7800      	ldrb	r0, [r0, #0]
c0de03a8:	2806      	cmp	r0, #6
c0de03aa:	d104      	bne.n	c0de03b6 <handle_init_contract+0x16>
        msg->result = ETH_PLUGIN_RESULT_UNAVAILABLE;
        return;
    }

    if (msg->pluginContextLength < sizeof(lido_parameters_t)) {
c0de03ac:	6920      	ldr	r0, [r4, #16]
c0de03ae:	2882      	cmp	r0, #130	; 0x82
c0de03b0:	d203      	bcs.n	c0de03ba <handle_init_contract+0x1a>
c0de03b2:	2000      	movs	r0, #0
c0de03b4:	e03f      	b.n	c0de0436 <handle_init_contract+0x96>
c0de03b6:	2001      	movs	r0, #1
c0de03b8:	e03d      	b.n	c0de0436 <handle_init_contract+0x96>
        msg->result = ETH_PLUGIN_RESULT_ERROR;
        return;
    }

    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
c0de03ba:	f8d4 800c 	ldr.w	r8, [r4, #12]
    memset(context, 0, sizeof(*context));
c0de03be:	2182      	movs	r1, #130	; 0x82
c0de03c0:	4640      	mov	r0, r8
c0de03c2:	f000 fc7f 	bl	c0de0cc4 <__aeabi_memclr>
c0de03c6:	4f20      	ldr	r7, [pc, #128]	; (c0de0448 <handle_init_contract+0xa8>)
c0de03c8:	2600      	movs	r6, #0
c0de03ca:	447f      	add	r7, pc

    for (int i = 0; i < NUM_LIDO_SELECTORS; i++) {
        if (memcmp(PIC(LIDO_SELECTORS[i]), msg->selector, SELECTOR_SIZE) == 0) {
c0de03cc:	f857 0026 	ldr.w	r0, [r7, r6, lsl #2]
c0de03d0:	f000 fbfe 	bl	c0de0bd0 <pic>
c0de03d4:	7802      	ldrb	r2, [r0, #0]
c0de03d6:	7883      	ldrb	r3, [r0, #2]
c0de03d8:	78c5      	ldrb	r5, [r0, #3]
c0de03da:	7840      	ldrb	r0, [r0, #1]
c0de03dc:	6961      	ldr	r1, [r4, #20]
c0de03de:	ea43 2305 	orr.w	r3, r3, r5, lsl #8
c0de03e2:	ea42 2000 	orr.w	r0, r2, r0, lsl #8
c0de03e6:	ea40 4003 	orr.w	r0, r0, r3, lsl #16
c0de03ea:	780a      	ldrb	r2, [r1, #0]
c0de03ec:	788b      	ldrb	r3, [r1, #2]
c0de03ee:	78cd      	ldrb	r5, [r1, #3]
c0de03f0:	7849      	ldrb	r1, [r1, #1]
c0de03f2:	ea43 2305 	orr.w	r3, r3, r5, lsl #8
c0de03f6:	ea42 2101 	orr.w	r1, r2, r1, lsl #8
c0de03fa:	ea41 4103 	orr.w	r1, r1, r3, lsl #16
c0de03fe:	4288      	cmp	r0, r1
c0de0400:	d005      	beq.n	c0de040e <handle_init_contract+0x6e>
    for (int i = 0; i < NUM_LIDO_SELECTORS; i++) {
c0de0402:	3601      	adds	r6, #1
c0de0404:	2e04      	cmp	r6, #4
c0de0406:	d1e1      	bne.n	c0de03cc <handle_init_contract+0x2c>
            break;
        }
    }

    // Set `next_param` to be the first field we expect to parse.
    switch (context->selectorIndex) {
c0de0408:	f898 607f 	ldrb.w	r6, [r8, #127]	; 0x7f
c0de040c:	e001      	b.n	c0de0412 <handle_init_contract+0x72>
            context->selectorIndex = i;
c0de040e:	f888 607f 	strb.w	r6, [r8, #127]	; 0x7f
    switch (context->selectorIndex) {
c0de0412:	b2f0      	uxtb	r0, r6
c0de0414:	1e41      	subs	r1, r0, #1
c0de0416:	2902      	cmp	r1, #2
c0de0418:	d304      	bcc.n	c0de0424 <handle_init_contract+0x84>
c0de041a:	b128      	cbz	r0, c0de0428 <handle_init_contract+0x88>
c0de041c:	2803      	cmp	r0, #3
c0de041e:	d10d      	bne.n	c0de043c <handle_init_contract+0x9c>
c0de0420:	200b      	movs	r0, #11
c0de0422:	e002      	b.n	c0de042a <handle_init_contract+0x8a>
c0de0424:	2000      	movs	r0, #0
c0de0426:	e000      	b.n	c0de042a <handle_init_contract+0x8a>
c0de0428:	2009      	movs	r0, #9
c0de042a:	f888 007e 	strb.w	r0, [r8, #126]	; 0x7e
c0de042e:	2001      	movs	r0, #1
            PRINTF("Missing selectorIndex\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    context->valid = true;
c0de0430:	f888 0080 	strb.w	r0, [r8, #128]	; 0x80
c0de0434:	2004      	movs	r0, #4
c0de0436:	7060      	strb	r0, [r4, #1]
    msg->result = ETH_PLUGIN_RESULT_OK;
}
c0de0438:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
            PRINTF("Missing selectorIndex\n");
c0de043c:	4803      	ldr	r0, [pc, #12]	; (c0de044c <handle_init_contract+0xac>)
c0de043e:	4478      	add	r0, pc
c0de0440:	f000 fa26 	bl	c0de0890 <mcu_usb_printf>
c0de0444:	e7b5      	b.n	c0de03b2 <handle_init_contract+0x12>
c0de0446:	bf00      	nop
c0de0448:	00000bde 	.word	0x00000bde
c0de044c:	00000a2c 	.word	0x00000a2c

c0de0450 <handle_provide_parameter>:
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

void handle_provide_parameter(void *parameters) {
c0de0450:	b5f0      	push	{r4, r5, r6, r7, lr}
c0de0452:	b081      	sub	sp, #4
c0de0454:	4605      	mov	r5, r0
    ethPluginProvideParameter_t *msg = (ethPluginProvideParameter_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
c0de0456:	e9d0 4302 	ldrd	r4, r3, [r0, #8]
    PRINTF("plugin provide parameter %d %.*H\n",
           msg->parameterOffset,
c0de045a:	6901      	ldr	r1, [r0, #16]
    PRINTF("plugin provide parameter %d %.*H\n",
c0de045c:	487f      	ldr	r0, [pc, #508]	; (c0de065c <handle_provide_parameter+0x20c>)
c0de045e:	2220      	movs	r2, #32
c0de0460:	4478      	add	r0, pc
c0de0462:	f000 fa15 	bl	c0de0890 <mcu_usb_printf>
           PARAMETER_LENGTH,
           msg->parameter);

    msg->result = ETH_PLUGIN_RESULT_OK;

    if (context->skip) {
c0de0466:	f894 007c 	ldrb.w	r0, [r4, #124]	; 0x7c
c0de046a:	2104      	movs	r1, #4
    msg->result = ETH_PLUGIN_RESULT_OK;
c0de046c:	7529      	strb	r1, [r5, #20]
    if (context->skip) {
c0de046e:	b110      	cbz	r0, c0de0476 <handle_provide_parameter+0x26>
        // Skip this step, and don't forget to decrease skipping counter.
        context->skip--;
c0de0470:	3801      	subs	r0, #1
c0de0472:	f884 007c 	strb.w	r0, [r4, #124]	; 0x7c
    }
    if ((context->offset) &&
c0de0476:	f8b4 1074 	ldrh.w	r1, [r4, #116]	; 0x74
c0de047a:	b131      	cbz	r1, c0de048a <handle_provide_parameter+0x3a>
            msg->parameterOffset != context->checkpoint + context->offset + SELECTOR_SIZE) {
c0de047c:	f8b4 2076 	ldrh.w	r2, [r4, #118]	; 0x76
c0de0480:	692b      	ldr	r3, [r5, #16]
c0de0482:	1888      	adds	r0, r1, r2
c0de0484:	3004      	adds	r0, #4
    if ((context->offset) &&
c0de0486:	4283      	cmp	r3, r0
c0de0488:	d112      	bne.n	c0de04b0 <handle_provide_parameter+0x60>
                   msg->parameterOffset);
            return;
        }
    context->offset = 0;  // Reset offset

    switch (context->selectorIndex) {
c0de048a:	f894 107f 	ldrb.w	r1, [r4, #127]	; 0x7f
c0de048e:	2000      	movs	r0, #0
c0de0490:	1e4a      	subs	r2, r1, #1
c0de0492:	2a02      	cmp	r2, #2
    context->offset = 0;  // Reset offset
c0de0494:	f8a4 0074 	strh.w	r0, [r4, #116]	; 0x74
    switch (context->selectorIndex) {
c0de0498:	d311      	bcc.n	c0de04be <handle_provide_parameter+0x6e>
c0de049a:	2903      	cmp	r1, #3
c0de049c:	d017      	beq.n	c0de04ce <handle_provide_parameter+0x7e>
c0de049e:	bb61      	cbnz	r1, c0de04fa <handle_provide_parameter+0xaa>
    if (context->next_param == REFERRAL) {
c0de04a0:	f894 007e 	ldrb.w	r0, [r4, #126]	; 0x7e
c0de04a4:	2809      	cmp	r0, #9
c0de04a6:	d13f      	bne.n	c0de0528 <handle_provide_parameter+0xd8>
c0de04a8:	200a      	movs	r0, #10
        context->next_param = NONE;
c0de04aa:	f884 007e 	strb.w	r0, [r4, #126]	; 0x7e
c0de04ae:	e041      	b.n	c0de0534 <handle_provide_parameter+0xe4>
            PRINTF("offset: %d, checkpoint: %d, parameterOffset: %d\n",
c0de04b0:	486e      	ldr	r0, [pc, #440]	; (c0de066c <handle_provide_parameter+0x21c>)
c0de04b2:	4478      	add	r0, pc
c0de04b4:	b001      	add	sp, #4
c0de04b6:	e8bd 40f0 	ldmia.w	sp!, {r4, r5, r6, r7, lr}
c0de04ba:	f000 b9e9 	b.w	c0de0890 <mcu_usb_printf>
    switch (context->next_param) {
c0de04be:	f894 007e 	ldrb.w	r0, [r4, #126]	; 0x7e
c0de04c2:	b308      	cbz	r0, c0de0508 <handle_provide_parameter+0xb8>
c0de04c4:	4867      	ldr	r0, [pc, #412]	; (c0de0664 <handle_provide_parameter+0x214>)
c0de04c6:	4478      	add	r0, pc
c0de04c8:	f000 f9e2 	bl	c0de0890 <mcu_usb_printf>
c0de04cc:	e019      	b.n	c0de0502 <handle_provide_parameter+0xb2>
    switch (context->next_param) {
c0de04ce:	f894 707e 	ldrb.w	r7, [r4, #126]	; 0x7e
c0de04d2:	2f04      	cmp	r7, #4
c0de04d4:	dc43      	bgt.n	c0de055e <handle_provide_parameter+0x10e>
c0de04d6:	2f01      	cmp	r7, #1
c0de04d8:	dd57      	ble.n	c0de058a <handle_provide_parameter+0x13a>
c0de04da:	2f02      	cmp	r7, #2
c0de04dc:	f000 8083 	beq.w	c0de05e6 <handle_provide_parameter+0x196>
c0de04e0:	2f03      	cmp	r7, #3
c0de04e2:	f000 8097 	beq.w	c0de0614 <handle_provide_parameter+0x1c4>
c0de04e6:	2f04      	cmp	r7, #4
c0de04e8:	d1ec      	bne.n	c0de04c4 <handle_provide_parameter+0x74>
                 msg->parameter,
c0de04ea:	68e9      	ldr	r1, [r5, #12]
    copy_address(context->address_sent,
c0de04ec:	f104 0040 	add.w	r0, r4, #64	; 0x40
c0de04f0:	2214      	movs	r2, #20
c0de04f2:	f7ff ff12 	bl	c0de031a <copy_address>
c0de04f6:	2000      	movs	r0, #0
c0de04f8:	e013      	b.n	c0de0522 <handle_provide_parameter+0xd2>
            break;
        case REQUEST_WITHDRAWALS_WITH_PERMIT:
            handle_permit(msg, context);
            break;
        default:
            PRINTF("Selector Index %d not supported\n", context->selectorIndex);
c0de04fa:	485b      	ldr	r0, [pc, #364]	; (c0de0668 <handle_provide_parameter+0x218>)
c0de04fc:	4478      	add	r0, pc
c0de04fe:	f000 f9c7 	bl	c0de0890 <mcu_usb_printf>
c0de0502:	2000      	movs	r0, #0
c0de0504:	7528      	strb	r0, [r5, #20]
c0de0506:	e028      	b.n	c0de055a <handle_provide_parameter+0x10a>
    memset(context->amount_sent, 0, sizeof(context->amount_sent));
c0de0508:	4620      	mov	r0, r4
c0de050a:	2120      	movs	r1, #32
c0de050c:	2620      	movs	r6, #32
c0de050e:	f000 fbd9 	bl	c0de0cc4 <__aeabi_memclr>
    memcpy(context->amount_sent, msg->parameter, PARAMETER_LENGTH);
c0de0512:	68e9      	ldr	r1, [r5, #12]
c0de0514:	4620      	mov	r0, r4
c0de0516:	2220      	movs	r2, #32
c0de0518:	f000 fbd7 	bl	c0de0cca <__aeabi_memcpy>
c0de051c:	200a      	movs	r0, #10
c0de051e:	f884 607d 	strb.w	r6, [r4, #125]	; 0x7d
c0de0522:	f884 007e 	strb.w	r0, [r4, #126]	; 0x7e
c0de0526:	e018      	b.n	c0de055a <handle_provide_parameter+0x10a>
        PRINTF("Param not supported\n");
c0de0528:	484d      	ldr	r0, [pc, #308]	; (c0de0660 <handle_provide_parameter+0x210>)
c0de052a:	4478      	add	r0, pc
c0de052c:	f000 f9b0 	bl	c0de0890 <mcu_usb_printf>
c0de0530:	2000      	movs	r0, #0
        msg->result = ETH_PLUGIN_RESULT_ERROR;
c0de0532:	7528      	strb	r0, [r5, #20]
    memset(context->amount_sent, 0, sizeof(context->amount_sent));
c0de0534:	4620      	mov	r0, r4
c0de0536:	2120      	movs	r1, #32
c0de0538:	f000 fbc4 	bl	c0de0cc4 <__aeabi_memclr>
           &msg->pluginSharedRO->txContent->value.value,
c0de053c:	6868      	ldr	r0, [r5, #4]
c0de053e:	6800      	ldr	r0, [r0, #0]
           msg->pluginSharedRO->txContent->value.length);
c0de0540:	f890 2062 	ldrb.w	r2, [r0, #98]	; 0x62
    memcpy(context->amount_sent,
c0de0544:	f100 0142 	add.w	r1, r0, #66	; 0x42
c0de0548:	4620      	mov	r0, r4
c0de054a:	f000 fbbe 	bl	c0de0cca <__aeabi_memcpy>
    context->amount_length = msg->pluginSharedRO->txContent->value.length;
c0de054e:	6868      	ldr	r0, [r5, #4]
c0de0550:	6800      	ldr	r0, [r0, #0]
c0de0552:	f890 0062 	ldrb.w	r0, [r0, #98]	; 0x62
c0de0556:	f884 007d 	strb.w	r0, [r4, #125]	; 0x7d
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
c0de055a:	b001      	add	sp, #4
c0de055c:	bdf0      	pop	{r4, r5, r6, r7, pc}
    switch (context->next_param) {
c0de055e:	2f06      	cmp	r7, #6
c0de0560:	dd25      	ble.n	c0de05ae <handle_provide_parameter+0x15e>
c0de0562:	1ff8      	subs	r0, r7, #7
c0de0564:	2802      	cmp	r0, #2
c0de0566:	d233      	bcs.n	c0de05d0 <handle_provide_parameter+0x180>
   memset(context->bytes, 0, sizeof(context->bytes));
c0de0568:	f104 0654 	add.w	r6, r4, #84	; 0x54
c0de056c:	4630      	mov	r0, r6
c0de056e:	2120      	movs	r1, #32
c0de0570:	f000 fba8 	bl	c0de0cc4 <__aeabi_memclr>
   memcpy(context->bytes, msg->parameter, PARAMETER_LENGTH);
c0de0574:	68e9      	ldr	r1, [r5, #12]
c0de0576:	4630      	mov	r0, r6
c0de0578:	2220      	movs	r2, #32
c0de057a:	f000 fba6 	bl	c0de0cca <__aeabi_memcpy>
            if(context->next_param == PERMIT_R) {
c0de057e:	2f07      	cmp	r7, #7
c0de0580:	bf04      	itt	eq
c0de0582:	2008      	moveq	r0, #8
                context->next_param = PERMIT_S;
c0de0584:	f884 007e 	strbeq.w	r0, [r4, #126]	; 0x7e
c0de0588:	e7e7      	b.n	c0de055a <handle_provide_parameter+0x10a>
    switch (context->next_param) {
c0de058a:	2f00      	cmp	r7, #0
c0de058c:	d04d      	beq.n	c0de062a <handle_provide_parameter+0x1da>
c0de058e:	2f01      	cmp	r7, #1
c0de0590:	d198      	bne.n	c0de04c4 <handle_provide_parameter+0x74>
            if (!U2BE_from_parameter(msg->parameter, &(context->array_len)) &&
c0de0592:	68e8      	ldr	r0, [r5, #12]
c0de0594:	f104 017a 	add.w	r1, r4, #122	; 0x7a
c0de0598:	f7ff fec8 	bl	c0de032c <U2BE_from_parameter>
c0de059c:	f8b4 107a 	ldrh.w	r1, [r4, #122]	; 0x7a
c0de05a0:	b908      	cbnz	r0, c0de05a6 <handle_provide_parameter+0x156>
c0de05a2:	2900      	cmp	r1, #0
c0de05a4:	d0ad      	beq.n	c0de0502 <handle_provide_parameter+0xb2>
c0de05a6:	2002      	movs	r0, #2
            context->tmp_len = context->array_len;
c0de05a8:	f8a4 1078 	strh.w	r1, [r4, #120]	; 0x78
c0de05ac:	e7b9      	b.n	c0de0522 <handle_provide_parameter+0xd2>
    switch (context->next_param) {
c0de05ae:	2f05      	cmp	r7, #5
c0de05b0:	d047      	beq.n	c0de0642 <handle_provide_parameter+0x1f2>
c0de05b2:	2f06      	cmp	r7, #6
c0de05b4:	f47f af86 	bne.w	c0de04c4 <handle_provide_parameter+0x74>
    memset(context->amount_sent, 0, sizeof(context->amount_sent));
c0de05b8:	4620      	mov	r0, r4
c0de05ba:	2120      	movs	r1, #32
c0de05bc:	2620      	movs	r6, #32
c0de05be:	f000 fb81 	bl	c0de0cc4 <__aeabi_memclr>
    memcpy(context->amount_sent, msg->parameter, PARAMETER_LENGTH);
c0de05c2:	68e9      	ldr	r1, [r5, #12]
c0de05c4:	4620      	mov	r0, r4
c0de05c6:	2220      	movs	r2, #32
c0de05c8:	f000 fb7f 	bl	c0de0cca <__aeabi_memcpy>
c0de05cc:	2007      	movs	r0, #7
c0de05ce:	e7a6      	b.n	c0de051e <handle_provide_parameter+0xce>
    switch (context->next_param) {
c0de05d0:	2f0b      	cmp	r7, #11
c0de05d2:	f47f af77 	bne.w	c0de04c4 <handle_provide_parameter+0x74>
            context->offset = U2BE(msg->parameter, PARAMETER_LENGTH - sizeof(context->offset));
c0de05d6:	68e8      	ldr	r0, [r5, #12]
c0de05d8:	7f81      	ldrb	r1, [r0, #30]
c0de05da:	7fc0      	ldrb	r0, [r0, #31]
c0de05dc:	ea40 2001 	orr.w	r0, r0, r1, lsl #8
c0de05e0:	f8a4 0074 	strh.w	r0, [r4, #116]	; 0x74
c0de05e4:	e014      	b.n	c0de0610 <handle_provide_parameter+0x1c0>
            context->tmp_len--;
c0de05e6:	f8b4 0078 	ldrh.w	r0, [r4, #120]	; 0x78
            memset(context->amount_sent, 0, sizeof(context->amount_sent));
c0de05ea:	2120      	movs	r1, #32
            context->tmp_len--;
c0de05ec:	1e46      	subs	r6, r0, #1
            memset(context->amount_sent, 0, sizeof(context->amount_sent));
c0de05ee:	4620      	mov	r0, r4
            context->tmp_len--;
c0de05f0:	f8a4 6078 	strh.w	r6, [r4, #120]	; 0x78
            memset(context->amount_sent, 0, sizeof(context->amount_sent));
c0de05f4:	f000 fb66 	bl	c0de0cc4 <__aeabi_memclr>
            if (!memcpy(context->amount_sent, msg->parameter, PARAMETER_LENGTH)) {
c0de05f8:	68e9      	ldr	r1, [r5, #12]
c0de05fa:	4620      	mov	r0, r4
c0de05fc:	2220      	movs	r2, #32
c0de05fe:	f000 fb64 	bl	c0de0cca <__aeabi_memcpy>
            if (context->tmp_len == 0) {
c0de0602:	0430      	lsls	r0, r6, #16
c0de0604:	d004      	beq.n	c0de0610 <handle_provide_parameter+0x1c0>
                context->skip = context->tmp_len - 1;
c0de0606:	1e70      	subs	r0, r6, #1
c0de0608:	f884 007c 	strb.w	r0, [r4, #124]	; 0x7c
c0de060c:	2003      	movs	r0, #3
c0de060e:	e788      	b.n	c0de0522 <handle_provide_parameter+0xd2>
c0de0610:	2001      	movs	r0, #1
c0de0612:	e786      	b.n	c0de0522 <handle_provide_parameter+0xd2>
            memset(context->amount_sent, 0, sizeof(context->amount_sent));
c0de0614:	4620      	mov	r0, r4
c0de0616:	2120      	movs	r1, #32
c0de0618:	f000 fb54 	bl	c0de0cc4 <__aeabi_memclr>
            if (!memcpy(context->amount_sent, msg->parameter, PARAMETER_LENGTH)) {
c0de061c:	68e9      	ldr	r1, [r5, #12]
c0de061e:	4620      	mov	r0, r4
c0de0620:	2220      	movs	r2, #32
c0de0622:	f000 fb52 	bl	c0de0cca <__aeabi_memcpy>
c0de0626:	2004      	movs	r0, #4
c0de0628:	e77b      	b.n	c0de0522 <handle_provide_parameter+0xd2>
    memset(context->amount_sent, 0, sizeof(context->amount_sent));
c0de062a:	4620      	mov	r0, r4
c0de062c:	2120      	movs	r1, #32
c0de062e:	2620      	movs	r6, #32
c0de0630:	f000 fb48 	bl	c0de0cc4 <__aeabi_memclr>
    memcpy(context->amount_sent, msg->parameter, PARAMETER_LENGTH);
c0de0634:	68e9      	ldr	r1, [r5, #12]
c0de0636:	4620      	mov	r0, r4
c0de0638:	2220      	movs	r2, #32
c0de063a:	f000 fb46 	bl	c0de0cca <__aeabi_memcpy>
c0de063e:	2005      	movs	r0, #5
c0de0640:	e76d      	b.n	c0de051e <handle_provide_parameter+0xce>
    memset(context->amount_sent, 0, sizeof(context->amount_sent));
c0de0642:	4620      	mov	r0, r4
c0de0644:	2120      	movs	r1, #32
c0de0646:	2620      	movs	r6, #32
c0de0648:	f000 fb3c 	bl	c0de0cc4 <__aeabi_memclr>
    memcpy(context->amount_sent, msg->parameter, PARAMETER_LENGTH);
c0de064c:	68e9      	ldr	r1, [r5, #12]
c0de064e:	4620      	mov	r0, r4
c0de0650:	2220      	movs	r2, #32
c0de0652:	f000 fb3a 	bl	c0de0cca <__aeabi_memcpy>
c0de0656:	2006      	movs	r0, #6
c0de0658:	e761      	b.n	c0de051e <handle_provide_parameter+0xce>
c0de065a:	bf00      	nop
c0de065c:	00000975 	.word	0x00000975
c0de0660:	0000086e 	.word	0x0000086e
c0de0664:	000008d2 	.word	0x000008d2
c0de0668:	00000a79 	.word	0x00000a79
c0de066c:	00000945 	.word	0x00000945

c0de0670 <handle_provide_token>:
#include "lido_plugin.h"

void handle_provide_token(void *parameters) {
c0de0670:	b510      	push	{r4, lr}
c0de0672:	4604      	mov	r4, r0
    ethPluginProvideInfo_t *msg = (ethPluginProvideInfo_t *) parameters;
    PRINTF("plugin provide token: 0x%p, 0x%p\n", msg->item1, msg->item2);
c0de0674:	e9d0 1203 	ldrd	r1, r2, [r0, #12]
c0de0678:	4803      	ldr	r0, [pc, #12]	; (c0de0688 <handle_provide_token+0x18>)
c0de067a:	4478      	add	r0, pc
c0de067c:	f000 f908 	bl	c0de0890 <mcu_usb_printf>
c0de0680:	2004      	movs	r0, #4

    msg->result = ETH_PLUGIN_RESULT_OK;
c0de0682:	7560      	strb	r0, [r4, #21]
}
c0de0684:	bd10      	pop	{r4, pc}
c0de0686:	bf00      	nop
c0de0688:	00000807 	.word	0x00000807

c0de068c <handle_query_contract_id>:
#include "lido_plugin.h"

void handle_query_contract_id(void *parameters) {
c0de068c:	b5b0      	push	{r4, r5, r7, lr}
c0de068e:	4604      	mov	r4, r0
    ethQueryContractID_t *msg = (ethQueryContractID_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
c0de0690:	e9d0 5002 	ldrd	r5, r0, [r0, #8]

    strlcpy(msg->name, PLUGIN_NAME, msg->nameLength);
c0de0694:	6922      	ldr	r2, [r4, #16]
c0de0696:	4913      	ldr	r1, [pc, #76]	; (c0de06e4 <handle_query_contract_id+0x58>)
c0de0698:	4479      	add	r1, pc
c0de069a:	f000 fb5d 	bl	c0de0d58 <strlcpy>

    switch (context->selectorIndex) {
c0de069e:	f895 107f 	ldrb.w	r1, [r5, #127]	; 0x7f
c0de06a2:	2901      	cmp	r1, #1
c0de06a4:	dc05      	bgt.n	c0de06b2 <handle_query_contract_id+0x26>
c0de06a6:	b189      	cbz	r1, c0de06cc <handle_query_contract_id+0x40>
c0de06a8:	2901      	cmp	r1, #1
c0de06aa:	d109      	bne.n	c0de06c0 <handle_query_contract_id+0x34>
c0de06ac:	4911      	ldr	r1, [pc, #68]	; (c0de06f4 <handle_query_contract_id+0x68>)
c0de06ae:	4479      	add	r1, pc
c0de06b0:	e011      	b.n	c0de06d6 <handle_query_contract_id+0x4a>
c0de06b2:	2902      	cmp	r1, #2
c0de06b4:	d00d      	beq.n	c0de06d2 <handle_query_contract_id+0x46>
c0de06b6:	2903      	cmp	r1, #3
c0de06b8:	d102      	bne.n	c0de06c0 <handle_query_contract_id+0x34>
c0de06ba:	490c      	ldr	r1, [pc, #48]	; (c0de06ec <handle_query_contract_id+0x60>)
c0de06bc:	4479      	add	r1, pc
c0de06be:	e00a      	b.n	c0de06d6 <handle_query_contract_id+0x4a>
            break;
        case REQUEST_WITHDRAWALS_WITH_PERMIT:
            strlcpy(msg->version, "Request withdrawals with permit", msg->versionLength);
            break;
        default:
            PRINTF("Selector Index :%d not supported\n", context->selectorIndex);
c0de06c0:	480b      	ldr	r0, [pc, #44]	; (c0de06f0 <handle_query_contract_id+0x64>)
c0de06c2:	4478      	add	r0, pc
c0de06c4:	f000 f8e4 	bl	c0de0890 <mcu_usb_printf>
c0de06c8:	2000      	movs	r0, #0
c0de06ca:	e009      	b.n	c0de06e0 <handle_query_contract_id+0x54>
c0de06cc:	4906      	ldr	r1, [pc, #24]	; (c0de06e8 <handle_query_contract_id+0x5c>)
c0de06ce:	4479      	add	r1, pc
c0de06d0:	e001      	b.n	c0de06d6 <handle_query_contract_id+0x4a>
c0de06d2:	4909      	ldr	r1, [pc, #36]	; (c0de06f8 <handle_query_contract_id+0x6c>)
c0de06d4:	4479      	add	r1, pc
c0de06d6:	e9d4 0205 	ldrd	r0, r2, [r4, #20]
c0de06da:	f000 fb3d 	bl	c0de0d58 <strlcpy>
c0de06de:	2004      	movs	r0, #4
c0de06e0:	7720      	strb	r0, [r4, #28]
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    msg->result = ETH_PLUGIN_RESULT_OK;
c0de06e2:	bdb0      	pop	{r4, r5, r7, pc}
c0de06e4:	00000841 	.word	0x00000841
c0de06e8:	000006ea 	.word	0x000006ea
c0de06ec:	000007e7 	.word	0x000007e7
c0de06f0:	0000085b 	.word	0x0000085b
c0de06f4:	00000849 	.word	0x00000849
c0de06f8:	0000089a 	.word	0x0000089a

c0de06fc <handle_query_contract_ui>:
                   ticker,
                   msg->msg,
                   msg->msgLength);
}

void handle_query_contract_ui(void *parameters) {
c0de06fc:	b5b0      	push	{r4, r5, r7, lr}
c0de06fe:	4604      	mov	r4, r0
    ethQueryContractUI_t *msg = (ethQueryContractUI_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
c0de0700:	69c5      	ldr	r5, [r0, #28]

    memset(msg->title, 0, msg->titleLength);
c0de0702:	6a40      	ldr	r0, [r0, #36]	; 0x24
c0de0704:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0de0706:	f000 fadd 	bl	c0de0cc4 <__aeabi_memclr>
    memset(msg->msg, 0, msg->msgLength);
c0de070a:	e9d4 010b 	ldrd	r0, r1, [r4, #44]	; 0x2c
c0de070e:	f000 fad9 	bl	c0de0cc4 <__aeabi_memclr>
    msg->result = ETH_PLUGIN_RESULT_OK;

    switch (context->selectorIndex) {
c0de0712:	f895 007f 	ldrb.w	r0, [r5, #127]	; 0x7f
c0de0716:	2104      	movs	r1, #4
c0de0718:	2803      	cmp	r0, #3
    msg->result = ETH_PLUGIN_RESULT_OK;
c0de071a:	f884 1034 	strb.w	r1, [r4, #52]	; 0x34
    switch (context->selectorIndex) {
c0de071e:	d204      	bcs.n	c0de072a <handle_query_contract_ui+0x2e>
        case SUBMIT:
        case WRAP:
        case UNWRAP:
            set_send_ui(msg, context);
c0de0720:	4620      	mov	r0, r4
c0de0722:	4629      	mov	r1, r5
c0de0724:	f000 f81c 	bl	c0de0760 <set_send_ui>
c0de0728:	e000      	b.n	c0de072c <handle_query_contract_ui+0x30>
    switch (context->selectorIndex) {
c0de072a:	d10d      	bne.n	c0de0748 <handle_query_contract_ui+0x4c>
            PRINTF("Received an invalid screenIndex\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    if (msg->screenIndex == 0) {
c0de072c:	f894 1020 	ldrb.w	r1, [r4, #32]
c0de0730:	b121      	cbz	r1, c0de073c <handle_query_contract_ui+0x40>
        set_send_ui(msg, context);
    } else {
        PRINTF("Screen %d not supported\n", msg->screenIndex);
c0de0732:	480a      	ldr	r0, [pc, #40]	; (c0de075c <handle_query_contract_ui+0x60>)
c0de0734:	4478      	add	r0, pc
c0de0736:	f000 f8ab 	bl	c0de0890 <mcu_usb_printf>
c0de073a:	e009      	b.n	c0de0750 <handle_query_contract_ui+0x54>
        set_send_ui(msg, context);
c0de073c:	4620      	mov	r0, r4
c0de073e:	4629      	mov	r1, r5
c0de0740:	e8bd 40b0 	ldmia.w	sp!, {r4, r5, r7, lr}
c0de0744:	f000 b80c 	b.w	c0de0760 <set_send_ui>
            PRINTF("Received an invalid screenIndex\n");
c0de0748:	4803      	ldr	r0, [pc, #12]	; (c0de0758 <handle_query_contract_ui+0x5c>)
c0de074a:	4478      	add	r0, pc
c0de074c:	f000 f8a0 	bl	c0de0890 <mcu_usb_printf>
c0de0750:	2000      	movs	r0, #0
c0de0752:	f884 0034 	strb.w	r0, [r4, #52]	; 0x34
        msg->result = ETH_PLUGIN_RESULT_ERROR;
    }
}
c0de0756:	bdb0      	pop	{r4, r5, r7, pc}
c0de0758:	000007b2 	.word	0x000007b2
c0de075c:	000007aa 	.word	0x000007aa

c0de0760 <set_send_ui>:
static void set_send_ui(ethQueryContractUI_t *msg, lido_parameters_t *context) {
c0de0760:	b570      	push	{r4, r5, r6, lr}
c0de0762:	b082      	sub	sp, #8
c0de0764:	460c      	mov	r4, r1
    switch (context->selectorIndex) {
c0de0766:	f891 107f 	ldrb.w	r1, [r1, #127]	; 0x7f
c0de076a:	4605      	mov	r5, r0
c0de076c:	b141      	cbz	r1, c0de0780 <set_send_ui+0x20>
c0de076e:	2901      	cmp	r1, #1
c0de0770:	d00b      	beq.n	c0de078a <set_send_ui+0x2a>
c0de0772:	2902      	cmp	r1, #2
c0de0774:	d11d      	bne.n	c0de07b2 <set_send_ui+0x52>
c0de0776:	4e15      	ldr	r6, [pc, #84]	; (c0de07cc <set_send_ui+0x6c>)
c0de0778:	4915      	ldr	r1, [pc, #84]	; (c0de07d0 <set_send_ui+0x70>)
c0de077a:	447e      	add	r6, pc
c0de077c:	4479      	add	r1, pc
c0de077e:	e008      	b.n	c0de0792 <set_send_ui+0x32>
c0de0780:	4e10      	ldr	r6, [pc, #64]	; (c0de07c4 <set_send_ui+0x64>)
c0de0782:	4911      	ldr	r1, [pc, #68]	; (c0de07c8 <set_send_ui+0x68>)
c0de0784:	447e      	add	r6, pc
c0de0786:	4479      	add	r1, pc
c0de0788:	e003      	b.n	c0de0792 <set_send_ui+0x32>
c0de078a:	4e13      	ldr	r6, [pc, #76]	; (c0de07d8 <set_send_ui+0x78>)
c0de078c:	4913      	ldr	r1, [pc, #76]	; (c0de07dc <set_send_ui+0x7c>)
c0de078e:	447e      	add	r6, pc
c0de0790:	4479      	add	r1, pc
c0de0792:	e9d5 0209 	ldrd	r0, r2, [r5, #36]	; 0x24
c0de0796:	f000 fadf 	bl	c0de0d58 <strlcpy>
                   msg->msg,
c0de079a:	e9d5 050b 	ldrd	r0, r5, [r5, #44]	; 0x2c
                   context->amount_length,
c0de079e:	f894 107d 	ldrb.w	r1, [r4, #125]	; 0x7d
    amountToString(context->amount_sent,
c0de07a2:	9000      	str	r0, [sp, #0]
c0de07a4:	4620      	mov	r0, r4
c0de07a6:	2212      	movs	r2, #18
c0de07a8:	4633      	mov	r3, r6
c0de07aa:	9501      	str	r5, [sp, #4]
c0de07ac:	f7ff fd6e 	bl	c0de028c <amountToString>
c0de07b0:	e006      	b.n	c0de07c0 <set_send_ui+0x60>
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
c0de07b2:	4808      	ldr	r0, [pc, #32]	; (c0de07d4 <set_send_ui+0x74>)
c0de07b4:	4478      	add	r0, pc
c0de07b6:	f000 f86b 	bl	c0de0890 <mcu_usb_printf>
c0de07ba:	2000      	movs	r0, #0
            msg->result = ETH_PLUGIN_RESULT_ERROR;
c0de07bc:	f885 0034 	strb.w	r0, [r5, #52]	; 0x34
}
c0de07c0:	b002      	add	sp, #8
c0de07c2:	bd70      	pop	{r4, r5, r6, pc}
c0de07c4:	000006a4 	.word	0x000006a4
c0de07c8:	00000632 	.word	0x00000632
c0de07cc:	000006c9 	.word	0x000006c9
c0de07d0:	000007f2 	.word	0x000007f2
c0de07d4:	0000078b 	.word	0x0000078b
c0de07d8:	000006af 	.word	0x000006af
c0de07dc:	00000767 	.word	0x00000767

c0de07e0 <dispatch_plugin_calls>:
void dispatch_plugin_calls(int message, void *parameters) {
c0de07e0:	4602      	mov	r2, r0
    switch (message) {
c0de07e2:	f5b0 7f82 	cmp.w	r0, #260	; 0x104
c0de07e6:	da0d      	bge.n	c0de0804 <dispatch_plugin_calls+0x24>
c0de07e8:	f240 1001 	movw	r0, #257	; 0x101
c0de07ec:	4282      	cmp	r2, r0
c0de07ee:	d014      	beq.n	c0de081a <dispatch_plugin_calls+0x3a>
c0de07f0:	f5b2 7f81 	cmp.w	r2, #258	; 0x102
c0de07f4:	d014      	beq.n	c0de0820 <dispatch_plugin_calls+0x40>
c0de07f6:	f240 1003 	movw	r0, #259	; 0x103
c0de07fa:	4282      	cmp	r2, r0
c0de07fc:	d119      	bne.n	c0de0832 <dispatch_plugin_calls+0x52>
            handle_finalize(parameters);
c0de07fe:	4608      	mov	r0, r1
c0de0800:	f7ff bdac 	b.w	c0de035c <handle_finalize>
    switch (message) {
c0de0804:	d00f      	beq.n	c0de0826 <dispatch_plugin_calls+0x46>
c0de0806:	f240 1005 	movw	r0, #261	; 0x105
c0de080a:	4282      	cmp	r2, r0
c0de080c:	d00e      	beq.n	c0de082c <dispatch_plugin_calls+0x4c>
c0de080e:	f5b2 7f83 	cmp.w	r2, #262	; 0x106
c0de0812:	d10e      	bne.n	c0de0832 <dispatch_plugin_calls+0x52>
            handle_query_contract_ui(parameters);
c0de0814:	4608      	mov	r0, r1
c0de0816:	f7ff bf71 	b.w	c0de06fc <handle_query_contract_ui>
            handle_init_contract(parameters);
c0de081a:	4608      	mov	r0, r1
c0de081c:	f7ff bdc0 	b.w	c0de03a0 <handle_init_contract>
            handle_provide_parameter(parameters);
c0de0820:	4608      	mov	r0, r1
c0de0822:	f7ff be15 	b.w	c0de0450 <handle_provide_parameter>
            handle_provide_token(parameters);
c0de0826:	4608      	mov	r0, r1
c0de0828:	f7ff bf22 	b.w	c0de0670 <handle_provide_token>
            handle_query_contract_id(parameters);
c0de082c:	4608      	mov	r0, r1
c0de082e:	f7ff bf2d 	b.w	c0de068c <handle_query_contract_id>
            PRINTF("Unhandled message %d\n", message);
c0de0832:	4802      	ldr	r0, [pc, #8]	; (c0de083c <dispatch_plugin_calls+0x5c>)
c0de0834:	4611      	mov	r1, r2
c0de0836:	4478      	add	r0, pc
c0de0838:	f000 b82a 	b.w	c0de0890 <mcu_usb_printf>
c0de083c:	0000068d 	.word	0x0000068d

c0de0840 <os_boot>:
#ifndef BOLOS_OS_UPGRADER_APP
void os_boot(void) {
  // // TODO patch entry point when romming (f)
  // // set the default try context to nothing
#ifndef HAVE_BOLOS
  try_context_set(NULL);
c0de0840:	2000      	movs	r0, #0
c0de0842:	f000 ba31 	b.w	c0de0ca8 <try_context_set>
	...

c0de0848 <os_longjmp>:
  }
  return xoracc;
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0de0848:	4604      	mov	r4, r0
#ifdef HAVE_PRINTF  
  unsigned int lr_val;
  __asm volatile("mov %0, lr" :"=r"(lr_val));
c0de084a:	4672      	mov	r2, lr
  PRINTF("exception[%d]: LR=0x%08X\n", exception, lr_val);
c0de084c:	4804      	ldr	r0, [pc, #16]	; (c0de0860 <os_longjmp+0x18>)
c0de084e:	4621      	mov	r1, r4
c0de0850:	4478      	add	r0, pc
c0de0852:	f000 f81d 	bl	c0de0890 <mcu_usb_printf>
#endif // HAVE_PRINTF
  longjmp(try_context_get()->jmp_buf, exception);
c0de0856:	f000 fa1d 	bl	c0de0c94 <try_context_get>
c0de085a:	4621      	mov	r1, r4
c0de085c:	f000 fa74 	bl	c0de0d48 <longjmp>
c0de0860:	000005fa 	.word	0x000005fa

c0de0864 <mcu_usb_prints>:
  return ret;
}
#endif // !defined(APP_UX)

#ifdef HAVE_PRINTF
void mcu_usb_prints(const char* str, unsigned int charcount) {
c0de0864:	b5b0      	push	{r4, r5, r7, lr}
c0de0866:	b082      	sub	sp, #8
c0de0868:	4605      	mov	r5, r0
c0de086a:	205f      	movs	r0, #95	; 0x5f
  unsigned char buf[4];
#ifdef TARGET_NANOS
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
#else
  buf[0] = SEPROXYHAL_TAG_PRINTF;
c0de086c:	f88d 0004 	strb.w	r0, [sp, #4]
#endif
  buf[1] = charcount >> 8;
c0de0870:	0a08      	lsrs	r0, r1, #8
c0de0872:	460c      	mov	r4, r1
c0de0874:	f88d 0005 	strb.w	r0, [sp, #5]
  buf[2] = charcount;
c0de0878:	f88d 1006 	strb.w	r1, [sp, #6]
c0de087c:	a801      	add	r0, sp, #4
  io_seproxyhal_spi_send(buf, 3);
c0de087e:	2103      	movs	r1, #3
c0de0880:	f000 f9fc 	bl	c0de0c7c <io_seph_send>
  io_seproxyhal_spi_send((const uint8_t *) str, charcount);
c0de0884:	b2a1      	uxth	r1, r4
c0de0886:	4628      	mov	r0, r5
c0de0888:	f000 f9f8 	bl	c0de0c7c <io_seph_send>
}
c0de088c:	b002      	add	sp, #8
c0de088e:	bdb0      	pop	{r4, r5, r7, pc}

c0de0890 <mcu_usb_printf>:
#include "usbd_def.h"
#include "usbd_core.h"

void screen_printf(const char* format, ...) __attribute__ ((weak, alias ("mcu_usb_printf")));

void mcu_usb_printf(const char* format, ...) {
c0de0890:	b083      	sub	sp, #12
c0de0892:	e92d 4df0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
c0de0896:	b089      	sub	sp, #36	; 0x24
    char cStrlenSet;

    //
    // Check the arguments.
    //
    if(format == 0) {
c0de0898:	2800      	cmp	r0, #0
c0de089a:	e9cd 1211 	strd	r1, r2, [sp, #68]	; 0x44
c0de089e:	9313      	str	r3, [sp, #76]	; 0x4c
c0de08a0:	f000 8178 	beq.w	c0de0b94 <mcu_usb_printf+0x304>
c0de08a4:	4604      	mov	r4, r0
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0de08a6:	7800      	ldrb	r0, [r0, #0]
c0de08a8:	a911      	add	r1, sp, #68	; 0x44
c0de08aa:	2800      	cmp	r0, #0
    va_start(vaArgP, format);
c0de08ac:	9103      	str	r1, [sp, #12]
    while(*format)
c0de08ae:	f000 8171 	beq.w	c0de0b94 <mcu_usb_printf+0x304>
c0de08b2:	bf00      	nop
c0de08b4:	2700      	movs	r7, #0
c0de08b6:	bf00      	nop
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0de08b8:	b130      	cbz	r0, c0de08c8 <mcu_usb_printf+0x38>
c0de08ba:	2825      	cmp	r0, #37	; 0x25
c0de08bc:	d004      	beq.n	c0de08c8 <mcu_usb_printf+0x38>
c0de08be:	19e0      	adds	r0, r4, r7
c0de08c0:	7840      	ldrb	r0, [r0, #1]
            ulIdx++)
c0de08c2:	3701      	adds	r7, #1
c0de08c4:	e7f8      	b.n	c0de08b8 <mcu_usb_printf+0x28>
c0de08c6:	bf00      	nop
        }

        //
        // Write this portion of the string.
        //
        mcu_usb_prints(format, ulIdx);
c0de08c8:	4620      	mov	r0, r4
c0de08ca:	4639      	mov	r1, r7
c0de08cc:	19e5      	adds	r5, r4, r7
c0de08ce:	f7ff ffc9 	bl	c0de0864 <mcu_usb_prints>
        format += ulIdx;

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0de08d2:	5de0      	ldrb	r0, [r4, r7]
c0de08d4:	2825      	cmp	r0, #37	; 0x25
c0de08d6:	d14b      	bne.n	c0de0970 <mcu_usb_printf+0xe0>
            ulCount = 0;
            cFill = ' ';
            ulStrlen = 0;
            cStrlenSet = 0;
            ulCap = 0;
            ulBase = 10;
c0de08d8:	1c6c      	adds	r4, r5, #1
c0de08da:	f04f 0800 	mov.w	r8, #0
c0de08de:	2220      	movs	r2, #32
c0de08e0:	f04f 0a00 	mov.w	sl, #0
c0de08e4:	2000      	movs	r0, #0
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0de08e6:	3401      	adds	r4, #1
c0de08e8:	f814 1c01 	ldrb.w	r1, [r4, #-1]
c0de08ec:	3401      	adds	r4, #1
c0de08ee:	292d      	cmp	r1, #45	; 0x2d
c0de08f0:	dc12      	bgt.n	c0de0918 <mcu_usb_printf+0x88>
c0de08f2:	f04f 0000 	mov.w	r0, #0
c0de08f6:	d0f7      	beq.n	c0de08e8 <mcu_usb_printf+0x58>
c0de08f8:	2925      	cmp	r1, #37	; 0x25
c0de08fa:	d076      	beq.n	c0de09ea <mcu_usb_printf+0x15a>
c0de08fc:	292a      	cmp	r1, #42	; 0x2a
c0de08fe:	f040 80fa 	bne.w	c0de0af6 <mcu_usb_printf+0x266>
                  goto error;
                }

                case '*':
                {
                  if (*format == 's' ) {
c0de0902:	4623      	mov	r3, r4
c0de0904:	f813 0d01 	ldrb.w	r0, [r3, #-1]!
c0de0908:	2873      	cmp	r0, #115	; 0x73
c0de090a:	f040 80f4 	bne.w	c0de0af6 <mcu_usb_printf+0x266>

                    ulStrlen = va_arg(vaArgP, unsigned long);
c0de090e:	9903      	ldr	r1, [sp, #12]
c0de0910:	2002      	movs	r0, #2
c0de0912:	461c      	mov	r4, r3
c0de0914:	e026      	b.n	c0de0964 <mcu_usb_printf+0xd4>
c0de0916:	bf00      	nop
            switch(*format++)
c0de0918:	2947      	cmp	r1, #71	; 0x47
c0de091a:	dc2b      	bgt.n	c0de0974 <mcu_usb_printf+0xe4>
c0de091c:	f1a1 0330 	sub.w	r3, r1, #48	; 0x30
c0de0920:	2b0a      	cmp	r3, #10
c0de0922:	d20d      	bcs.n	c0de0940 <mcu_usb_printf+0xb0>
                    if((format[-1] == '0') && (ulCount == 0))
c0de0924:	f081 0330 	eor.w	r3, r1, #48	; 0x30
c0de0928:	ea53 0308 	orrs.w	r3, r3, r8
                    ulCount *= 10;
c0de092c:	eb08 0388 	add.w	r3, r8, r8, lsl #2
                    ulCount += format[-1] - '0';
c0de0930:	eb01 0143 	add.w	r1, r1, r3, lsl #1
                    if((format[-1] == '0') && (ulCount == 0))
c0de0934:	bf08      	it	eq
c0de0936:	2230      	moveq	r2, #48	; 0x30
                    ulCount += format[-1] - '0';
c0de0938:	f1a1 0830 	sub.w	r8, r1, #48	; 0x30
                    goto again;
c0de093c:	3c01      	subs	r4, #1
c0de093e:	e7d2      	b.n	c0de08e6 <mcu_usb_printf+0x56>
            switch(*format++)
c0de0940:	292e      	cmp	r1, #46	; 0x2e
c0de0942:	f040 80d8 	bne.w	c0de0af6 <mcu_usb_printf+0x266>
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0de0946:	f814 0c01 	ldrb.w	r0, [r4, #-1]
c0de094a:	282a      	cmp	r0, #42	; 0x2a
c0de094c:	f040 80d3 	bne.w	c0de0af6 <mcu_usb_printf+0x266>
c0de0950:	7820      	ldrb	r0, [r4, #0]
c0de0952:	2848      	cmp	r0, #72	; 0x48
c0de0954:	d004      	beq.n	c0de0960 <mcu_usb_printf+0xd0>
c0de0956:	2873      	cmp	r0, #115	; 0x73
c0de0958:	d002      	beq.n	c0de0960 <mcu_usb_printf+0xd0>
c0de095a:	2868      	cmp	r0, #104	; 0x68
c0de095c:	f040 80cb 	bne.w	c0de0af6 <mcu_usb_printf+0x266>
                    ulStrlen = va_arg(vaArgP, unsigned long);
c0de0960:	9903      	ldr	r1, [sp, #12]
c0de0962:	2001      	movs	r0, #1
c0de0964:	1d0b      	adds	r3, r1, #4
c0de0966:	9303      	str	r3, [sp, #12]
c0de0968:	f8d1 a000 	ldr.w	sl, [r1]
c0de096c:	e7bb      	b.n	c0de08e6 <mcu_usb_printf+0x56>
c0de096e:	bf00      	nop
c0de0970:	462c      	mov	r4, r5
c0de0972:	e0cf      	b.n	c0de0b14 <mcu_usb_printf+0x284>
            switch(*format++)
c0de0974:	2967      	cmp	r1, #103	; 0x67
c0de0976:	dd08      	ble.n	c0de098a <mcu_usb_printf+0xfa>
c0de0978:	2972      	cmp	r1, #114	; 0x72
c0de097a:	dd11      	ble.n	c0de09a0 <mcu_usb_printf+0x110>
c0de097c:	2973      	cmp	r1, #115	; 0x73
c0de097e:	d036      	beq.n	c0de09ee <mcu_usb_printf+0x15e>
c0de0980:	2975      	cmp	r1, #117	; 0x75
c0de0982:	d039      	beq.n	c0de09f8 <mcu_usb_printf+0x168>
c0de0984:	2978      	cmp	r1, #120	; 0x78
c0de0986:	d011      	beq.n	c0de09ac <mcu_usb_printf+0x11c>
c0de0988:	e0b5      	b.n	c0de0af6 <mcu_usb_printf+0x266>
c0de098a:	2962      	cmp	r1, #98	; 0x62
c0de098c:	dc18      	bgt.n	c0de09c0 <mcu_usb_printf+0x130>
c0de098e:	2948      	cmp	r1, #72	; 0x48
c0de0990:	f000 809e 	beq.w	c0de0ad0 <mcu_usb_printf+0x240>
c0de0994:	2958      	cmp	r1, #88	; 0x58
c0de0996:	f040 80ae 	bne.w	c0de0af6 <mcu_usb_printf+0x266>
c0de099a:	f04f 0c01 	mov.w	ip, #1
c0de099e:	e007      	b.n	c0de09b0 <mcu_usb_printf+0x120>
c0de09a0:	2968      	cmp	r1, #104	; 0x68
c0de09a2:	f000 8098 	beq.w	c0de0ad6 <mcu_usb_printf+0x246>
c0de09a6:	2970      	cmp	r1, #112	; 0x70
c0de09a8:	f040 80a5 	bne.w	c0de0af6 <mcu_usb_printf+0x266>
c0de09ac:	f04f 0c00 	mov.w	ip, #0
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0de09b0:	9803      	ldr	r0, [sp, #12]
c0de09b2:	2710      	movs	r7, #16
c0de09b4:	1d01      	adds	r1, r0, #4
c0de09b6:	9103      	str	r1, [sp, #12]
c0de09b8:	6806      	ldr	r6, [r0, #0]
c0de09ba:	2001      	movs	r0, #1
c0de09bc:	9608      	str	r6, [sp, #32]
c0de09be:	e024      	b.n	c0de0a0a <mcu_usb_printf+0x17a>
            switch(*format++)
c0de09c0:	2963      	cmp	r1, #99	; 0x63
c0de09c2:	f000 809c 	beq.w	c0de0afe <mcu_usb_printf+0x26e>
c0de09c6:	2964      	cmp	r1, #100	; 0x64
c0de09c8:	f040 8095 	bne.w	c0de0af6 <mcu_usb_printf+0x266>
                    ulValue = va_arg(vaArgP, unsigned long);
c0de09cc:	9803      	ldr	r0, [sp, #12]
c0de09ce:	1d01      	adds	r1, r0, #4
c0de09d0:	9103      	str	r1, [sp, #12]
c0de09d2:	6806      	ldr	r6, [r0, #0]
                    if((long)ulValue < 0)
c0de09d4:	f1b6 3fff 	cmp.w	r6, #4294967295	; 0xffffffff
                    ulValue = va_arg(vaArgP, unsigned long);
c0de09d8:	9608      	str	r6, [sp, #32]
c0de09da:	dc12      	bgt.n	c0de0a02 <mcu_usb_printf+0x172>
                        ulValue = -(long)ulValue;
c0de09dc:	4276      	negs	r6, r6
c0de09de:	9608      	str	r6, [sp, #32]
c0de09e0:	2000      	movs	r0, #0
c0de09e2:	270a      	movs	r7, #10
            ulCap = 0;
c0de09e4:	f04f 0c00 	mov.w	ip, #0
c0de09e8:	e00f      	b.n	c0de0a0a <mcu_usb_printf+0x17a>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    mcu_usb_prints(format - 1, 1);
c0de09ea:	1ea0      	subs	r0, r4, #2
c0de09ec:	e08d      	b.n	c0de0b0a <mcu_usb_printf+0x27a>
c0de09ee:	496d      	ldr	r1, [pc, #436]	; (c0de0ba4 <mcu_usb_printf+0x314>)
c0de09f0:	4479      	add	r1, pc
c0de09f2:	468c      	mov	ip, r1
c0de09f4:	2100      	movs	r1, #0
c0de09f6:	e072      	b.n	c0de0ade <mcu_usb_printf+0x24e>
                    ulValue = va_arg(vaArgP, unsigned long);
c0de09f8:	9803      	ldr	r0, [sp, #12]
c0de09fa:	1d01      	adds	r1, r0, #4
c0de09fc:	9103      	str	r1, [sp, #12]
c0de09fe:	6806      	ldr	r6, [r0, #0]
c0de0a00:	9608      	str	r6, [sp, #32]
c0de0a02:	f04f 0c00 	mov.w	ip, #0
c0de0a06:	2001      	movs	r0, #1
c0de0a08:	270a      	movs	r7, #10
                        (((ulIdx * ulBase) <= ulValue) &&
c0de0a0a:	42b7      	cmp	r7, r6
c0de0a0c:	d902      	bls.n	c0de0a14 <mcu_usb_printf+0x184>
c0de0a0e:	f04f 0b01 	mov.w	fp, #1
c0de0a12:	e010      	b.n	c0de0a36 <mcu_usb_printf+0x1a6>
                    for(ulIdx = 1;
c0de0a14:	f1a8 0301 	sub.w	r3, r8, #1
c0de0a18:	4639      	mov	r1, r7
c0de0a1a:	bf00      	nop
c0de0a1c:	468b      	mov	fp, r1
                        (((ulIdx * ulBase) <= ulValue) &&
c0de0a1e:	fba7 1501 	umull	r1, r5, r7, r1
c0de0a22:	2d00      	cmp	r5, #0
c0de0a24:	bf18      	it	ne
c0de0a26:	2501      	movne	r5, #1
c0de0a28:	42b1      	cmp	r1, r6
c0de0a2a:	4698      	mov	r8, r3
c0de0a2c:	d803      	bhi.n	c0de0a36 <mcu_usb_printf+0x1a6>
                    for(ulIdx = 1;
c0de0a2e:	2d00      	cmp	r5, #0
c0de0a30:	f1a8 0301 	sub.w	r3, r8, #1
c0de0a34:	d0f2      	beq.n	c0de0a1c <mcu_usb_printf+0x18c>
                    if(ulNeg && (cFill == '0'))
c0de0a36:	b118      	cbz	r0, c0de0a40 <mcu_usb_printf+0x1b0>
c0de0a38:	2500      	movs	r5, #0
c0de0a3a:	f04f 0a01 	mov.w	sl, #1
c0de0a3e:	e00c      	b.n	c0de0a5a <mcu_usb_printf+0x1ca>
c0de0a40:	b2d1      	uxtb	r1, r2
c0de0a42:	2930      	cmp	r1, #48	; 0x30
c0de0a44:	d106      	bne.n	c0de0a54 <mcu_usb_printf+0x1c4>
                        pcBuf[ulPos++] = '-';
c0de0a46:	212d      	movs	r1, #45	; 0x2d
c0de0a48:	f04f 0a01 	mov.w	sl, #1
c0de0a4c:	2501      	movs	r5, #1
c0de0a4e:	f88d 1010 	strb.w	r1, [sp, #16]
c0de0a52:	e002      	b.n	c0de0a5a <mcu_usb_printf+0x1ca>
c0de0a54:	f04f 0a00 	mov.w	sl, #0
c0de0a58:	2500      	movs	r5, #0
c0de0a5a:	f080 0001 	eor.w	r0, r0, #1
c0de0a5e:	eba8 0100 	sub.w	r1, r8, r0
                    if((ulCount > 1) && (ulCount < 16))
c0de0a62:	1e8b      	subs	r3, r1, #2
c0de0a64:	2b0d      	cmp	r3, #13
c0de0a66:	d811      	bhi.n	c0de0a8c <mcu_usb_printf+0x1fc>
c0de0a68:	3901      	subs	r1, #1
c0de0a6a:	d00f      	beq.n	c0de0a8c <mcu_usb_printf+0x1fc>
c0de0a6c:	4240      	negs	r0, r0
                        for(ulCount--; ulCount; ulCount--)
c0de0a6e:	9001      	str	r0, [sp, #4]
c0de0a70:	a804      	add	r0, sp, #16
c0de0a72:	4428      	add	r0, r5
                            pcBuf[ulPos++] = cFill;
c0de0a74:	b2d2      	uxtb	r2, r2
c0de0a76:	f8cd c008 	str.w	ip, [sp, #8]
c0de0a7a:	f000 f92a 	bl	c0de0cd2 <__aeabi_memset>
                        for(ulCount--; ulCount; ulCount--)
c0de0a7e:	9901      	ldr	r1, [sp, #4]
c0de0a80:	eb05 0008 	add.w	r0, r5, r8
c0de0a84:	f8dd c008 	ldr.w	ip, [sp, #8]
c0de0a88:	4408      	add	r0, r1
c0de0a8a:	1e45      	subs	r5, r0, #1
                    if(ulNeg)
c0de0a8c:	f1ba 0f00 	cmp.w	sl, #0
c0de0a90:	a804      	add	r0, sp, #16
                        pcBuf[ulPos++] = '-';
c0de0a92:	bf02      	ittt	eq
c0de0a94:	212d      	moveq	r1, #45	; 0x2d
c0de0a96:	5541      	strbeq	r1, [r0, r5]
c0de0a98:	3501      	addeq	r5, #1
                    for(; ulIdx; ulIdx /= ulBase)
c0de0a9a:	f1bb 0f00 	cmp.w	fp, #0
c0de0a9e:	d015      	beq.n	c0de0acc <mcu_usb_printf+0x23c>
c0de0aa0:	4945      	ldr	r1, [pc, #276]	; (c0de0bb8 <mcu_usb_printf+0x328>)
c0de0aa2:	4b46      	ldr	r3, [pc, #280]	; (c0de0bbc <mcu_usb_printf+0x32c>)
c0de0aa4:	4479      	add	r1, pc
c0de0aa6:	447b      	add	r3, pc
c0de0aa8:	f1bc 0f00 	cmp.w	ip, #0
c0de0aac:	bf08      	it	eq
c0de0aae:	460b      	moveq	r3, r1
c0de0ab0:	fbb6 f1fb 	udiv	r1, r6, fp
c0de0ab4:	455f      	cmp	r7, fp
c0de0ab6:	fbb1 f2f7 	udiv	r2, r1, r7
c0de0aba:	fbbb fbf7 	udiv	fp, fp, r7
c0de0abe:	fb02 1117 	mls	r1, r2, r7, r1
c0de0ac2:	5c59      	ldrb	r1, [r3, r1]
                          pcBuf[ulPos++] = g_pcHex[(ulValue / ulIdx) % ulBase];
c0de0ac4:	5541      	strb	r1, [r0, r5]
c0de0ac6:	f105 0501 	add.w	r5, r5, #1
                    for(; ulIdx; ulIdx /= ulBase)
c0de0aca:	d9f1      	bls.n	c0de0ab0 <mcu_usb_printf+0x220>
                    mcu_usb_prints(pcBuf, ulPos);
c0de0acc:	4629      	mov	r1, r5
c0de0ace:	e01d      	b.n	c0de0b0c <mcu_usb_printf+0x27c>
c0de0ad0:	4935      	ldr	r1, [pc, #212]	; (c0de0ba8 <mcu_usb_printf+0x318>)
c0de0ad2:	4479      	add	r1, pc
c0de0ad4:	e001      	b.n	c0de0ada <mcu_usb_printf+0x24a>
c0de0ad6:	4935      	ldr	r1, [pc, #212]	; (c0de0bac <mcu_usb_printf+0x31c>)
c0de0ad8:	4479      	add	r1, pc
c0de0ada:	468c      	mov	ip, r1
c0de0adc:	2101      	movs	r1, #1
                    pcStr = va_arg(vaArgP, char *);
c0de0ade:	9a03      	ldr	r2, [sp, #12]
                    switch(cStrlenSet) {
c0de0ae0:	b2c0      	uxtb	r0, r0
                    pcStr = va_arg(vaArgP, char *);
c0de0ae2:	1d13      	adds	r3, r2, #4
c0de0ae4:	9303      	str	r3, [sp, #12]
c0de0ae6:	6816      	ldr	r6, [r2, #0]
                    switch(cStrlenSet) {
c0de0ae8:	b1c0      	cbz	r0, c0de0b1c <mcu_usb_printf+0x28c>
c0de0aea:	2801      	cmp	r0, #1
c0de0aec:	d020      	beq.n	c0de0b30 <mcu_usb_printf+0x2a0>
c0de0aee:	2802      	cmp	r0, #2
c0de0af0:	d11d      	bne.n	c0de0b2e <mcu_usb_printf+0x29e>
                        if (pcStr[0] == '\0') {
c0de0af2:	7830      	ldrb	r0, [r6, #0]
c0de0af4:	b3c0      	cbz	r0, c0de0b68 <mcu_usb_printf+0x2d8>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    mcu_usb_prints("ERROR", 5);
c0de0af6:	482a      	ldr	r0, [pc, #168]	; (c0de0ba0 <mcu_usb_printf+0x310>)
c0de0af8:	2105      	movs	r1, #5
c0de0afa:	4478      	add	r0, pc
c0de0afc:	e006      	b.n	c0de0b0c <mcu_usb_printf+0x27c>
                    ulValue = va_arg(vaArgP, unsigned long);
c0de0afe:	9803      	ldr	r0, [sp, #12]
c0de0b00:	1d01      	adds	r1, r0, #4
c0de0b02:	9103      	str	r1, [sp, #12]
c0de0b04:	6800      	ldr	r0, [r0, #0]
c0de0b06:	9008      	str	r0, [sp, #32]
                    mcu_usb_prints((char *)&ulValue, 1);
c0de0b08:	a808      	add	r0, sp, #32
c0de0b0a:	2101      	movs	r1, #1
c0de0b0c:	f7ff feaa 	bl	c0de0864 <mcu_usb_prints>
    while(*format)
c0de0b10:	f814 0d01 	ldrb.w	r0, [r4, #-1]!
c0de0b14:	2800      	cmp	r0, #0
c0de0b16:	f47f aecd 	bne.w	c0de08b4 <mcu_usb_printf+0x24>
c0de0b1a:	e03b      	b.n	c0de0b94 <mcu_usb_printf+0x304>
c0de0b1c:	2000      	movs	r0, #0
c0de0b1e:	bf00      	nop
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0de0b20:	5c32      	ldrb	r2, [r6, r0]
c0de0b22:	3001      	adds	r0, #1
c0de0b24:	2a00      	cmp	r2, #0
c0de0b26:	d1fb      	bne.n	c0de0b20 <mcu_usb_printf+0x290>
                    switch(ulBase) {
c0de0b28:	f1a0 0a01 	sub.w	sl, r0, #1
c0de0b2c:	e000      	b.n	c0de0b30 <mcu_usb_printf+0x2a0>
c0de0b2e:	46ba      	mov	sl, r7
c0de0b30:	b1a9      	cbz	r1, c0de0b5e <mcu_usb_printf+0x2ce>
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0de0b32:	f1ba 0f00 	cmp.w	sl, #0
c0de0b36:	4665      	mov	r5, ip
c0de0b38:	d0ea      	beq.n	c0de0b10 <mcu_usb_printf+0x280>
c0de0b3a:	bf00      	nop
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0de0b3c:	f816 0b01 	ldrb.w	r0, [r6], #1
c0de0b40:	2101      	movs	r1, #1
                          nibble2 = pcStr[ulCount]&0xF;
c0de0b42:	f000 070f 	and.w	r7, r0, #15
c0de0b46:	eb05 1010 	add.w	r0, r5, r0, lsr #4
c0de0b4a:	f7ff fe8b 	bl	c0de0864 <mcu_usb_prints>
c0de0b4e:	19e8      	adds	r0, r5, r7
c0de0b50:	2101      	movs	r1, #1
c0de0b52:	f7ff fe87 	bl	c0de0864 <mcu_usb_prints>
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0de0b56:	f1ba 0a01 	subs.w	sl, sl, #1
c0de0b5a:	d1ef      	bne.n	c0de0b3c <mcu_usb_printf+0x2ac>
c0de0b5c:	e7d8      	b.n	c0de0b10 <mcu_usb_printf+0x280>
                        mcu_usb_prints(pcStr, ulIdx);
c0de0b5e:	4630      	mov	r0, r6
c0de0b60:	4651      	mov	r1, sl
c0de0b62:	f7ff fe7f 	bl	c0de0864 <mcu_usb_prints>
c0de0b66:	e009      	b.n	c0de0b7c <mcu_usb_printf+0x2ec>
                          do {
c0de0b68:	f10a 0501 	add.w	r5, sl, #1
                            mcu_usb_prints(" ", 1);
c0de0b6c:	4810      	ldr	r0, [pc, #64]	; (c0de0bb0 <mcu_usb_printf+0x320>)
c0de0b6e:	2101      	movs	r1, #1
c0de0b70:	4478      	add	r0, pc
c0de0b72:	f7ff fe77 	bl	c0de0864 <mcu_usb_prints>
                          } while(ulStrlen-- > 0);
c0de0b76:	3d01      	subs	r5, #1
c0de0b78:	d1f8      	bne.n	c0de0b6c <mcu_usb_printf+0x2dc>
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0de0b7a:	46ba      	mov	sl, r7
                    if(ulCount > ulIdx)
c0de0b7c:	45d0      	cmp	r8, sl
c0de0b7e:	d9c7      	bls.n	c0de0b10 <mcu_usb_printf+0x280>
                        while(ulCount--)
c0de0b80:	ebaa 0508 	sub.w	r5, sl, r8
                            mcu_usb_prints(" ", 1);
c0de0b84:	480b      	ldr	r0, [pc, #44]	; (c0de0bb4 <mcu_usb_printf+0x324>)
c0de0b86:	2101      	movs	r1, #1
c0de0b88:	4478      	add	r0, pc
c0de0b8a:	f7ff fe6b 	bl	c0de0864 <mcu_usb_prints>
                        while(ulCount--)
c0de0b8e:	3501      	adds	r5, #1
c0de0b90:	d3f8      	bcc.n	c0de0b84 <mcu_usb_printf+0x2f4>
c0de0b92:	e7bd      	b.n	c0de0b10 <mcu_usb_printf+0x280>

    //
    // End the varargs processing.
    //
    va_end(vaArgP);
}
c0de0b94:	b009      	add	sp, #36	; 0x24
c0de0b96:	e8bd 4df0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
c0de0b9a:	b003      	add	sp, #12
c0de0b9c:	4770      	bx	lr
c0de0b9e:	bf00      	nop
c0de0ba0:	0000036a 	.word	0x0000036a
c0de0ba4:	000005c8 	.word	0x000005c8
c0de0ba8:	000004f6 	.word	0x000004f6
c0de0bac:	000004e0 	.word	0x000004e0
c0de0bb0:	00000226 	.word	0x00000226
c0de0bb4:	0000020e 	.word	0x0000020e
c0de0bb8:	00000514 	.word	0x00000514
c0de0bbc:	00000522 	.word	0x00000522

c0de0bc0 <pic_internal>:
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
__attribute__((naked,no_instrument_function)) void *pic_internal(void *link_address)
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");
c0de0bc0:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");
c0de0bc2:	4902      	ldr	r1, [pc, #8]	; (c0de0bcc <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");
c0de0bc4:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");
c0de0bc6:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");
c0de0bc8:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0de0bca:	4770      	bx	lr
c0de0bcc:	c0de0bc1 	.word	0xc0de0bc1

c0de0bd0 <pic>:

void *pic(void *link_address) {
  void *n, *en;

  // check if in the LINKED TEXT zone
  __asm volatile("ldr %0, =_nvram":"=r"(n));
c0de0bd0:	490a      	ldr	r1, [pc, #40]	; (c0de0bfc <pic+0x2c>)
  __asm volatile("ldr %0, =_envram":"=r"(en));
  if (link_address >= n && link_address <= en) {
c0de0bd2:	4281      	cmp	r1, r0
  __asm volatile("ldr %0, =_envram":"=r"(en));
c0de0bd4:	490a      	ldr	r1, [pc, #40]	; (c0de0c00 <pic+0x30>)
  if (link_address >= n && link_address <= en) {
c0de0bd6:	d806      	bhi.n	c0de0be6 <pic+0x16>
c0de0bd8:	4281      	cmp	r1, r0
c0de0bda:	d304      	bcc.n	c0de0be6 <pic+0x16>
c0de0bdc:	b580      	push	{r7, lr}
    link_address = pic_internal(link_address);
c0de0bde:	f7ff ffef 	bl	c0de0bc0 <pic_internal>
c0de0be2:	e8bd 4080 	ldmia.w	sp!, {r7, lr}
  }

  // check if in the LINKED RAM zone
  __asm volatile("ldr %0, =_bss":"=r"(n));
c0de0be6:	4907      	ldr	r1, [pc, #28]	; (c0de0c04 <pic+0x34>)
  __asm volatile("ldr %0, =_estack":"=r"(en));
  if (link_address >= n && link_address <= en) {
c0de0be8:	4288      	cmp	r0, r1
  __asm volatile("ldr %0, =_estack":"=r"(en));
c0de0bea:	4a07      	ldr	r2, [pc, #28]	; (c0de0c08 <pic+0x38>)
  if (link_address >= n && link_address <= en) {
c0de0bec:	d305      	bcc.n	c0de0bfa <pic+0x2a>
c0de0bee:	4290      	cmp	r0, r2
    __asm volatile("mov %0, r9":"=r"(en));
    // deref into the RAM therefore add the RAM offset from R9
    link_address = (char *)link_address - (char *)n + (char *)en;
  }

  return link_address;
c0de0bf0:	bf88      	it	hi
c0de0bf2:	4770      	bxhi	lr
    link_address = (char *)link_address - (char *)n + (char *)en;
c0de0bf4:	1a40      	subs	r0, r0, r1
    __asm volatile("mov %0, r9":"=r"(en));
c0de0bf6:	464a      	mov	r2, r9
    link_address = (char *)link_address - (char *)n + (char *)en;
c0de0bf8:	4410      	add	r0, r2
  return link_address;
c0de0bfa:	4770      	bx	lr
c0de0bfc:	c0de0000 	.word	0xc0de0000
c0de0c00:	c0de1000 	.word	0xc0de1000
c0de0c04:	da7a0000 	.word	0xda7a0000
c0de0c08:	da7a7800 	.word	0xda7a7800

c0de0c0c <SVC_Call>:
.thumb
.thumb_func
.global SVC_Call

SVC_Call:
    svc 1
c0de0c0c:	df01      	svc	1
    cmp r1, #0
c0de0c0e:	2900      	cmp	r1, #0
    bne exception
c0de0c10:	d100      	bne.n	c0de0c14 <exception>
    bx lr
c0de0c12:	4770      	bx	lr

c0de0c14 <exception>:
exception:
    // THROW(ex);
    mov r0, r1
c0de0c14:	4608      	mov	r0, r1
    bl os_longjmp
c0de0c16:	f7ff fe17 	bl	c0de0848 <os_longjmp>

c0de0c1a <get_api_level>:
#include <string.h>

unsigned int SVC_Call(unsigned int syscall_id, void *parameters);
unsigned int SVC_cx_call(unsigned int syscall_id, unsigned int * parameters);

unsigned int get_api_level(void) {
c0de0c1a:	b580      	push	{r7, lr}
c0de0c1c:	b082      	sub	sp, #8
c0de0c1e:	2000      	movs	r0, #0
  unsigned int parameters[2];
  parameters[0] = 0;
c0de0c20:	e9cd 0000 	strd	r0, r0, [sp]
c0de0c24:	4669      	mov	r1, sp
  parameters[1] = 0;
  return SVC_Call(SYSCALL_get_api_level_ID, parameters);
c0de0c26:	2001      	movs	r0, #1
c0de0c28:	f7ff fff0 	bl	c0de0c0c <SVC_Call>
c0de0c2c:	b002      	add	sp, #8
c0de0c2e:	bd80      	pop	{r7, pc}

c0de0c30 <os_lib_call>:
  SVC_Call(SYSCALL_os_ux_result_ID, parameters);
  return;
}
#endif // !defined(APP_UX)

void os_lib_call ( unsigned int * call_parameters ) {
c0de0c30:	b580      	push	{r7, lr}
c0de0c32:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)call_parameters;
c0de0c34:	9000      	str	r0, [sp, #0]
c0de0c36:	2000      	movs	r0, #0
  parameters[1] = 0;
c0de0c38:	9001      	str	r0, [sp, #4]
c0de0c3a:	4803      	ldr	r0, [pc, #12]	; (c0de0c48 <os_lib_call+0x18>)
c0de0c3c:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_lib_call_ID, parameters);
c0de0c3e:	f7ff ffe5 	bl	c0de0c0c <SVC_Call>
  return;
}
c0de0c42:	b002      	add	sp, #8
c0de0c44:	bd80      	pop	{r7, pc}
c0de0c46:	bf00      	nop
c0de0c48:	01000067 	.word	0x01000067

c0de0c4c <os_lib_end>:

void os_lib_end ( void ) {
c0de0c4c:	b580      	push	{r7, lr}
c0de0c4e:	b082      	sub	sp, #8
c0de0c50:	2000      	movs	r0, #0
  unsigned int parameters[2];
  parameters[1] = 0;
c0de0c52:	9001      	str	r0, [sp, #4]
c0de0c54:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_lib_end_ID, parameters);
c0de0c56:	2068      	movs	r0, #104	; 0x68
c0de0c58:	f7ff ffd8 	bl	c0de0c0c <SVC_Call>
  return;
}
c0de0c5c:	b002      	add	sp, #8
c0de0c5e:	bd80      	pop	{r7, pc}

c0de0c60 <os_sched_exit>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_exec_ID, parameters);
  return;
}

void __attribute__((noreturn)) os_sched_exit ( bolos_task_status_t exit_code ) {
c0de0c60:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)exit_code;
c0de0c62:	9000      	str	r0, [sp, #0]
c0de0c64:	2000      	movs	r0, #0
  parameters[1] = 0;
c0de0c66:	9001      	str	r0, [sp, #4]
c0de0c68:	4803      	ldr	r0, [pc, #12]	; (c0de0c78 <os_sched_exit+0x18>)
c0de0c6a:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_sched_exit_ID, parameters);
c0de0c6c:	f7ff ffce 	bl	c0de0c0c <SVC_Call>

  // The os_sched_exit syscall should never return. Just in case, prevent the
  // device from freezing (because of the following infinite loop) thanks to an
  // undefined instruction.
  asm volatile ("udf #255");
c0de0c70:	deff      	udf	#255	; 0xff
c0de0c72:	bf00      	nop

  // remove the warning caused by -Winvalid-noreturn
  while (1) {
c0de0c74:	e7fe      	b.n	c0de0c74 <os_sched_exit+0x14>
c0de0c76:	bf00      	nop
c0de0c78:	0100009a 	.word	0x0100009a

c0de0c7c <io_seph_send>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_kill_ID, parameters);
  return;
}

void io_seph_send ( const unsigned char * buffer, unsigned short length ) {
c0de0c7c:	b580      	push	{r7, lr}
c0de0c7e:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)buffer;
c0de0c80:	e9cd 0100 	strd	r0, r1, [sp]
c0de0c84:	4802      	ldr	r0, [pc, #8]	; (c0de0c90 <io_seph_send+0x14>)
c0de0c86:	4669      	mov	r1, sp
  parameters[1] = (unsigned int)length;
  SVC_Call(SYSCALL_io_seph_send_ID, parameters);
c0de0c88:	f7ff ffc0 	bl	c0de0c0c <SVC_Call>
  return;
}
c0de0c8c:	b002      	add	sp, #8
c0de0c8e:	bd80      	pop	{r7, pc}
c0de0c90:	02000083 	.word	0x02000083

c0de0c94 <try_context_get>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_nvm_erase_page_ID, parameters);
  return;
}

try_context_t * try_context_get ( void ) {
c0de0c94:	b580      	push	{r7, lr}
c0de0c96:	b082      	sub	sp, #8
c0de0c98:	2000      	movs	r0, #0
  unsigned int parameters[2];
  parameters[1] = 0;
c0de0c9a:	9001      	str	r0, [sp, #4]
c0de0c9c:	4669      	mov	r1, sp
  return (try_context_t *) SVC_Call(SYSCALL_try_context_get_ID, parameters);
c0de0c9e:	2087      	movs	r0, #135	; 0x87
c0de0ca0:	f7ff ffb4 	bl	c0de0c0c <SVC_Call>
c0de0ca4:	b002      	add	sp, #8
c0de0ca6:	bd80      	pop	{r7, pc}

c0de0ca8 <try_context_set>:
}

try_context_t * try_context_set ( try_context_t *context ) {
c0de0ca8:	b580      	push	{r7, lr}
c0de0caa:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)context;
c0de0cac:	9000      	str	r0, [sp, #0]
c0de0cae:	2000      	movs	r0, #0
  parameters[1] = 0;
c0de0cb0:	9001      	str	r0, [sp, #4]
c0de0cb2:	4803      	ldr	r0, [pc, #12]	; (c0de0cc0 <try_context_set+0x18>)
c0de0cb4:	4669      	mov	r1, sp
  return (try_context_t *) SVC_Call(SYSCALL_try_context_set_ID, parameters);
c0de0cb6:	f7ff ffa9 	bl	c0de0c0c <SVC_Call>
c0de0cba:	b002      	add	sp, #8
c0de0cbc:	bd80      	pop	{r7, pc}
c0de0cbe:	bf00      	nop
c0de0cc0:	0100010b 	.word	0x0100010b

c0de0cc4 <__aeabi_memclr>:
c0de0cc4:	2200      	movs	r2, #0
c0de0cc6:	f000 b804 	b.w	c0de0cd2 <__aeabi_memset>

c0de0cca <__aeabi_memcpy>:
c0de0cca:	f000 b807 	b.w	c0de0cdc <memcpy>

c0de0cce <__aeabi_memmove>:
c0de0cce:	f000 b812 	b.w	c0de0cf6 <memmove>

c0de0cd2 <__aeabi_memset>:
c0de0cd2:	4613      	mov	r3, r2
c0de0cd4:	460a      	mov	r2, r1
c0de0cd6:	4619      	mov	r1, r3
c0de0cd8:	f000 b827 	b.w	c0de0d2a <memset>

c0de0cdc <memcpy>:
c0de0cdc:	440a      	add	r2, r1
c0de0cde:	1e43      	subs	r3, r0, #1
c0de0ce0:	4291      	cmp	r1, r2
c0de0ce2:	d100      	bne.n	c0de0ce6 <memcpy+0xa>
c0de0ce4:	4770      	bx	lr
c0de0ce6:	b510      	push	{r4, lr}
c0de0ce8:	f811 4b01 	ldrb.w	r4, [r1], #1
c0de0cec:	4291      	cmp	r1, r2
c0de0cee:	f803 4f01 	strb.w	r4, [r3, #1]!
c0de0cf2:	d1f9      	bne.n	c0de0ce8 <memcpy+0xc>
c0de0cf4:	bd10      	pop	{r4, pc}

c0de0cf6 <memmove>:
c0de0cf6:	4288      	cmp	r0, r1
c0de0cf8:	b510      	push	{r4, lr}
c0de0cfa:	eb01 0402 	add.w	r4, r1, r2
c0de0cfe:	d902      	bls.n	c0de0d06 <memmove+0x10>
c0de0d00:	4284      	cmp	r4, r0
c0de0d02:	4623      	mov	r3, r4
c0de0d04:	d807      	bhi.n	c0de0d16 <memmove+0x20>
c0de0d06:	1e43      	subs	r3, r0, #1
c0de0d08:	42a1      	cmp	r1, r4
c0de0d0a:	d008      	beq.n	c0de0d1e <memmove+0x28>
c0de0d0c:	f811 2b01 	ldrb.w	r2, [r1], #1
c0de0d10:	f803 2f01 	strb.w	r2, [r3, #1]!
c0de0d14:	e7f8      	b.n	c0de0d08 <memmove+0x12>
c0de0d16:	4402      	add	r2, r0
c0de0d18:	4601      	mov	r1, r0
c0de0d1a:	428a      	cmp	r2, r1
c0de0d1c:	d100      	bne.n	c0de0d20 <memmove+0x2a>
c0de0d1e:	bd10      	pop	{r4, pc}
c0de0d20:	f813 4d01 	ldrb.w	r4, [r3, #-1]!
c0de0d24:	f802 4d01 	strb.w	r4, [r2, #-1]!
c0de0d28:	e7f7      	b.n	c0de0d1a <memmove+0x24>

c0de0d2a <memset>:
c0de0d2a:	4402      	add	r2, r0
c0de0d2c:	4603      	mov	r3, r0
c0de0d2e:	4293      	cmp	r3, r2
c0de0d30:	d100      	bne.n	c0de0d34 <memset+0xa>
c0de0d32:	4770      	bx	lr
c0de0d34:	f803 1b01 	strb.w	r1, [r3], #1
c0de0d38:	e7f9      	b.n	c0de0d2e <memset+0x4>
	...

c0de0d3c <setjmp>:
c0de0d3c:	46ec      	mov	ip, sp
c0de0d3e:	e8a0 5ff0 	stmia.w	r0!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
c0de0d42:	f04f 0000 	mov.w	r0, #0
c0de0d46:	4770      	bx	lr

c0de0d48 <longjmp>:
c0de0d48:	e8b0 5ff0 	ldmia.w	r0!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
c0de0d4c:	46e5      	mov	sp, ip
c0de0d4e:	0008      	movs	r0, r1
c0de0d50:	bf08      	it	eq
c0de0d52:	2001      	moveq	r0, #1
c0de0d54:	4770      	bx	lr
c0de0d56:	bf00      	nop

c0de0d58 <strlcpy>:
c0de0d58:	460b      	mov	r3, r1
c0de0d5a:	b510      	push	{r4, lr}
c0de0d5c:	b162      	cbz	r2, c0de0d78 <strlcpy+0x20>
c0de0d5e:	3a01      	subs	r2, #1
c0de0d60:	d008      	beq.n	c0de0d74 <strlcpy+0x1c>
c0de0d62:	f813 4b01 	ldrb.w	r4, [r3], #1
c0de0d66:	f800 4b01 	strb.w	r4, [r0], #1
c0de0d6a:	2c00      	cmp	r4, #0
c0de0d6c:	d1f7      	bne.n	c0de0d5e <strlcpy+0x6>
c0de0d6e:	1a58      	subs	r0, r3, r1
c0de0d70:	3801      	subs	r0, #1
c0de0d72:	bd10      	pop	{r4, pc}
c0de0d74:	2200      	movs	r2, #0
c0de0d76:	7002      	strb	r2, [r0, #0]
c0de0d78:	f813 2b01 	ldrb.w	r2, [r3], #1
c0de0d7c:	2a00      	cmp	r2, #0
c0de0d7e:	d1fb      	bne.n	c0de0d78 <strlcpy+0x20>
c0de0d80:	e7f5      	b.n	c0de0d6e <strlcpy+0x16>

c0de0d82 <strnlen>:
c0de0d82:	4602      	mov	r2, r0
c0de0d84:	4401      	add	r1, r0
c0de0d86:	b510      	push	{r4, lr}
c0de0d88:	428a      	cmp	r2, r1
c0de0d8a:	4613      	mov	r3, r2
c0de0d8c:	d003      	beq.n	c0de0d96 <strnlen+0x14>
c0de0d8e:	781c      	ldrb	r4, [r3, #0]
c0de0d90:	3201      	adds	r2, #1
c0de0d92:	2c00      	cmp	r4, #0
c0de0d94:	d1f8      	bne.n	c0de0d88 <strnlen+0x6>
c0de0d96:	1a18      	subs	r0, r3, r0
c0de0d98:	bd10      	pop	{r4, pc}
c0de0d9a:	0020      	movs	r0, r4
c0de0d9c:	6150      	str	r0, [r2, #20]
c0de0d9e:	6172      	str	r2, [r6, #20]
c0de0da0:	206d      	movs	r0, #109	; 0x6d
c0de0da2:	6f6e      	ldr	r6, [r5, #116]	; 0x74
c0de0da4:	2074      	movs	r0, #116	; 0x74
c0de0da6:	7573      	strb	r3, [r6, #21]
c0de0da8:	7070      	strb	r0, [r6, #1]
c0de0daa:	726f      	strb	r7, [r5, #9]
c0de0dac:	6574      	str	r4, [r6, #84]	; 0x54
c0de0dae:	0a64      	lsrs	r4, r4, #9
c0de0db0:	4500      	cmp	r0, r0
c0de0db2:	6874      	ldr	r4, [r6, #4]
c0de0db4:	7265      	strb	r5, [r4, #9]
c0de0db6:	7565      	strb	r5, [r4, #21]
c0de0db8:	006d      	lsls	r5, r5, #1
c0de0dba:	0030      	movs	r0, r6
c0de0dbc:	7453      	strb	r3, [r2, #17]
c0de0dbe:	6b61      	ldr	r1, [r4, #52]	; 0x34
c0de0dc0:	0065      	lsls	r5, r4, #1
c0de0dc2:	7845      	ldrb	r5, [r0, #1]
c0de0dc4:	6563      	str	r3, [r4, #84]	; 0x54
c0de0dc6:	7470      	strb	r0, [r6, #17]
c0de0dc8:	6f69      	ldr	r1, [r5, #116]	; 0x74
c0de0dca:	206e      	movs	r0, #110	; 0x6e
c0de0dcc:	7830      	ldrb	r0, [r6, #0]
c0de0dce:	7825      	ldrb	r5, [r4, #0]
c0de0dd0:	6320      	str	r0, [r4, #48]	; 0x30
c0de0dd2:	7561      	strb	r1, [r4, #21]
c0de0dd4:	6867      	ldr	r7, [r4, #4]
c0de0dd6:	0a74      	lsrs	r4, r6, #9
c0de0dd8:	7000      	strb	r0, [r0, #0]
c0de0dda:	756c      	strb	r4, [r5, #21]
c0de0ddc:	6967      	ldr	r7, [r4, #20]
c0de0dde:	206e      	movs	r0, #110	; 0x6e
c0de0de0:	7270      	strb	r0, [r6, #9]
c0de0de2:	766f      	strb	r7, [r5, #25]
c0de0de4:	6469      	str	r1, [r5, #68]	; 0x44
c0de0de6:	2065      	movs	r0, #101	; 0x65
c0de0de8:	6170      	str	r0, [r6, #20]
c0de0dea:	6172      	str	r2, [r6, #20]
c0de0dec:	656d      	str	r5, [r5, #84]	; 0x54
c0de0dee:	6574      	str	r4, [r6, #84]	; 0x54
c0de0df0:	2072      	movs	r0, #114	; 0x72
c0de0df2:	6425      	str	r5, [r4, #64]	; 0x40
c0de0df4:	2520      	movs	r5, #32
c0de0df6:	2a2e      	cmp	r2, #46	; 0x2e
c0de0df8:	0a48      	lsrs	r0, r1, #9
c0de0dfa:	6f00      	ldr	r0, [r0, #112]	; 0x70
c0de0dfc:	6666      	str	r6, [r4, #100]	; 0x64
c0de0dfe:	6573      	str	r3, [r6, #84]	; 0x54
c0de0e00:	3a74      	subs	r2, #116	; 0x74
c0de0e02:	2520      	movs	r5, #32
c0de0e04:	2c64      	cmp	r4, #100	; 0x64
c0de0e06:	6320      	str	r0, [r4, #48]	; 0x30
c0de0e08:	6568      	str	r0, [r5, #84]	; 0x54
c0de0e0a:	6b63      	ldr	r3, [r4, #52]	; 0x34
c0de0e0c:	6f70      	ldr	r0, [r6, #116]	; 0x74
c0de0e0e:	6e69      	ldr	r1, [r5, #100]	; 0x64
c0de0e10:	3a74      	subs	r2, #116	; 0x74
c0de0e12:	2520      	movs	r5, #32
c0de0e14:	2c64      	cmp	r4, #100	; 0x64
c0de0e16:	7020      	strb	r0, [r4, #0]
c0de0e18:	7261      	strb	r1, [r4, #9]
c0de0e1a:	6d61      	ldr	r1, [r4, #84]	; 0x54
c0de0e1c:	7465      	strb	r5, [r4, #17]
c0de0e1e:	7265      	strb	r5, [r4, #9]
c0de0e20:	664f      	str	r7, [r1, #100]	; 0x64
c0de0e22:	7366      	strb	r6, [r4, #13]
c0de0e24:	7465      	strb	r5, [r4, #17]
c0de0e26:	203a      	movs	r0, #58	; 0x3a
c0de0e28:	6425      	str	r5, [r4, #64]	; 0x40
c0de0e2a:	000a      	movs	r2, r1
c0de0e2c:	5445      	strb	r5, [r0, r1]
c0de0e2e:	0048      	lsls	r0, r1, #1
c0de0e30:	6168      	str	r0, [r5, #20]
c0de0e32:	646e      	str	r6, [r5, #68]	; 0x44
c0de0e34:	656c      	str	r4, [r5, #84]	; 0x54
c0de0e36:	6620      	str	r0, [r4, #96]	; 0x60
c0de0e38:	6e69      	ldr	r1, [r5, #100]	; 0x64
c0de0e3a:	6c61      	ldr	r1, [r4, #68]	; 0x44
c0de0e3c:	7a69      	ldrb	r1, [r5, #9]
c0de0e3e:	0a65      	lsrs	r5, r4, #9
c0de0e40:	7300      	strb	r0, [r0, #12]
c0de0e42:	4574      	cmp	r4, lr
c0de0e44:	4854      	ldr	r0, [pc, #336]	; (c0de0f98 <strnlen+0x216>)
c0de0e46:	7700      	strb	r0, [r0, #28]
c0de0e48:	7473      	strb	r3, [r6, #17]
c0de0e4a:	5445      	strb	r5, [r0, r1]
c0de0e4c:	0048      	lsls	r0, r1, #1
c0de0e4e:	7865      	ldrb	r5, [r4, #1]
c0de0e50:	6563      	str	r3, [r4, #84]	; 0x54
c0de0e52:	7470      	strb	r0, [r6, #17]
c0de0e54:	6f69      	ldr	r1, [r5, #116]	; 0x74
c0de0e56:	5b6e      	ldrh	r6, [r5, r5]
c0de0e58:	6425      	str	r5, [r4, #64]	; 0x40
c0de0e5a:	3a5d      	subs	r2, #93	; 0x5d
c0de0e5c:	4c20      	ldr	r4, [pc, #128]	; (c0de0ee0 <strnlen+0x15e>)
c0de0e5e:	3d52      	subs	r5, #82	; 0x52
c0de0e60:	7830      	ldrb	r0, [r6, #0]
c0de0e62:	3025      	adds	r0, #37	; 0x25
c0de0e64:	5838      	ldr	r0, [r7, r0]
c0de0e66:	000a      	movs	r2, r1
c0de0e68:	5245      	strh	r5, [r0, r1]
c0de0e6a:	4f52      	ldr	r7, [pc, #328]	; (c0de0fb4 <LIDO_SELECTORS+0x8>)
c0de0e6c:	0052      	lsls	r2, r2, #1
c0de0e6e:	694d      	ldr	r5, [r1, #20]
c0de0e70:	7373      	strb	r3, [r6, #13]
c0de0e72:	6e69      	ldr	r1, [r5, #100]	; 0x64
c0de0e74:	2067      	movs	r0, #103	; 0x67
c0de0e76:	6573      	str	r3, [r6, #84]	; 0x54
c0de0e78:	656c      	str	r4, [r5, #84]	; 0x54
c0de0e7a:	7463      	strb	r3, [r4, #17]
c0de0e7c:	726f      	strb	r7, [r5, #9]
c0de0e7e:	6e49      	ldr	r1, [r1, #100]	; 0x64
c0de0e80:	6564      	str	r4, [r4, #84]	; 0x54
c0de0e82:	0a78      	lsrs	r0, r7, #9
c0de0e84:	7000      	strb	r0, [r0, #0]
c0de0e86:	756c      	strb	r4, [r5, #21]
c0de0e88:	6967      	ldr	r7, [r4, #20]
c0de0e8a:	206e      	movs	r0, #110	; 0x6e
c0de0e8c:	7270      	strb	r0, [r6, #9]
c0de0e8e:	766f      	strb	r7, [r5, #25]
c0de0e90:	6469      	str	r1, [r5, #68]	; 0x44
c0de0e92:	2065      	movs	r0, #101	; 0x65
c0de0e94:	6f74      	ldr	r4, [r6, #116]	; 0x74
c0de0e96:	656b      	str	r3, [r5, #84]	; 0x54
c0de0e98:	3a6e      	subs	r2, #110	; 0x6e
c0de0e9a:	3020      	adds	r0, #32
c0de0e9c:	2578      	movs	r5, #120	; 0x78
c0de0e9e:	2c70      	cmp	r4, #112	; 0x70
c0de0ea0:	3020      	adds	r0, #32
c0de0ea2:	2578      	movs	r5, #120	; 0x78
c0de0ea4:	0a70      	lsrs	r0, r6, #9
c0de0ea6:	5200      	strh	r0, [r0, r0]
c0de0ea8:	7165      	strb	r5, [r4, #5]
c0de0eaa:	6575      	str	r5, [r6, #84]	; 0x54
c0de0eac:	7473      	strb	r3, [r6, #17]
c0de0eae:	7720      	strb	r0, [r4, #28]
c0de0eb0:	7469      	strb	r1, [r5, #17]
c0de0eb2:	6468      	str	r0, [r5, #68]	; 0x44
c0de0eb4:	6172      	str	r2, [r6, #20]
c0de0eb6:	6177      	str	r7, [r6, #20]
c0de0eb8:	736c      	strb	r4, [r5, #13]
c0de0eba:	7720      	strb	r0, [r4, #28]
c0de0ebc:	7469      	strb	r1, [r5, #17]
c0de0ebe:	2068      	movs	r0, #104	; 0x68
c0de0ec0:	6570      	str	r0, [r6, #84]	; 0x54
c0de0ec2:	6d72      	ldr	r2, [r6, #84]	; 0x54
c0de0ec4:	7469      	strb	r1, [r5, #17]
c0de0ec6:	5500      	strb	r0, [r0, r4]
c0de0ec8:	686e      	ldr	r6, [r5, #4]
c0de0eca:	6e61      	ldr	r1, [r4, #100]	; 0x64
c0de0ecc:	6c64      	ldr	r4, [r4, #68]	; 0x44
c0de0ece:	6465      	str	r5, [r4, #68]	; 0x44
c0de0ed0:	6d20      	ldr	r0, [r4, #80]	; 0x50
c0de0ed2:	7365      	strb	r5, [r4, #13]
c0de0ed4:	6173      	str	r3, [r6, #20]
c0de0ed6:	6567      	str	r7, [r4, #84]	; 0x54
c0de0ed8:	2520      	movs	r5, #32
c0de0eda:	0a64      	lsrs	r4, r4, #9
c0de0edc:	4c00      	ldr	r4, [pc, #0]	; (c0de0ee0 <strnlen+0x15e>)
c0de0ede:	6469      	str	r1, [r5, #68]	; 0x44
c0de0ee0:	006f      	lsls	r7, r5, #1
c0de0ee2:	6353      	str	r3, [r2, #52]	; 0x34
c0de0ee4:	6572      	str	r2, [r6, #84]	; 0x54
c0de0ee6:	6e65      	ldr	r5, [r4, #100]	; 0x64
c0de0ee8:	2520      	movs	r5, #32
c0de0eea:	2064      	movs	r0, #100	; 0x64
c0de0eec:	6f6e      	ldr	r6, [r5, #116]	; 0x74
c0de0eee:	2074      	movs	r0, #116	; 0x74
c0de0ef0:	7573      	strb	r3, [r6, #21]
c0de0ef2:	7070      	strb	r0, [r6, #1]
c0de0ef4:	726f      	strb	r7, [r5, #9]
c0de0ef6:	6574      	str	r4, [r6, #84]	; 0x54
c0de0ef8:	0a64      	lsrs	r4, r4, #9
c0de0efa:	5700      	ldrsb	r0, [r0, r4]
c0de0efc:	6172      	str	r2, [r6, #20]
c0de0efe:	0070      	lsls	r0, r6, #1
c0de0f00:	6552      	str	r2, [r2, #84]	; 0x54
c0de0f02:	6563      	str	r3, [r4, #84]	; 0x54
c0de0f04:	7669      	strb	r1, [r5, #25]
c0de0f06:	6465      	str	r5, [r4, #68]	; 0x44
c0de0f08:	6120      	str	r0, [r4, #16]
c0de0f0a:	206e      	movs	r0, #110	; 0x6e
c0de0f0c:	6e69      	ldr	r1, [r5, #100]	; 0x64
c0de0f0e:	6176      	str	r6, [r6, #20]
c0de0f10:	696c      	ldr	r4, [r5, #20]
c0de0f12:	2064      	movs	r0, #100	; 0x64
c0de0f14:	6373      	str	r3, [r6, #52]	; 0x34
c0de0f16:	6572      	str	r2, [r6, #84]	; 0x54
c0de0f18:	6e65      	ldr	r5, [r4, #100]	; 0x64
c0de0f1a:	6e49      	ldr	r1, [r1, #100]	; 0x64
c0de0f1c:	6564      	str	r4, [r4, #84]	; 0x54
c0de0f1e:	0a78      	lsrs	r0, r7, #9
c0de0f20:	5300      	strh	r0, [r0, r4]
c0de0f22:	6c65      	ldr	r5, [r4, #68]	; 0x44
c0de0f24:	6365      	str	r5, [r4, #52]	; 0x34
c0de0f26:	6f74      	ldr	r4, [r6, #116]	; 0x74
c0de0f28:	2072      	movs	r0, #114	; 0x72
c0de0f2a:	6e49      	ldr	r1, [r1, #100]	; 0x64
c0de0f2c:	6564      	str	r4, [r4, #84]	; 0x54
c0de0f2e:	2078      	movs	r0, #120	; 0x78
c0de0f30:	253a      	movs	r5, #58	; 0x3a
c0de0f32:	2064      	movs	r0, #100	; 0x64
c0de0f34:	6f6e      	ldr	r6, [r5, #116]	; 0x74
c0de0f36:	2074      	movs	r0, #116	; 0x74
c0de0f38:	7573      	strb	r3, [r6, #21]
c0de0f3a:	7070      	strb	r0, [r6, #1]
c0de0f3c:	726f      	strb	r7, [r5, #9]
c0de0f3e:	6574      	str	r4, [r6, #84]	; 0x54
c0de0f40:	0a64      	lsrs	r4, r4, #9
c0de0f42:	5500      	strb	r0, [r0, r4]
c0de0f44:	686e      	ldr	r6, [r5, #4]
c0de0f46:	6e61      	ldr	r1, [r4, #100]	; 0x64
c0de0f48:	6c64      	ldr	r4, [r4, #68]	; 0x44
c0de0f4a:	6465      	str	r5, [r4, #68]	; 0x44
c0de0f4c:	7320      	strb	r0, [r4, #12]
c0de0f4e:	6c65      	ldr	r5, [r4, #68]	; 0x44
c0de0f50:	6365      	str	r5, [r4, #52]	; 0x34
c0de0f52:	6f74      	ldr	r4, [r6, #116]	; 0x74
c0de0f54:	2072      	movs	r0, #114	; 0x72
c0de0f56:	6e49      	ldr	r1, [r1, #100]	; 0x64
c0de0f58:	6564      	str	r4, [r4, #84]	; 0x54
c0de0f5a:	3a78      	subs	r2, #120	; 0x78
c0de0f5c:	2520      	movs	r5, #32
c0de0f5e:	0a64      	lsrs	r4, r4, #9
c0de0f60:	4900      	ldr	r1, [pc, #0]	; (c0de0f64 <strnlen+0x1e2>)
c0de0f62:	766e      	strb	r6, [r5, #25]
c0de0f64:	6c61      	ldr	r1, [r4, #68]	; 0x44
c0de0f66:	6469      	str	r1, [r5, #68]	; 0x44
c0de0f68:	6320      	str	r0, [r4, #48]	; 0x30
c0de0f6a:	6e6f      	ldr	r7, [r5, #100]	; 0x64
c0de0f6c:	6574      	str	r4, [r6, #84]	; 0x54
c0de0f6e:	7478      	strb	r0, [r7, #17]
c0de0f70:	000a      	movs	r2, r1
c0de0f72:	6e55      	ldr	r5, [r2, #100]	; 0x64
c0de0f74:	7277      	strb	r7, [r6, #9]
c0de0f76:	7061      	strb	r1, [r4, #1]
c0de0f78:	5300      	strh	r0, [r0, r4]
c0de0f7a:	6c65      	ldr	r5, [r4, #68]	; 0x44
c0de0f7c:	6365      	str	r5, [r4, #52]	; 0x34
c0de0f7e:	6f74      	ldr	r4, [r6, #116]	; 0x74
c0de0f80:	2072      	movs	r0, #114	; 0x72
c0de0f82:	6e49      	ldr	r1, [r1, #100]	; 0x64
c0de0f84:	6564      	str	r4, [r4, #84]	; 0x54
c0de0f86:	2078      	movs	r0, #120	; 0x78
c0de0f88:	6425      	str	r5, [r4, #64]	; 0x40
c0de0f8a:	6e20      	ldr	r0, [r4, #96]	; 0x60
c0de0f8c:	746f      	strb	r7, [r5, #17]
c0de0f8e:	7320      	strb	r0, [r4, #12]
c0de0f90:	7075      	strb	r5, [r6, #1]
c0de0f92:	6f70      	ldr	r0, [r6, #116]	; 0x74
c0de0f94:	7472      	strb	r2, [r6, #17]
c0de0f96:	6465      	str	r5, [r4, #68]	; 0x44
c0de0f98:	000a      	movs	r2, r1

c0de0f9a <LIDO_SUBMIT_SELECTOR>:
c0de0f9a:	90a1 ab3e                                   ..>.

c0de0f9e <LIDO_WRAP_STETH_SELECTOR>:
c0de0f9e:	59ea b08c                                   .Y..

c0de0fa2 <LIDO_UNWRAP_WSTETH_SELECTOR>:
c0de0fa2:	0ede 3e9a                                   ...>

c0de0fa6 <LIDO_REQUEST_WITHDRAWALS_WITH_PERMIT_SELECTOR>:
c0de0fa6:	f4ac 4d1e 0000                              ...M..

c0de0fac <LIDO_SELECTORS>:
c0de0fac:	0f9a c0de 0f9e c0de 0fa2 c0de 0fa6 c0de     ................

c0de0fbc <g_pcHex>:
c0de0fbc:	3130 3332 3534 3736 3938 6261 6463 6665     0123456789abcdef

c0de0fcc <g_pcHex_cap>:
c0de0fcc:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF

c0de0fdc <_etext>:
	...
