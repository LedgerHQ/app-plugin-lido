
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
c0de0008:	f000 fc6e 	bl	c0de08e8 <os_boot>
c0de000c:	466c      	mov	r4, sp

    BEGIN_TRY {
        TRY {
c0de000e:	4620      	mov	r0, r4
c0de0010:	f001 f876 	bl	c0de1100 <setjmp>
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
c0de0026:	f000 fe93 	bl	c0de0d50 <try_context_set>
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
c0de004c:	f000 fc74 	bl	c0de0938 <mcu_usb_printf>
        }
        FINALLY {
c0de0050:	f000 fe74 	bl	c0de0d3c <try_context_get>
c0de0054:	42a0      	cmp	r0, r4
c0de0056:	d102      	bne.n	c0de005e <main+0x5e>
c0de0058:	980a      	ldr	r0, [sp, #40]	; 0x28
c0de005a:	f000 fe79 	bl	c0de0d50 <try_context_set>
            os_lib_end();
c0de005e:	f000 fe49 	bl	c0de0cf4 <os_lib_end>
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
c0de0070:	f000 fe6e 	bl	c0de0d50 <try_context_set>
c0de0074:	900a      	str	r0, [sp, #40]	; 0x28
// get API level
SYSCALL unsigned int get_api_level(void);

#ifndef HAVE_BOLOS
static inline void check_api_level(unsigned int apiLevel) {
  if (apiLevel < get_api_level()) {
c0de0076:	f000 fe24 	bl	c0de0cc2 <get_api_level>
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
c0de008c:	f000 fbfc 	bl	c0de0888 <dispatch_plugin_calls>
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
c0de00a4:	f000 fe18 	bl	c0de0cd8 <os_lib_call>
c0de00a8:	e7de      	b.n	c0de0068 <main+0x68>
    END_TRY;
c0de00aa:	f000 fc21 	bl	c0de08f0 <os_longjmp>
c0de00ae:	20ff      	movs	r0, #255	; 0xff
    os_sched_exit(-1);
c0de00b0:	f000 fe2a 	bl	c0de0d08 <os_sched_exit>
c0de00b4:	00001159 	.word	0x00001159
c0de00b8:	000011b4 	.word	0x000011b4

c0de00bc <cx_hash_get_size>:
CX_TRAMPOLINE _NR_cx_edwards_compress_point_no_throw       cx_edwards_compress_point_no_throw
CX_TRAMPOLINE _NR_cx_edwards_decompress_point_no_throw     cx_edwards_decompress_point_no_throw
CX_TRAMPOLINE _NR_cx_encode_coord                          cx_encode_coord
CX_TRAMPOLINE _NR_cx_hash_final                            cx_hash_final
CX_TRAMPOLINE _NR_cx_hash_get_info                         cx_hash_get_info
CX_TRAMPOLINE _NR_cx_hash_get_size                         cx_hash_get_size
c0de00bc:	b403      	push	{r0, r1}
c0de00be:	f04f 0044 	mov.w	r0, #68	; 0x44
c0de00c2:	e00b      	b.n	c0de00dc <cx_trampoline_helper>

c0de00c4 <cx_hash_no_throw>:
CX_TRAMPOLINE _NR_cx_hash_init                             cx_hash_init
CX_TRAMPOLINE _NR_cx_hash_init_ex                          cx_hash_init_ex
CX_TRAMPOLINE _NR_cx_hash_no_throw                         cx_hash_no_throw
c0de00c4:	b403      	push	{r0, r1}
c0de00c6:	f04f 0047 	mov.w	r0, #71	; 0x47
c0de00ca:	e007      	b.n	c0de00dc <cx_trampoline_helper>

c0de00cc <cx_keccak_init_no_throw>:
CX_TRAMPOLINE _NR_cx_hmac_sha256_init_no_throw             cx_hmac_sha256_init_no_throw
CX_TRAMPOLINE _NR_cx_hmac_sha384_init                      cx_hmac_sha384_init
CX_TRAMPOLINE _NR_cx_hmac_sha512                           cx_hmac_sha512
CX_TRAMPOLINE _NR_cx_hmac_sha512_init_no_throw             cx_hmac_sha512_init_no_throw
CX_TRAMPOLINE _NR_cx_hmac_update                           cx_hmac_update
CX_TRAMPOLINE _NR_cx_keccak_init_no_throw                  cx_keccak_init_no_throw
c0de00cc:	b403      	push	{r0, r1}
c0de00ce:	f04f 0059 	mov.w	r0, #89	; 0x59
c0de00d2:	e003      	b.n	c0de00dc <cx_trampoline_helper>

c0de00d4 <cx_x448>:
CX_TRAMPOLINE _NR_cx_swap_buffer32                         cx_swap_buffer32
CX_TRAMPOLINE _NR_cx_swap_buffer64                         cx_swap_buffer64
CX_TRAMPOLINE _NR_cx_swap_uint32                           cx_swap_uint32
CX_TRAMPOLINE _NR_cx_swap_uint64                           cx_swap_uint64
CX_TRAMPOLINE _NR_cx_x25519                                cx_x25519
CX_TRAMPOLINE _NR_cx_x448                                  cx_x448
c0de00d4:	b403      	push	{r0, r1}
c0de00d6:	f04f 0086 	mov.w	r0, #134	; 0x86
c0de00da:	e7ff      	b.n	c0de00dc <cx_trampoline_helper>

c0de00dc <cx_trampoline_helper>:

.thumb_func
cx_trampoline_helper:
  ldr  r1, =CX_TRAMPOLINE_ADDR // _cx_trampoline address
c0de00dc:	4900      	ldr	r1, [pc, #0]	; (c0de00e0 <cx_trampoline_helper+0x4>)
  bx   r1
c0de00de:	4708      	bx	r1
  ldr  r1, =CX_TRAMPOLINE_ADDR // _cx_trampoline address
c0de00e0:	00808001 	.word	0x00808001

c0de00e4 <getEthAddressStringFromBinary>:
#include "eth_internals.h"

void getEthAddressStringFromBinary(uint8_t *address,
                                   char *out,
                                   cx_sha3_t *sha3Context,
                                   uint64_t chainId) {
c0de00e4:	e92d 4df0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
c0de00e8:	b090      	sub	sp, #64	; 0x40
c0de00ea:	4690      	mov	r8, r2
c0de00ec:	460c      	mov	r4, r1
c0de00ee:	e9dd 2118 	ldrd	r2, r1, [sp, #96]	; 0x60
c0de00f2:	4605      	mov	r5, r0
    } locals_union;

    uint8_t i;
    bool eip1191 = false;
    uint32_t offset = 0;
    switch (chainId) {
c0de00f4:	f022 0301 	bic.w	r3, r2, #1
c0de00f8:	f083 031e 	eor.w	r3, r3, #30
c0de00fc:	430b      	orrs	r3, r1
        case 30:
        case 31:
            eip1191 = true;
            break;
    }
    if (eip1191) {
c0de00fe:	d117      	bne.n	c0de0130 <getEthAddressStringFromBinary+0x4c>
c0de0100:	ae03      	add	r6, sp, #12
        u64_to_string(chainId, (char *) locals_union.tmp, sizeof(locals_union.tmp));
c0de0102:	4610      	mov	r0, r2
c0de0104:	4632      	mov	r2, r6
c0de0106:	2333      	movs	r3, #51	; 0x33
c0de0108:	f000 f868 	bl	c0de01dc <u64_to_string>
        offset = strnlen((char *) locals_union.tmp, sizeof(locals_union.tmp));
c0de010c:	4630      	mov	r0, r6
c0de010e:	2133      	movs	r1, #51	; 0x33
c0de0110:	f001 f844 	bl	c0de119c <strnlen>
        strlcat((char *) locals_union.tmp + offset, "0x", sizeof(locals_union.tmp) - offset);
c0de0114:	492f      	ldr	r1, [pc, #188]	; (c0de01d4 <getEthAddressStringFromBinary+0xf0>)
c0de0116:	1833      	adds	r3, r6, r0
c0de0118:	f1c0 0233 	rsb	r2, r0, #51	; 0x33
c0de011c:	4479      	add	r1, pc
c0de011e:	4618      	mov	r0, r3
c0de0120:	f000 fffc 	bl	c0de111c <strlcat>
        offset = strnlen((char *) locals_union.tmp, sizeof(locals_union.tmp));
c0de0124:	4630      	mov	r0, r6
c0de0126:	2133      	movs	r1, #51	; 0x33
c0de0128:	f001 f838 	bl	c0de119c <strnlen>
c0de012c:	4682      	mov	sl, r0
c0de012e:	e001      	b.n	c0de0134 <getEthAddressStringFromBinary+0x50>
c0de0130:	f04f 0a00 	mov.w	sl, #0
c0de0134:	4e28      	ldr	r6, [pc, #160]	; (c0de01d8 <getEthAddressStringFromBinary+0xf4>)
c0de0136:	f10d 0b0c 	add.w	fp, sp, #12
    }
    for (i = 0; i < 20; i++) {
c0de013a:	eb0b 000a 	add.w	r0, fp, sl
c0de013e:	447e      	add	r6, pc
c0de0140:	2100      	movs	r1, #0
c0de0142:	bf00      	nop
        uint8_t digit = address[i];
c0de0144:	5c6a      	ldrb	r2, [r5, r1]
        locals_union.tmp[offset + 2 * i] = HEXDIGITS[(digit >> 4) & 0x0f];
c0de0146:	eb00 0741 	add.w	r7, r0, r1, lsl #1
c0de014a:	0913      	lsrs	r3, r2, #4
c0de014c:	5cf3      	ldrb	r3, [r6, r3]
        locals_union.tmp[offset + 2 * i + 1] = HEXDIGITS[digit & 0x0f];
c0de014e:	f002 020f 	and.w	r2, r2, #15
        locals_union.tmp[offset + 2 * i] = HEXDIGITS[(digit >> 4) & 0x0f];
c0de0152:	f800 3011 	strb.w	r3, [r0, r1, lsl #1]
        locals_union.tmp[offset + 2 * i + 1] = HEXDIGITS[digit & 0x0f];
c0de0156:	5cb2      	ldrb	r2, [r6, r2]
    for (i = 0; i < 20; i++) {
c0de0158:	3101      	adds	r1, #1
c0de015a:	2914      	cmp	r1, #20
        locals_union.tmp[offset + 2 * i + 1] = HEXDIGITS[digit & 0x0f];
c0de015c:	707a      	strb	r2, [r7, #1]
    for (i = 0; i < 20; i++) {
c0de015e:	d1f1      	bne.n	c0de0144 <getEthAddressStringFromBinary+0x60>
 * 
 * @throws           CX_INVALID_PARAMETER
 */
static inline int cx_keccak_init ( cx_sha3_t * hash, size_t size )
{
  CX_THROW(cx_keccak_init_no_throw(hash, size));
c0de0160:	4640      	mov	r0, r8
c0de0162:	f44f 7180 	mov.w	r1, #256	; 0x100
c0de0166:	f7ff ffb1 	bl	c0de00cc <cx_keccak_init_no_throw>
c0de016a:	bb80      	cbnz	r0, c0de01ce <getEthAddressStringFromBinary+0xea>
c0de016c:	2020      	movs	r0, #32
    }
    cx_keccak_init(sha3Context, 256);
    cx_hash((cx_hash_t *) sha3Context,
            CX_LAST,
            locals_union.tmp,
            offset + 40,
c0de016e:	f10a 0328 	add.w	r3, sl, #40	; 0x28
 * @throws             INVALID_PARAMETER
 * @throws             CX_INVALID_PARAMETER
 */
static inline size_t cx_hash ( cx_hash_t * hash, uint32_t mode, const unsigned char * in, unsigned int len, unsigned char * out, unsigned int out_len )
{
  CX_THROW(cx_hash_no_throw(hash, mode, in, len, out, out_len));
c0de0172:	9001      	str	r0, [sp, #4]
c0de0174:	4640      	mov	r0, r8
c0de0176:	2101      	movs	r1, #1
c0de0178:	465a      	mov	r2, fp
c0de017a:	f8cd b000 	str.w	fp, [sp]
c0de017e:	f7ff ffa1 	bl	c0de00c4 <cx_hash_no_throw>
c0de0182:	bb20      	cbnz	r0, c0de01ce <getEthAddressStringFromBinary+0xea>
  return cx_hash_get_size(hash);
c0de0184:	4640      	mov	r0, r8
c0de0186:	f7ff ff99 	bl	c0de00bc <cx_hash_get_size>
c0de018a:	2000      	movs	r0, #0
c0de018c:	f04f 0c04 	mov.w	ip, #4
            locals_union.hashChecksum,
            32);
    for (i = 0; i < 40; i++) {
        uint8_t digit = address[i / 2];
c0de0190:	0843      	lsrs	r3, r0, #1
c0de0192:	5ce9      	ldrb	r1, [r5, r3]
        if ((i % 2) == 0) {
c0de0194:	f010 0701 	ands.w	r7, r0, #1
c0de0198:	f001 020f 	and.w	r2, r1, #15
c0de019c:	bf08      	it	eq
c0de019e:	090a      	lsreq	r2, r1, #4
            digit = (digit >> 4) & 0x0f;
        } else {
            digit = digit & 0x0f;
        }
        if (digit < 10) {
c0de01a0:	2a09      	cmp	r2, #9
c0de01a2:	d801      	bhi.n	c0de01a8 <getEthAddressStringFromBinary+0xc4>
            out[i] = HEXDIGITS[digit];
c0de01a4:	5cb2      	ldrb	r2, [r6, r2]
c0de01a6:	e008      	b.n	c0de01ba <getEthAddressStringFromBinary+0xd6>
        } else {
            int v = (locals_union.hashChecksum[i / 2] >> (4 * (1 - i % 2))) & 0x0f;
c0de01a8:	f81b 1003 	ldrb.w	r1, [fp, r3]
c0de01ac:	ea8c 0387 	eor.w	r3, ip, r7, lsl #2
            if (v >= 8) {
c0de01b0:	40d9      	lsrs	r1, r3
c0de01b2:	5cb2      	ldrb	r2, [r6, r2]
c0de01b4:	0709      	lsls	r1, r1, #28
c0de01b6:	bf48      	it	mi
c0de01b8:	3a20      	submi	r2, #32
c0de01ba:	5422      	strb	r2, [r4, r0]
    for (i = 0; i < 40; i++) {
c0de01bc:	3001      	adds	r0, #1
c0de01be:	2828      	cmp	r0, #40	; 0x28
c0de01c0:	d1e6      	bne.n	c0de0190 <getEthAddressStringFromBinary+0xac>
c0de01c2:	2000      	movs	r0, #0
            } else {
                out[i] = HEXDIGITS[digit];
            }
        }
    }
    out[40] = '\0';
c0de01c4:	f884 0028 	strb.w	r0, [r4, #40]	; 0x28
}
c0de01c8:	b010      	add	sp, #64	; 0x40
c0de01ca:	e8bd 8df0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, fp, pc}
c0de01ce:	f000 fb8f 	bl	c0de08f0 <os_longjmp>
c0de01d2:	bf00      	nop
c0de01d4:	000011a5 	.word	0x000011a5
c0de01d8:	0000114b 	.word	0x0000114b

c0de01dc <u64_to_string>:
    }

    out_buffer[out_buffer_size - 1] = '\0';
}

void u64_to_string(uint64_t src, char *dst, uint8_t dst_size) {
c0de01dc:	e92d 4df0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
c0de01e0:	4698      	mov	r8, r3
c0de01e2:	4693      	mov	fp, r2
c0de01e4:	460f      	mov	r7, r1
c0de01e6:	4606      	mov	r6, r0
c0de01e8:	f04f 0a00 	mov.w	sl, #0
c0de01ec:	2300      	movs	r3, #0
c0de01ee:	bf00      	nop
    // Copy the numbers in ASCII format.
    uint8_t i = 0;
    do {
        // Checking `i + 1` to make sure we have enough space for '\0'.
        if (i + 1 >= dst_size) {
c0de01f0:	b2dd      	uxtb	r5, r3
c0de01f2:	1c68      	adds	r0, r5, #1
c0de01f4:	4540      	cmp	r0, r8
c0de01f6:	d237      	bcs.n	c0de0268 <u64_to_string+0x8c>
c0de01f8:	461c      	mov	r4, r3
            THROW(0x6502);
        }
        dst[i] = src % 10 + '0';
        src /= 10;
c0de01fa:	4630      	mov	r0, r6
c0de01fc:	4639      	mov	r1, r7
c0de01fe:	220a      	movs	r2, #10
c0de0200:	2300      	movs	r3, #0
c0de0202:	f000 fdb3 	bl	c0de0d6c <__aeabi_uldivmod>
        i++;
    } while (src);
c0de0206:	f1d6 0209 	rsbs	r2, r6, #9
c0de020a:	eb7a 0207 	sbcs.w	r2, sl, r7
c0de020e:	eb00 0280 	add.w	r2, r0, r0, lsl #2
c0de0212:	eba6 0242 	sub.w	r2, r6, r2, lsl #1
        dst[i] = src % 10 + '0';
c0de0216:	f042 0230 	orr.w	r2, r2, #48	; 0x30
        i++;
c0de021a:	f104 0301 	add.w	r3, r4, #1
c0de021e:	4606      	mov	r6, r0
c0de0220:	460f      	mov	r7, r1
        dst[i] = src % 10 + '0';
c0de0222:	f80b 2005 	strb.w	r2, [fp, r5]
    } while (src);
c0de0226:	d3e3      	bcc.n	c0de01f0 <u64_to_string+0x14>

    // Null terminate string
    dst[i] = '\0';
c0de0228:	b2d8      	uxtb	r0, r3
c0de022a:	2100      	movs	r1, #0

    // Revert the string
    i--;
    uint8_t j = 0;
    while (j < i) {
c0de022c:	0623      	lsls	r3, r4, #24
    dst[i] = '\0';
c0de022e:	f80b 1000 	strb.w	r1, [fp, r0]
    while (j < i) {
c0de0232:	d017      	beq.n	c0de0264 <u64_to_string+0x88>
        char tmp = dst[i];
        dst[i] = dst[j];
c0de0234:	f89b 0000 	ldrb.w	r0, [fp]
        dst[j] = tmp;
c0de0238:	f88b 2000 	strb.w	r2, [fp]
        dst[i] = dst[j];
c0de023c:	f80b 0005 	strb.w	r0, [fp, r5]
        i--;
c0de0240:	1e68      	subs	r0, r5, #1
    while (j < i) {
c0de0242:	2802      	cmp	r0, #2
        j++;
    }
}
c0de0244:	bf38      	it	cc
c0de0246:	e8bd 8df0 	ldmiacc.w	sp!, {r4, r5, r6, r7, r8, sl, fp, pc}
c0de024a:	2101      	movs	r1, #1
        dst[i] = dst[j];
c0de024c:	f81b 2001 	ldrb.w	r2, [fp, r1]
        char tmp = dst[i];
c0de0250:	f81b 3000 	ldrb.w	r3, [fp, r0]
        dst[i] = dst[j];
c0de0254:	f80b 2000 	strb.w	r2, [fp, r0]
        dst[j] = tmp;
c0de0258:	f80b 3001 	strb.w	r3, [fp, r1]
        i--;
c0de025c:	3801      	subs	r0, #1
        j++;
c0de025e:	3101      	adds	r1, #1
    while (j < i) {
c0de0260:	4281      	cmp	r1, r0
c0de0262:	d3f3      	bcc.n	c0de024c <u64_to_string+0x70>
}
c0de0264:	e8bd 8df0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, fp, pc}
            THROW(0x6502);
c0de0268:	f246 5002 	movw	r0, #25858	; 0x6502
c0de026c:	f000 fb40 	bl	c0de08f0 <os_longjmp>

c0de0270 <adjustDecimals>:
                    uint8_t decimals) {
c0de0270:	b5f0      	push	{r4, r5, r6, r7, lr}
c0de0272:	b081      	sub	sp, #4
c0de0274:	4617      	mov	r7, r2
c0de0276:	460e      	mov	r6, r1
    if ((srcLength == 1) && (*src == '0')) {
c0de0278:	2901      	cmp	r1, #1
c0de027a:	4605      	mov	r5, r0
c0de027c:	d10a      	bne.n	c0de0294 <adjustDecimals+0x24>
c0de027e:	7828      	ldrb	r0, [r5, #0]
c0de0280:	2830      	cmp	r0, #48	; 0x30
c0de0282:	d107      	bne.n	c0de0294 <adjustDecimals+0x24>
        if (targetLength < 2) {
c0de0284:	2b02      	cmp	r3, #2
c0de0286:	f04f 0000 	mov.w	r0, #0
c0de028a:	d363      	bcc.n	c0de0354 <adjustDecimals+0xe4>
c0de028c:	2130      	movs	r1, #48	; 0x30
        target[0] = '0';
c0de028e:	7039      	strb	r1, [r7, #0]
        target[1] = '\0';
c0de0290:	7078      	strb	r0, [r7, #1]
c0de0292:	e05e      	b.n	c0de0352 <adjustDecimals+0xe2>
c0de0294:	9906      	ldr	r1, [sp, #24]
    if (srcLength <= decimals) {
c0de0296:	42b1      	cmp	r1, r6
c0de0298:	d223      	bcs.n	c0de02e2 <adjustDecimals+0x72>
        if (targetLength < srcLength + 1 + 1) {
c0de029a:	1cb0      	adds	r0, r6, #2
c0de029c:	4298      	cmp	r0, r3
c0de029e:	d823      	bhi.n	c0de02e8 <adjustDecimals+0x78>
c0de02a0:	ebb6 0c01 	subs.w	ip, r6, r1
        while (offset < delta) {
c0de02a4:	d008      	beq.n	c0de02b8 <adjustDecimals+0x48>
c0de02a6:	4628      	mov	r0, r5
c0de02a8:	4663      	mov	r3, ip
c0de02aa:	463c      	mov	r4, r7
            target[offset++] = src[sourceOffset++];
c0de02ac:	f810 2b01 	ldrb.w	r2, [r0], #1
        while (offset < delta) {
c0de02b0:	3b01      	subs	r3, #1
            target[offset++] = src[sourceOffset++];
c0de02b2:	f804 2b01 	strb.w	r2, [r4], #1
        while (offset < delta) {
c0de02b6:	d1f9      	bne.n	c0de02ac <adjustDecimals+0x3c>
        if (decimals != 0) {
c0de02b8:	2900      	cmp	r1, #0
c0de02ba:	bf0f      	iteee	eq
c0de02bc:	4660      	moveq	r0, ip
            target[offset++] = '.';
c0de02be:	f10c 0001 	addne.w	r0, ip, #1
c0de02c2:	222e      	movne	r2, #46	; 0x2e
c0de02c4:	f807 200c 	strbne.w	r2, [r7, ip]
        while (sourceOffset < srcLength) {
c0de02c8:	45b4      	cmp	ip, r6
c0de02ca:	d228      	bcs.n	c0de031e <adjustDecimals+0xae>
c0de02cc:	eb05 020c 	add.w	r2, r5, ip
c0de02d0:	183e      	adds	r6, r7, r0
c0de02d2:	2300      	movs	r3, #0
            target[offset++] = src[sourceOffset++];
c0de02d4:	5cd5      	ldrb	r5, [r2, r3]
c0de02d6:	54f5      	strb	r5, [r6, r3]
        while (sourceOffset < srcLength) {
c0de02d8:	3301      	adds	r3, #1
c0de02da:	4299      	cmp	r1, r3
c0de02dc:	d1fa      	bne.n	c0de02d4 <adjustDecimals+0x64>
c0de02de:	18c1      	adds	r1, r0, r3
c0de02e0:	e01e      	b.n	c0de0320 <adjustDecimals+0xb0>
        if (targetLength < srcLength + 1 + 2 + delta) {
c0de02e2:	1cc8      	adds	r0, r1, #3
c0de02e4:	4298      	cmp	r0, r3
c0de02e6:	d901      	bls.n	c0de02ec <adjustDecimals+0x7c>
c0de02e8:	2000      	movs	r0, #0
c0de02ea:	e033      	b.n	c0de0354 <adjustDecimals+0xe4>
c0de02ec:	2030      	movs	r0, #48	; 0x30
c0de02ee:	1b8c      	subs	r4, r1, r6
        target[offset++] = '0';
c0de02f0:	7038      	strb	r0, [r7, #0]
c0de02f2:	f04f 002e 	mov.w	r0, #46	; 0x2e
        target[offset++] = '.';
c0de02f6:	7078      	strb	r0, [r7, #1]
        for (uint32_t i = 0; i < delta; i++) {
c0de02f8:	d006      	beq.n	c0de0308 <adjustDecimals+0x98>
c0de02fa:	1cb8      	adds	r0, r7, #2
            target[offset++] = '0';
c0de02fc:	4621      	mov	r1, r4
c0de02fe:	2230      	movs	r2, #48	; 0x30
c0de0300:	f000 fec9 	bl	c0de1096 <__aeabi_memset>
        for (uint32_t i = 0; i < delta; i++) {
c0de0304:	1ca0      	adds	r0, r4, #2
c0de0306:	e000      	b.n	c0de030a <adjustDecimals+0x9a>
c0de0308:	2002      	movs	r0, #2
        for (uint32_t i = 0; i < srcLength; i++) {
c0de030a:	b146      	cbz	r6, c0de031e <adjustDecimals+0xae>
c0de030c:	183a      	adds	r2, r7, r0
c0de030e:	2100      	movs	r1, #0
            target[offset++] = src[i];
c0de0310:	5c6b      	ldrb	r3, [r5, r1]
c0de0312:	5453      	strb	r3, [r2, r1]
        for (uint32_t i = 0; i < srcLength; i++) {
c0de0314:	3101      	adds	r1, #1
c0de0316:	428e      	cmp	r6, r1
c0de0318:	d1fa      	bne.n	c0de0310 <adjustDecimals+0xa0>
c0de031a:	4401      	add	r1, r0
c0de031c:	e000      	b.n	c0de0320 <adjustDecimals+0xb0>
c0de031e:	4601      	mov	r1, r0
c0de0320:	2300      	movs	r3, #0
    for (uint32_t i = startOffset; i < offset; i++) {
c0de0322:	4288      	cmp	r0, r1
c0de0324:	547b      	strb	r3, [r7, r1]
c0de0326:	d214      	bcs.n	c0de0352 <adjustDecimals+0xe2>
c0de0328:	2200      	movs	r2, #0
c0de032a:	bf00      	nop
        if (target[i] == '0') {
c0de032c:	5c3e      	ldrb	r6, [r7, r0]
c0de032e:	2a00      	cmp	r2, #0
c0de0330:	bf08      	it	eq
c0de0332:	4602      	moveq	r2, r0
c0de0334:	2e30      	cmp	r6, #48	; 0x30
    for (uint32_t i = startOffset; i < offset; i++) {
c0de0336:	f100 0001 	add.w	r0, r0, #1
        if (target[i] == '0') {
c0de033a:	bf18      	it	ne
c0de033c:	461a      	movne	r2, r3
    for (uint32_t i = startOffset; i < offset; i++) {
c0de033e:	4281      	cmp	r1, r0
c0de0340:	d1f4      	bne.n	c0de032c <adjustDecimals+0xbc>
    if (lastZeroOffset != 0) {
c0de0342:	b132      	cbz	r2, c0de0352 <adjustDecimals+0xe2>
        if (target[lastZeroOffset - 1] == '.') {
c0de0344:	1e50      	subs	r0, r2, #1
c0de0346:	5c3b      	ldrb	r3, [r7, r0]
c0de0348:	2100      	movs	r1, #0
c0de034a:	2b2e      	cmp	r3, #46	; 0x2e
        target[lastZeroOffset] = '\0';
c0de034c:	54b9      	strb	r1, [r7, r2]
            target[lastZeroOffset - 1] = '\0';
c0de034e:	bf08      	it	eq
c0de0350:	5439      	strbeq	r1, [r7, r0]
c0de0352:	2001      	movs	r0, #1
}
c0de0354:	b001      	add	sp, #4
c0de0356:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0de0358 <uint256_to_decimal>:
    if (value_len > INT256_LENGTH) {
c0de0358:	2920      	cmp	r1, #32
c0de035a:	bf84      	itt	hi
c0de035c:	2000      	movhi	r0, #0
}
c0de035e:	4770      	bxhi	lr
c0de0360:	e92d 45f0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, lr}
c0de0364:	b089      	sub	sp, #36	; 0x24
c0de0366:	ae01      	add	r6, sp, #4
c0de0368:	460f      	mov	r7, r1
c0de036a:	4605      	mov	r5, r0
    uint16_t n[16] = {0};
c0de036c:	4630      	mov	r0, r6
c0de036e:	2120      	movs	r1, #32
c0de0370:	4698      	mov	r8, r3
c0de0372:	4692      	mov	sl, r2
c0de0374:	f000 fe88 	bl	c0de1088 <__aeabi_memclr>
    memcpy((uint8_t *) n + INT256_LENGTH - value_len, value, value_len);
c0de0378:	1bf0      	subs	r0, r6, r7
c0de037a:	3020      	adds	r0, #32
c0de037c:	4629      	mov	r1, r5
c0de037e:	463a      	mov	r2, r7
c0de0380:	f000 fe85 	bl	c0de108e <__aeabi_memcpy>
} extraInfo_t;

static __attribute__((no_instrument_function)) inline int allzeroes(const void *buf, size_t n) {
    uint8_t *p = (uint8_t *) buf;
    for (size_t i = 0; i < n; ++i) {
        if (p[i]) {
c0de0384:	f89d 0004 	ldrb.w	r0, [sp, #4]
c0de0388:	b948      	cbnz	r0, c0de039e <uint256_to_decimal+0x46>
    for (size_t i = 0; i < n; ++i) {
c0de038a:	1c71      	adds	r1, r6, #1
c0de038c:	2000      	movs	r0, #0
c0de038e:	bf00      	nop
        if (p[i]) {
c0de0390:	5c0a      	ldrb	r2, [r1, r0]
c0de0392:	b912      	cbnz	r2, c0de039a <uint256_to_decimal+0x42>
    for (size_t i = 0; i < n; ++i) {
c0de0394:	3001      	adds	r0, #1
c0de0396:	281f      	cmp	r0, #31
c0de0398:	d1fa      	bne.n	c0de0390 <uint256_to_decimal+0x38>
    if (allzeroes(n, INT256_LENGTH)) {
c0de039a:	281f      	cmp	r0, #31
c0de039c:	d23c      	bcs.n	c0de0418 <uint256_to_decimal+0xc0>
c0de039e:	2000      	movs	r0, #0
        n[i] = __builtin_bswap16(*p++);
c0de03a0:	f836 1010 	ldrh.w	r1, [r6, r0, lsl #1]
c0de03a4:	ba09      	rev	r1, r1
c0de03a6:	0c09      	lsrs	r1, r1, #16
c0de03a8:	f826 1010 	strh.w	r1, [r6, r0, lsl #1]
    for (int i = 0; i < 16; i++) {
c0de03ac:	3001      	adds	r0, #1
c0de03ae:	2810      	cmp	r0, #16
c0de03b0:	d1f6      	bne.n	c0de03a0 <uint256_to_decimal+0x48>
c0de03b2:	4921      	ldr	r1, [pc, #132]	; (c0de0438 <uint256_to_decimal+0xe0>)
    while (!allzeroes(n, sizeof(n))) {
c0de03b4:	1c70      	adds	r0, r6, #1
c0de03b6:	4642      	mov	r2, r8
        if (p[i]) {
c0de03b8:	f89d 3004 	ldrb.w	r3, [sp, #4]
c0de03bc:	b93b      	cbnz	r3, c0de03ce <uint256_to_decimal+0x76>
c0de03be:	2300      	movs	r3, #0
c0de03c0:	5cc7      	ldrb	r7, [r0, r3]
c0de03c2:	b917      	cbnz	r7, c0de03ca <uint256_to_decimal+0x72>
    for (size_t i = 0; i < n; ++i) {
c0de03c4:	3301      	adds	r3, #1
c0de03c6:	2b1f      	cmp	r3, #31
c0de03c8:	d1fa      	bne.n	c0de03c0 <uint256_to_decimal+0x68>
c0de03ca:	2b1e      	cmp	r3, #30
c0de03cc:	d818      	bhi.n	c0de0400 <uint256_to_decimal+0xa8>
        if (pos == 0) {
c0de03ce:	b332      	cbz	r2, c0de041e <uint256_to_decimal+0xc6>
c0de03d0:	2300      	movs	r3, #0
c0de03d2:	2700      	movs	r7, #0
            int rem = ((carry << 16) | n[i]) % 10;
c0de03d4:	f836 5013 	ldrh.w	r5, [r6, r3, lsl #1]
c0de03d8:	ea45 4707 	orr.w	r7, r5, r7, lsl #16
            n[i] = ((carry << 16) | n[i]) / 10;
c0de03dc:	fba7 5401 	umull	r5, r4, r7, r1
c0de03e0:	08e5      	lsrs	r5, r4, #3
c0de03e2:	eb05 0485 	add.w	r4, r5, r5, lsl #2
c0de03e6:	f826 5013 	strh.w	r5, [r6, r3, lsl #1]
        for (int i = 0; i < 16; i++) {
c0de03ea:	3301      	adds	r3, #1
c0de03ec:	2b10      	cmp	r3, #16
c0de03ee:	eba7 0744 	sub.w	r7, r7, r4, lsl #1
c0de03f2:	d1ef      	bne.n	c0de03d4 <uint256_to_decimal+0x7c>
        pos -= 1;
c0de03f4:	3a01      	subs	r2, #1
        out[pos] = '0' + carry;
c0de03f6:	f047 0330 	orr.w	r3, r7, #48	; 0x30
c0de03fa:	f80a 3002 	strb.w	r3, [sl, r2]
c0de03fe:	e7db      	b.n	c0de03b8 <uint256_to_decimal+0x60>
    memmove(out, out + pos, out_len - pos);
c0de0400:	eba8 0502 	sub.w	r5, r8, r2
c0de0404:	eb0a 0102 	add.w	r1, sl, r2
c0de0408:	4650      	mov	r0, sl
c0de040a:	462a      	mov	r2, r5
c0de040c:	f000 fe41 	bl	c0de1092 <__aeabi_memmove>
c0de0410:	2000      	movs	r0, #0
    out[out_len - pos] = 0;
c0de0412:	f80a 0005 	strb.w	r0, [sl, r5]
c0de0416:	e00a      	b.n	c0de042e <uint256_to_decimal+0xd6>
        if (out_len < 2) {
c0de0418:	f1b8 0f02 	cmp.w	r8, #2
c0de041c:	d201      	bcs.n	c0de0422 <uint256_to_decimal+0xca>
c0de041e:	2000      	movs	r0, #0
c0de0420:	e006      	b.n	c0de0430 <uint256_to_decimal+0xd8>
        strlcpy(out, "0", out_len);
c0de0422:	4906      	ldr	r1, [pc, #24]	; (c0de043c <uint256_to_decimal+0xe4>)
c0de0424:	4650      	mov	r0, sl
c0de0426:	4479      	add	r1, pc
c0de0428:	4642      	mov	r2, r8
c0de042a:	f000 fe9a 	bl	c0de1162 <strlcpy>
c0de042e:	2001      	movs	r0, #1
c0de0430:	b009      	add	sp, #36	; 0x24
c0de0432:	e8bd 85f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, pc}
c0de0436:	bf00      	nop
c0de0438:	cccccccd 	.word	0xcccccccd
c0de043c:	00000dd0 	.word	0x00000dd0

c0de0440 <amountToString>:
                    size_t out_buffer_size) {
c0de0440:	e92d 4df0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
c0de0444:	b09a      	sub	sp, #104	; 0x68
c0de0446:	af01      	add	r7, sp, #4
c0de0448:	460c      	mov	r4, r1
c0de044a:	4605      	mov	r5, r0
    char tmp_buffer[100] = {0};
c0de044c:	4638      	mov	r0, r7
c0de044e:	2164      	movs	r1, #100	; 0x64
c0de0450:	461e      	mov	r6, r3
c0de0452:	4690      	mov	r8, r2
c0de0454:	f000 fe18 	bl	c0de1088 <__aeabi_memclr>
    if (uint256_to_decimal(amount, amount_size, tmp_buffer, sizeof(tmp_buffer)) == false) {
c0de0458:	4628      	mov	r0, r5
c0de045a:	4621      	mov	r1, r4
c0de045c:	463a      	mov	r2, r7
c0de045e:	2364      	movs	r3, #100	; 0x64
c0de0460:	f7ff ff7a 	bl	c0de0358 <uint256_to_decimal>
c0de0464:	b380      	cbz	r0, c0de04c8 <amountToString+0x88>
c0de0466:	e9dd ab22 	ldrd	sl, fp, [sp, #136]	; 0x88
c0de046a:	a801      	add	r0, sp, #4
    uint8_t amount_len = strnlen(tmp_buffer, sizeof(tmp_buffer));
c0de046c:	2164      	movs	r1, #100	; 0x64
c0de046e:	f000 fe95 	bl	c0de119c <strnlen>
c0de0472:	4607      	mov	r7, r0
    uint8_t ticker_len = strnlen(ticker, MAX_TICKER_LEN);
c0de0474:	4630      	mov	r0, r6
c0de0476:	210b      	movs	r1, #11
c0de0478:	f000 fe90 	bl	c0de119c <strnlen>
    memcpy(out_buffer, ticker, MIN(out_buffer_size, ticker_len));
c0de047c:	b2c5      	uxtb	r5, r0
    uint8_t ticker_len = strnlen(ticker, MAX_TICKER_LEN);
c0de047e:	4604      	mov	r4, r0
    memcpy(out_buffer, ticker, MIN(out_buffer_size, ticker_len));
c0de0480:	462a      	mov	r2, r5
c0de0482:	4650      	mov	r0, sl
c0de0484:	4631      	mov	r1, r6
c0de0486:	455d      	cmp	r5, fp
c0de0488:	bf88      	it	hi
c0de048a:	465a      	movhi	r2, fp
c0de048c:	f000 fdff 	bl	c0de108e <__aeabi_memcpy>
    if (ticker_len > 0) {
c0de0490:	b12d      	cbz	r5, c0de049e <amountToString+0x5e>
        out_buffer[ticker_len++] = ' ';
c0de0492:	1c60      	adds	r0, r4, #1
c0de0494:	2120      	movs	r1, #32
                       out_buffer + ticker_len,
c0de0496:	b2c0      	uxtb	r0, r0
        out_buffer[ticker_len++] = ' ';
c0de0498:	f80a 1005 	strb.w	r1, [sl, r5]
c0de049c:	e000      	b.n	c0de04a0 <amountToString+0x60>
c0de049e:	2000      	movs	r0, #0
                       out_buffer + ticker_len,
c0de04a0:	eb0a 0200 	add.w	r2, sl, r0
                       out_buffer_size - ticker_len - 1,
c0de04a4:	43c0      	mvns	r0, r0
                       amount_len,
c0de04a6:	b2f9      	uxtb	r1, r7
                       out_buffer_size - ticker_len - 1,
c0de04a8:	eb00 030b 	add.w	r3, r0, fp
c0de04ac:	a801      	add	r0, sp, #4
    if (adjustDecimals(tmp_buffer,
c0de04ae:	f8cd 8000 	str.w	r8, [sp]
c0de04b2:	f7ff fedd 	bl	c0de0270 <adjustDecimals>
c0de04b6:	b138      	cbz	r0, c0de04c8 <amountToString+0x88>
    out_buffer[out_buffer_size - 1] = '\0';
c0de04b8:	eb0b 000a 	add.w	r0, fp, sl
c0de04bc:	2100      	movs	r1, #0
c0de04be:	f800 1c01 	strb.w	r1, [r0, #-1]
}
c0de04c2:	b01a      	add	sp, #104	; 0x68
c0de04c4:	e8bd 8df0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, fp, pc}
c0de04c8:	2007      	movs	r0, #7
c0de04ca:	f000 fa11 	bl	c0de08f0 <os_longjmp>

c0de04ce <copy_address>:

void copy_address(uint8_t* dst, const uint8_t* parameter, uint8_t dst_size) {
c0de04ce:	b580      	push	{r7, lr}
    uint8_t copy_size = MIN(dst_size, ADDRESS_LENGTH);
c0de04d0:	2a14      	cmp	r2, #20
c0de04d2:	bf28      	it	cs
c0de04d4:	2214      	movcs	r2, #20
    memmove(dst, parameter + PARAMETER_LENGTH - copy_size, copy_size);
c0de04d6:	1a89      	subs	r1, r1, r2
c0de04d8:	3120      	adds	r1, #32
c0de04da:	f000 fdda 	bl	c0de1092 <__aeabi_memmove>
}
c0de04de:	bd80      	pop	{r7, pc}

c0de04e0 <handle_finalize>:
#include "lido_plugin.h"

void handle_finalize(void *parameters) {
c0de04e0:	b5b0      	push	{r4, r5, r7, lr}
c0de04e2:	4604      	mov	r4, r0
    ethPluginFinalize_t *msg = (ethPluginFinalize_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
c0de04e4:	6885      	ldr	r5, [r0, #8]
    PRINTF("handle finalize\n");
c0de04e6:	480d      	ldr	r0, [pc, #52]	; (c0de051c <handle_finalize+0x3c>)
c0de04e8:	4478      	add	r0, pc
c0de04ea:	f000 fa25 	bl	c0de0938 <mcu_usb_printf>
    if (context->valid) {
c0de04ee:	f895 0055 	ldrb.w	r0, [r5, #85]	; 0x55
c0de04f2:	b128      	cbz	r0, c0de0500 <handle_finalize+0x20>
       switch (context->selectorIndex) {
c0de04f4:	f895 0054 	ldrb.w	r0, [r5, #84]	; 0x54
c0de04f8:	2803      	cmp	r0, #3
c0de04fa:	d207      	bcs.n	c0de050c <handle_finalize+0x2c>
c0de04fc:	2001      	movs	r0, #1
c0de04fe:	e007      	b.n	c0de0510 <handle_finalize+0x30>
            break;
        }
        msg->uiType = ETH_UI_TYPE_GENERIC;
        msg->result = ETH_PLUGIN_RESULT_OK;
    } else {
        PRINTF("Invalid context\n");
c0de0500:	4807      	ldr	r0, [pc, #28]	; (c0de0520 <handle_finalize+0x40>)
c0de0502:	4478      	add	r0, pc
c0de0504:	f000 fa18 	bl	c0de0938 <mcu_usb_printf>
c0de0508:	2006      	movs	r0, #6
c0de050a:	e005      	b.n	c0de0518 <handle_finalize+0x38>
       switch (context->selectorIndex) {
c0de050c:	d101      	bne.n	c0de0512 <handle_finalize+0x32>
c0de050e:	2002      	movs	r0, #2
c0de0510:	7760      	strb	r0, [r4, #29]
c0de0512:	2002      	movs	r0, #2
        msg->uiType = ETH_UI_TYPE_GENERIC;
c0de0514:	7720      	strb	r0, [r4, #28]
c0de0516:	2004      	movs	r0, #4
c0de0518:	77a0      	strb	r0, [r4, #30]
        msg->result = ETH_PLUGIN_RESULT_FALLBACK;
    }
}
c0de051a:	bdb0      	pop	{r4, r5, r7, pc}
c0de051c:	00000d8a 	.word	0x00000d8a
c0de0520:	00000e7b 	.word	0x00000e7b

c0de0524 <handle_init_contract>:
#include "lido_plugin.h"

// Called once to init.
void handle_init_contract(void *parameters) {
c0de0524:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
c0de0528:	4604      	mov	r4, r0
    ethPluginInitContract_t *msg = (ethPluginInitContract_t *) parameters;

    if (msg->interfaceVersion != ETH_PLUGIN_INTERFACE_VERSION_LATEST) {
c0de052a:	7800      	ldrb	r0, [r0, #0]
c0de052c:	2806      	cmp	r0, #6
c0de052e:	d104      	bne.n	c0de053a <handle_init_contract+0x16>
        msg->result = ETH_PLUGIN_RESULT_UNAVAILABLE;
        return;
    }

    if (msg->pluginContextLength < sizeof(lido_parameters_t)) {
c0de0530:	6920      	ldr	r0, [r4, #16]
c0de0532:	2856      	cmp	r0, #86	; 0x56
c0de0534:	d203      	bcs.n	c0de053e <handle_init_contract+0x1a>
c0de0536:	2000      	movs	r0, #0
c0de0538:	e044      	b.n	c0de05c4 <handle_init_contract+0xa0>
c0de053a:	2001      	movs	r0, #1
c0de053c:	e042      	b.n	c0de05c4 <handle_init_contract+0xa0>
        msg->result = ETH_PLUGIN_RESULT_ERROR;
        return;
    }

    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
c0de053e:	f8d4 800c 	ldr.w	r8, [r4, #12]
    memset(context, 0, sizeof(*context));
c0de0542:	2156      	movs	r1, #86	; 0x56
c0de0544:	4640      	mov	r0, r8
c0de0546:	f000 fd9f 	bl	c0de1088 <__aeabi_memclr>
c0de054a:	4f22      	ldr	r7, [pc, #136]	; (c0de05d4 <handle_init_contract+0xb0>)
c0de054c:	2600      	movs	r6, #0
c0de054e:	447f      	add	r7, pc

    for (int i = 0; i < NUM_LIDO_SELECTORS; i++) {
        if (memcmp(PIC(LIDO_SELECTORS[i]), msg->selector, SELECTOR_SIZE) == 0) {
c0de0550:	f857 0026 	ldr.w	r0, [r7, r6, lsl #2]
c0de0554:	f000 fb90 	bl	c0de0c78 <pic>
c0de0558:	7802      	ldrb	r2, [r0, #0]
c0de055a:	7883      	ldrb	r3, [r0, #2]
c0de055c:	78c5      	ldrb	r5, [r0, #3]
c0de055e:	7840      	ldrb	r0, [r0, #1]
c0de0560:	6961      	ldr	r1, [r4, #20]
c0de0562:	ea43 2305 	orr.w	r3, r3, r5, lsl #8
c0de0566:	ea42 2000 	orr.w	r0, r2, r0, lsl #8
c0de056a:	ea40 4003 	orr.w	r0, r0, r3, lsl #16
c0de056e:	780a      	ldrb	r2, [r1, #0]
c0de0570:	788b      	ldrb	r3, [r1, #2]
c0de0572:	78cd      	ldrb	r5, [r1, #3]
c0de0574:	7849      	ldrb	r1, [r1, #1]
c0de0576:	ea43 2305 	orr.w	r3, r3, r5, lsl #8
c0de057a:	ea42 2101 	orr.w	r1, r2, r1, lsl #8
c0de057e:	ea41 4103 	orr.w	r1, r1, r3, lsl #16
c0de0582:	4288      	cmp	r0, r1
c0de0584:	d005      	beq.n	c0de0592 <handle_init_contract+0x6e>
    for (int i = 0; i < NUM_LIDO_SELECTORS; i++) {
c0de0586:	3601      	adds	r6, #1
c0de0588:	2e04      	cmp	r6, #4
c0de058a:	d1e1      	bne.n	c0de0550 <handle_init_contract+0x2c>
            break;
        }
    }
    context->valid = 0; // init on false for security
    // Set `next_param` to be the first field we expect to parse.
    switch (context->selectorIndex) {
c0de058c:	f898 6054 	ldrb.w	r6, [r8, #84]	; 0x54
c0de0590:	e001      	b.n	c0de0596 <handle_init_contract+0x72>
            context->selectorIndex = i;
c0de0592:	f888 6054 	strb.w	r6, [r8, #84]	; 0x54
    switch (context->selectorIndex) {
c0de0596:	b2f0      	uxtb	r0, r6
c0de0598:	1e42      	subs	r2, r0, #1
c0de059a:	2100      	movs	r1, #0
c0de059c:	2a02      	cmp	r2, #2
    context->valid = 0; // init on false for security
c0de059e:	f888 1055 	strb.w	r1, [r8, #85]	; 0x55
    switch (context->selectorIndex) {
c0de05a2:	d309      	bcc.n	c0de05b8 <handle_init_contract+0x94>
c0de05a4:	b150      	cbz	r0, c0de05bc <handle_init_contract+0x98>
c0de05a6:	2803      	cmp	r0, #3
c0de05a8:	d10f      	bne.n	c0de05ca <handle_init_contract+0xa6>
        case UNWRAP:
        case WRAP:
            context->next_param = AMOUNT_SENT;
            break;
        case REQUEST_WITHDRAWALS_WITH_PERMIT:
            context->skip++; // skip offset
c0de05aa:	f898 0051 	ldrb.w	r0, [r8, #81]	; 0x51
c0de05ae:	3001      	adds	r0, #1
c0de05b0:	f888 0051 	strb.w	r0, [r8, #81]	; 0x51
c0de05b4:	2001      	movs	r0, #1
c0de05b6:	e002      	b.n	c0de05be <handle_init_contract+0x9a>
c0de05b8:	2000      	movs	r0, #0
c0de05ba:	e000      	b.n	c0de05be <handle_init_contract+0x9a>
c0de05bc:	2002      	movs	r0, #2
c0de05be:	f888 0053 	strb.w	r0, [r8, #83]	; 0x53
c0de05c2:	2004      	movs	r0, #4
c0de05c4:	7060      	strb	r0, [r4, #1]
            PRINTF("Missing selectorIndex\n");
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }
    msg->result = ETH_PLUGIN_RESULT_OK;
}
c0de05c6:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
            PRINTF("Missing selectorIndex\n");
c0de05ca:	4803      	ldr	r0, [pc, #12]	; (c0de05d8 <handle_init_contract+0xb4>)
c0de05cc:	4478      	add	r0, pc
c0de05ce:	f000 f9b3 	bl	c0de0938 <mcu_usb_printf>
c0de05d2:	e7b0      	b.n	c0de0536 <handle_init_contract+0x12>
c0de05d4:	00000c72 	.word	0x00000c72
c0de05d8:	00000cf8 	.word	0x00000cf8

c0de05dc <handle_provide_parameter>:
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
}

void handle_provide_parameter(void *parameters) {
c0de05dc:	b5b0      	push	{r4, r5, r7, lr}
c0de05de:	4605      	mov	r5, r0
    ethPluginProvideParameter_t *msg = (ethPluginProvideParameter_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
c0de05e0:	e9d0 4302 	ldrd	r4, r3, [r0, #8]
    PRINTF("plugin provide parameter %d %.*H\n",
           msg->parameterOffset,
c0de05e4:	6901      	ldr	r1, [r0, #16]
    PRINTF("plugin provide parameter %d %.*H\n",
c0de05e6:	4835      	ldr	r0, [pc, #212]	; (c0de06bc <handle_provide_parameter+0xe0>)
c0de05e8:	2220      	movs	r2, #32
c0de05ea:	4478      	add	r0, pc
c0de05ec:	f000 f9a4 	bl	c0de0938 <mcu_usb_printf>
           msg->parameter);

    msg->result = ETH_PLUGIN_RESULT_OK;

 // If not used remove from here
    if (context->skip) {
c0de05f0:	f894 0051 	ldrb.w	r0, [r4, #81]	; 0x51
c0de05f4:	2104      	movs	r1, #4
    msg->result = ETH_PLUGIN_RESULT_OK;
c0de05f6:	7529      	strb	r1, [r5, #20]
    if (context->skip) {
c0de05f8:	b1a8      	cbz	r0, c0de0626 <handle_provide_parameter+0x4a>
        // Skip this step, and don't forget to decrease skipping counter.
        context->skip--;
c0de05fa:	3801      	subs	r0, #1
c0de05fc:	f884 0051 	strb.w	r0, [r4, #81]	; 0x51
                   msg->parameterOffset);
            return;
        }    
    }
    context->offset = 0;
    switch (context->selectorIndex) {
c0de0600:	f894 1054 	ldrb.w	r1, [r4, #84]	; 0x54
c0de0604:	2000      	movs	r0, #0
c0de0606:	1e4a      	subs	r2, r1, #1
c0de0608:	2a02      	cmp	r2, #2
    context->offset = 0;
c0de060a:	f8a4 004a 	strh.w	r0, [r4, #74]	; 0x4a
    switch (context->selectorIndex) {
c0de060e:	d31a      	bcc.n	c0de0646 <handle_provide_parameter+0x6a>
c0de0610:	2903      	cmp	r1, #3
c0de0612:	d020      	beq.n	c0de0656 <handle_provide_parameter+0x7a>
c0de0614:	bbb9      	cbnz	r1, c0de0686 <handle_provide_parameter+0xaa>
    if (context->next_param == REFERRAL) {
c0de0616:	f894 0053 	ldrb.w	r0, [r4, #83]	; 0x53
c0de061a:	2802      	cmp	r0, #2
c0de061c:	d13a      	bne.n	c0de0694 <handle_provide_parameter+0xb8>
c0de061e:	2003      	movs	r0, #3
        context->next_param = NONE;
c0de0620:	f884 0053 	strb.w	r0, [r4, #83]	; 0x53
c0de0624:	e03c      	b.n	c0de06a0 <handle_provide_parameter+0xc4>
        if ((context->offset) && msg->parameterOffset != context->checkpoint + context->offset) {
c0de0626:	f8b4 104a 	ldrh.w	r1, [r4, #74]	; 0x4a
c0de062a:	2900      	cmp	r1, #0
c0de062c:	d0e8      	beq.n	c0de0600 <handle_provide_parameter+0x24>
c0de062e:	f8b4 204c 	ldrh.w	r2, [r4, #76]	; 0x4c
c0de0632:	692b      	ldr	r3, [r5, #16]
c0de0634:	1850      	adds	r0, r2, r1
c0de0636:	4283      	cmp	r3, r0
c0de0638:	d0e2      	beq.n	c0de0600 <handle_provide_parameter+0x24>
            PRINTF("offset: %d, checkpoint: %d, parameterOffset: %d\n",
c0de063a:	4824      	ldr	r0, [pc, #144]	; (c0de06cc <handle_provide_parameter+0xf0>)
c0de063c:	4478      	add	r0, pc
c0de063e:	e8bd 40b0 	ldmia.w	sp!, {r4, r5, r7, lr}
c0de0642:	f000 b979 	b.w	c0de0938 <mcu_usb_printf>
    switch (context->next_param) {
c0de0646:	f894 0053 	ldrb.w	r0, [r4, #83]	; 0x53
c0de064a:	b198      	cbz	r0, c0de0674 <handle_provide_parameter+0x98>
c0de064c:	481d      	ldr	r0, [pc, #116]	; (c0de06c4 <handle_provide_parameter+0xe8>)
c0de064e:	4478      	add	r0, pc
c0de0650:	f000 f972 	bl	c0de0938 <mcu_usb_printf>
c0de0654:	e01b      	b.n	c0de068e <handle_provide_parameter+0xb2>
    switch (context->next_param) {
c0de0656:	f894 0053 	ldrb.w	r0, [r4, #83]	; 0x53
c0de065a:	b158      	cbz	r0, c0de0674 <handle_provide_parameter+0x98>
c0de065c:	2803      	cmp	r0, #3
c0de065e:	d028      	beq.n	c0de06b2 <handle_provide_parameter+0xd6>
c0de0660:	2801      	cmp	r0, #1
c0de0662:	d1f3      	bne.n	c0de064c <handle_provide_parameter+0x70>
                 msg->parameter,
c0de0664:	68e9      	ldr	r1, [r5, #12]
    copy_address(context->address_sent,
c0de0666:	f104 0020 	add.w	r0, r4, #32
c0de066a:	2214      	movs	r2, #20
c0de066c:	f7ff ff2f 	bl	c0de04ce <copy_address>
c0de0670:	2000      	movs	r0, #0
c0de0672:	e005      	b.n	c0de0680 <handle_provide_parameter+0xa4>
c0de0674:	68e9      	ldr	r1, [r5, #12]
c0de0676:	4620      	mov	r0, r4
c0de0678:	2220      	movs	r2, #32
c0de067a:	f000 fd08 	bl	c0de108e <__aeabi_memcpy>
c0de067e:	2003      	movs	r0, #3
c0de0680:	f884 0053 	strb.w	r0, [r4, #83]	; 0x53
c0de0684:	e015      	b.n	c0de06b2 <handle_provide_parameter+0xd6>
            break;
        case REQUEST_WITHDRAWALS_WITH_PERMIT:
            handle_permit(msg, context);
            break;
        default:
            PRINTF("Selector Index %d not supported\n", context->selectorIndex);
c0de0686:	4810      	ldr	r0, [pc, #64]	; (c0de06c8 <handle_provide_parameter+0xec>)
c0de0688:	4478      	add	r0, pc
c0de068a:	f000 f955 	bl	c0de0938 <mcu_usb_printf>
c0de068e:	2000      	movs	r0, #0
c0de0690:	7528      	strb	r0, [r5, #20]
c0de0692:	e00e      	b.n	c0de06b2 <handle_provide_parameter+0xd6>
        PRINTF("Param not supported\n");
c0de0694:	480a      	ldr	r0, [pc, #40]	; (c0de06c0 <handle_provide_parameter+0xe4>)
c0de0696:	4478      	add	r0, pc
c0de0698:	f000 f94e 	bl	c0de0938 <mcu_usb_printf>
c0de069c:	2000      	movs	r0, #0
        msg->result = ETH_PLUGIN_RESULT_ERROR;
c0de069e:	7528      	strb	r0, [r5, #20]
           &msg->pluginSharedRO->txContent->value.value,
c0de06a0:	6868      	ldr	r0, [r5, #4]
c0de06a2:	6800      	ldr	r0, [r0, #0]
           msg->pluginSharedRO->txContent->value.length);
c0de06a4:	f890 2062 	ldrb.w	r2, [r0, #98]	; 0x62
    memcpy(context->amount_sent,
c0de06a8:	f100 0142 	add.w	r1, r0, #66	; 0x42
c0de06ac:	4620      	mov	r0, r4
c0de06ae:	f000 fcee 	bl	c0de108e <__aeabi_memcpy>
c0de06b2:	2001      	movs	r0, #1
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            break;
    }
    // set valid to true after parsing all parameters
    context->valid = 1;
c0de06b4:	f884 0055 	strb.w	r0, [r4, #85]	; 0x55
c0de06b8:	bdb0      	pop	{r4, r5, r7, pc}
c0de06ba:	bf00      	nop
c0de06bc:	00000c2b 	.word	0x00000c2b
c0de06c0:	00000b42 	.word	0x00000b42
c0de06c4:	00000b8a 	.word	0x00000b8a
c0de06c8:	00000d0d 	.word	0x00000d0d
c0de06cc:	00000bfb 	.word	0x00000bfb

c0de06d0 <handle_provide_token>:
#include "lido_plugin.h"

void handle_provide_token(void *parameters) {
c0de06d0:	b510      	push	{r4, lr}
c0de06d2:	4604      	mov	r4, r0
    ethPluginProvideInfo_t *msg = (ethPluginProvideInfo_t *) parameters;
    PRINTF("plugin provide token: 0x%p, 0x%p\n", msg->item1, msg->item2);
c0de06d4:	e9d0 1203 	ldrd	r1, r2, [r0, #12]
c0de06d8:	4803      	ldr	r0, [pc, #12]	; (c0de06e8 <handle_provide_token+0x18>)
c0de06da:	4478      	add	r0, pc
c0de06dc:	f000 f92c 	bl	c0de0938 <mcu_usb_printf>
c0de06e0:	2004      	movs	r0, #4

    msg->result = ETH_PLUGIN_RESULT_OK;
c0de06e2:	7560      	strb	r0, [r4, #21]
}
c0de06e4:	bd10      	pop	{r4, pc}
c0de06e6:	bf00      	nop
c0de06e8:	00000c01 	.word	0x00000c01

c0de06ec <handle_query_contract_id>:
#include "lido_plugin.h"

void handle_query_contract_id(void *parameters) {
c0de06ec:	b5b0      	push	{r4, r5, r7, lr}
c0de06ee:	4604      	mov	r4, r0
    ethQueryContractID_t *msg = (ethQueryContractID_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
c0de06f0:	e9d0 5002 	ldrd	r5, r0, [r0, #8]

    strlcpy(msg->name, PLUGIN_NAME, msg->nameLength);
c0de06f4:	6922      	ldr	r2, [r4, #16]
c0de06f6:	4913      	ldr	r1, [pc, #76]	; (c0de0744 <handle_query_contract_id+0x58>)
c0de06f8:	4479      	add	r1, pc
c0de06fa:	f000 fd32 	bl	c0de1162 <strlcpy>

    switch (context->selectorIndex) {
c0de06fe:	f895 1054 	ldrb.w	r1, [r5, #84]	; 0x54
c0de0702:	2901      	cmp	r1, #1
c0de0704:	dc05      	bgt.n	c0de0712 <handle_query_contract_id+0x26>
c0de0706:	b189      	cbz	r1, c0de072c <handle_query_contract_id+0x40>
c0de0708:	2901      	cmp	r1, #1
c0de070a:	d109      	bne.n	c0de0720 <handle_query_contract_id+0x34>
c0de070c:	4911      	ldr	r1, [pc, #68]	; (c0de0754 <handle_query_contract_id+0x68>)
c0de070e:	4479      	add	r1, pc
c0de0710:	e011      	b.n	c0de0736 <handle_query_contract_id+0x4a>
c0de0712:	2902      	cmp	r1, #2
c0de0714:	d00d      	beq.n	c0de0732 <handle_query_contract_id+0x46>
c0de0716:	2903      	cmp	r1, #3
c0de0718:	d102      	bne.n	c0de0720 <handle_query_contract_id+0x34>
c0de071a:	490c      	ldr	r1, [pc, #48]	; (c0de074c <handle_query_contract_id+0x60>)
c0de071c:	4479      	add	r1, pc
c0de071e:	e00a      	b.n	c0de0736 <handle_query_contract_id+0x4a>
            break;
        case REQUEST_WITHDRAWALS_WITH_PERMIT:
            strlcpy(msg->version, "Request withdrawals with permit", msg->versionLength);
            break;
        default:
            PRINTF("Selector Index :%d not supported\n", context->selectorIndex);
c0de0720:	480b      	ldr	r0, [pc, #44]	; (c0de0750 <handle_query_contract_id+0x64>)
c0de0722:	4478      	add	r0, pc
c0de0724:	f000 f908 	bl	c0de0938 <mcu_usb_printf>
c0de0728:	2000      	movs	r0, #0
c0de072a:	e009      	b.n	c0de0740 <handle_query_contract_id+0x54>
c0de072c:	4906      	ldr	r1, [pc, #24]	; (c0de0748 <handle_query_contract_id+0x5c>)
c0de072e:	4479      	add	r1, pc
c0de0730:	e001      	b.n	c0de0736 <handle_query_contract_id+0x4a>
c0de0732:	4909      	ldr	r1, [pc, #36]	; (c0de0758 <handle_query_contract_id+0x6c>)
c0de0734:	4479      	add	r1, pc
c0de0736:	e9d4 0205 	ldrd	r0, r2, [r4, #20]
c0de073a:	f000 fd12 	bl	c0de1162 <strlcpy>
c0de073e:	2004      	movs	r0, #4
c0de0740:	7720      	strb	r0, [r4, #28]
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }

    msg->result = ETH_PLUGIN_RESULT_OK;
c0de0742:	bdb0      	pop	{r4, r5, r7, pc}
c0de0744:	00000c3b 	.word	0x00000c3b
c0de0748:	00000aca 	.word	0x00000aca
c0de074c:	00000be1 	.word	0x00000be1
c0de0750:	00000c1b 	.word	0x00000c1b
c0de0754:	00000c2a 	.word	0x00000c2a
c0de0758:	00000c5a 	.word	0x00000c5a

c0de075c <handle_query_contract_ui>:
            return ERROR;
    }
    return ERROR;
}

void handle_query_contract_ui(void *parameters) {
c0de075c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0de075e:	b083      	sub	sp, #12
c0de0760:	4604      	mov	r4, r0
    ethQueryContractUI_t *msg = (ethQueryContractUI_t *) parameters;
    lido_parameters_t *context = (lido_parameters_t *) msg->pluginContext;
c0de0762:	69c5      	ldr	r5, [r0, #28]

    memset(msg->title, 0, msg->titleLength);
c0de0764:	6a40      	ldr	r0, [r0, #36]	; 0x24
c0de0766:	6aa1      	ldr	r1, [r4, #40]	; 0x28
c0de0768:	f000 fc8e 	bl	c0de1088 <__aeabi_memclr>
    memset(msg->msg, 0, msg->msgLength);
c0de076c:	e9d4 010b 	ldrd	r0, r1, [r4, #44]	; 0x2c
c0de0770:	f000 fc8a 	bl	c0de1088 <__aeabi_memclr>
    switch (context->selectorIndex) {
c0de0774:	f895 1054 	ldrb.w	r1, [r5, #84]	; 0x54
    uint8_t index = msg->screenIndex;
c0de0778:	f894 0020 	ldrb.w	r0, [r4, #32]
c0de077c:	2204      	movs	r2, #4
    switch (context->selectorIndex) {
c0de077e:	2903      	cmp	r1, #3
    msg->result = ETH_PLUGIN_RESULT_OK;
c0de0780:	f884 2034 	strb.w	r2, [r4, #52]	; 0x34
    switch (context->selectorIndex) {
c0de0784:	d20a      	bcs.n	c0de079c <handle_query_contract_ui+0x40>
c0de0786:	b990      	cbnz	r0, c0de07ae <handle_query_contract_ui+0x52>
    switch (context->selectorIndex) {
c0de0788:	b389      	cbz	r1, c0de07ee <handle_query_contract_ui+0x92>
c0de078a:	2901      	cmp	r1, #1
c0de078c:	d034      	beq.n	c0de07f8 <handle_query_contract_ui+0x9c>
c0de078e:	2902      	cmp	r1, #2
c0de0790:	d154      	bne.n	c0de083c <handle_query_contract_ui+0xe0>
c0de0792:	4f36      	ldr	r7, [pc, #216]	; (c0de086c <handle_query_contract_ui+0x110>)
c0de0794:	4936      	ldr	r1, [pc, #216]	; (c0de0870 <handle_query_contract_ui+0x114>)
c0de0796:	447f      	add	r7, pc
c0de0798:	4479      	add	r1, pc
c0de079a:	e031      	b.n	c0de0800 <handle_query_contract_ui+0xa4>
    switch (context->selectorIndex) {
c0de079c:	d107      	bne.n	c0de07ae <handle_query_contract_ui+0x52>
c0de079e:	f04f 0600 	mov.w	r6, #0
c0de07a2:	b168      	cbz	r0, c0de07c0 <handle_query_contract_ui+0x64>
c0de07a4:	2801      	cmp	r0, #1
c0de07a6:	d102      	bne.n	c0de07ae <handle_query_contract_ui+0x52>
c0de07a8:	492d      	ldr	r1, [pc, #180]	; (c0de0860 <handle_query_contract_ui+0x104>)
c0de07aa:	4479      	add	r1, pc
c0de07ac:	e029      	b.n	c0de0802 <handle_query_contract_ui+0xa6>
            break;
        case ADDRESS_SCREEN:
            set_address_ui(msg, context);
            break;
        default:
            PRINTF("Received an invalid screenIndex %d\n", screen);
c0de07ae:	4835      	ldr	r0, [pc, #212]	; (c0de0884 <handle_query_contract_ui+0x128>)
c0de07b0:	2102      	movs	r1, #2
c0de07b2:	4478      	add	r0, pc
c0de07b4:	f000 f8c0 	bl	c0de0938 <mcu_usb_printf>
c0de07b8:	2000      	movs	r0, #0
c0de07ba:	f884 0034 	strb.w	r0, [r4, #52]	; 0x34
c0de07be:	e04c      	b.n	c0de085a <handle_query_contract_ui+0xfe>
            strlcpy(msg->title, "Owner", msg->titleLength);
c0de07c0:	e9d4 0209 	ldrd	r0, r2, [r4, #36]	; 0x24
c0de07c4:	492e      	ldr	r1, [pc, #184]	; (c0de0880 <handle_query_contract_ui+0x124>)
c0de07c6:	4479      	add	r1, pc
c0de07c8:	f000 fccb 	bl	c0de1162 <strlcpy>
    msg->msg[0] = '0';
c0de07cc:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0de07ce:	2130      	movs	r1, #48	; 0x30
c0de07d0:	7001      	strb	r1, [r0, #0]
    msg->msg[1] = 'x';
c0de07d2:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0de07d4:	2178      	movs	r1, #120	; 0x78
c0de07d6:	7041      	strb	r1, [r0, #1]
                                  msg->pluginSharedRW->sha3,
c0de07d8:	6821      	ldr	r1, [r4, #0]
                                  msg->msg + 2,
c0de07da:	6ae3      	ldr	r3, [r4, #44]	; 0x2c
                                  msg->pluginSharedRW->sha3,
c0de07dc:	680a      	ldr	r2, [r1, #0]
    getEthAddressStringFromBinary((uint8_t *) context->address_sent,
c0de07de:	f105 0020 	add.w	r0, r5, #32
                                  msg->msg + 2,
c0de07e2:	1c99      	adds	r1, r3, #2
    getEthAddressStringFromBinary((uint8_t *) context->address_sent,
c0de07e4:	e9cd 6600 	strd	r6, r6, [sp]
c0de07e8:	f7ff fc7c 	bl	c0de00e4 <getEthAddressStringFromBinary>
c0de07ec:	e035      	b.n	c0de085a <handle_query_contract_ui+0xfe>
c0de07ee:	4f1d      	ldr	r7, [pc, #116]	; (c0de0864 <handle_query_contract_ui+0x108>)
c0de07f0:	491d      	ldr	r1, [pc, #116]	; (c0de0868 <handle_query_contract_ui+0x10c>)
c0de07f2:	447f      	add	r7, pc
c0de07f4:	4479      	add	r1, pc
c0de07f6:	e003      	b.n	c0de0800 <handle_query_contract_ui+0xa4>
c0de07f8:	4f1f      	ldr	r7, [pc, #124]	; (c0de0878 <handle_query_contract_ui+0x11c>)
c0de07fa:	4920      	ldr	r1, [pc, #128]	; (c0de087c <handle_query_contract_ui+0x120>)
c0de07fc:	447f      	add	r7, pc
c0de07fe:	4479      	add	r1, pc
c0de0800:	2612      	movs	r6, #18
c0de0802:	e9d4 0209 	ldrd	r0, r2, [r4, #36]	; 0x24
c0de0806:	f000 fcac 	bl	c0de1162 <strlcpy>
    switch (context->selectorIndex) {
c0de080a:	f895 0054 	ldrb.w	r0, [r5, #84]	; 0x54
c0de080e:	1e41      	subs	r1, r0, #1
c0de0810:	2902      	cmp	r1, #2
c0de0812:	d30a      	bcc.n	c0de082a <handle_query_contract_ui+0xce>
c0de0814:	2803      	cmp	r0, #3
c0de0816:	d014      	beq.n	c0de0842 <handle_query_contract_ui+0xe6>
c0de0818:	b9f8      	cbnz	r0, c0de085a <handle_query_contract_ui+0xfe>
                   msg->pluginSharedRO->txContent->value.length,
c0de081a:	6860      	ldr	r0, [r4, #4]
                   msg->msg,
c0de081c:	6ae2      	ldr	r2, [r4, #44]	; 0x2c
                   msg->pluginSharedRO->txContent->value.length,
c0de081e:	6800      	ldr	r0, [r0, #0]
                   msg->msgLength);
c0de0820:	6b24      	ldr	r4, [r4, #48]	; 0x30
                   msg->pluginSharedRO->txContent->value.length,
c0de0822:	f890 1062 	ldrb.w	r1, [r0, #98]	; 0x62
            return amountToString(context->amount_sent,
c0de0826:	9200      	str	r2, [sp, #0]
c0de0828:	e003      	b.n	c0de0832 <handle_query_contract_ui+0xd6>
                   msg->msg,
c0de082a:	e9d4 040b 	ldrd	r0, r4, [r4, #44]	; 0x2c
            return amountToString(context->amount_sent,
c0de082e:	2120      	movs	r1, #32
c0de0830:	9000      	str	r0, [sp, #0]
c0de0832:	4628      	mov	r0, r5
c0de0834:	4632      	mov	r2, r6
c0de0836:	463b      	mov	r3, r7
c0de0838:	9401      	str	r4, [sp, #4]
c0de083a:	e00c      	b.n	c0de0856 <handle_query_contract_ui+0xfa>
            PRINTF("Unhandled selector Index: %d\n", context->selectorIndex);
c0de083c:	480d      	ldr	r0, [pc, #52]	; (c0de0874 <handle_query_contract_ui+0x118>)
c0de083e:	4478      	add	r0, pc
c0de0840:	e7b8      	b.n	c0de07b4 <handle_query_contract_ui+0x58>
                           msg->msg,
c0de0842:	e9d4 070b 	ldrd	r0, r7, [r4, #44]	; 0x2c
                           context->decimals_sent,
c0de0846:	f895 204f 	ldrb.w	r2, [r5, #79]	; 0x4f
                           context->ticker_sent,
c0de084a:	f105 0334 	add.w	r3, r5, #52	; 0x34
            amountToString(context->amount_sent,
c0de084e:	9000      	str	r0, [sp, #0]
c0de0850:	4628      	mov	r0, r5
c0de0852:	2120      	movs	r1, #32
c0de0854:	9701      	str	r7, [sp, #4]
c0de0856:	f7ff fdf3 	bl	c0de0440 <amountToString>
            msg->result = ETH_PLUGIN_RESULT_ERROR;
            return;
    }
}
c0de085a:	b003      	add	sp, #12
c0de085c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0de085e:	bf00      	nop
c0de0860:	00000ac2 	.word	0x00000ac2
c0de0864:	00000a76 	.word	0x00000a76
c0de0868:	00000a04 	.word	0x00000a04
c0de086c:	00000b04 	.word	0x00000b04
c0de0870:	00000bf6 	.word	0x00000bf6
c0de0874:	00000b21 	.word	0x00000b21
c0de0878:	00000a87 	.word	0x00000a87
c0de087c:	00000b3a 	.word	0x00000b3a
c0de0880:	00000a0a 	.word	0x00000a0a
c0de0884:	00000c04 	.word	0x00000c04

c0de0888 <dispatch_plugin_calls>:
void dispatch_plugin_calls(int message, void *parameters) {
c0de0888:	4602      	mov	r2, r0
    switch (message) {
c0de088a:	f5b0 7f82 	cmp.w	r0, #260	; 0x104
c0de088e:	da0d      	bge.n	c0de08ac <dispatch_plugin_calls+0x24>
c0de0890:	f240 1001 	movw	r0, #257	; 0x101
c0de0894:	4282      	cmp	r2, r0
c0de0896:	d014      	beq.n	c0de08c2 <dispatch_plugin_calls+0x3a>
c0de0898:	f5b2 7f81 	cmp.w	r2, #258	; 0x102
c0de089c:	d014      	beq.n	c0de08c8 <dispatch_plugin_calls+0x40>
c0de089e:	f240 1003 	movw	r0, #259	; 0x103
c0de08a2:	4282      	cmp	r2, r0
c0de08a4:	d119      	bne.n	c0de08da <dispatch_plugin_calls+0x52>
            handle_finalize(parameters);
c0de08a6:	4608      	mov	r0, r1
c0de08a8:	f7ff be1a 	b.w	c0de04e0 <handle_finalize>
    switch (message) {
c0de08ac:	d00f      	beq.n	c0de08ce <dispatch_plugin_calls+0x46>
c0de08ae:	f240 1005 	movw	r0, #261	; 0x105
c0de08b2:	4282      	cmp	r2, r0
c0de08b4:	d00e      	beq.n	c0de08d4 <dispatch_plugin_calls+0x4c>
c0de08b6:	f5b2 7f83 	cmp.w	r2, #262	; 0x106
c0de08ba:	d10e      	bne.n	c0de08da <dispatch_plugin_calls+0x52>
            handle_query_contract_ui(parameters);
c0de08bc:	4608      	mov	r0, r1
c0de08be:	f7ff bf4d 	b.w	c0de075c <handle_query_contract_ui>
            handle_init_contract(parameters);
c0de08c2:	4608      	mov	r0, r1
c0de08c4:	f7ff be2e 	b.w	c0de0524 <handle_init_contract>
            handle_provide_parameter(parameters);
c0de08c8:	4608      	mov	r0, r1
c0de08ca:	f7ff be87 	b.w	c0de05dc <handle_provide_parameter>
            handle_provide_token(parameters);
c0de08ce:	4608      	mov	r0, r1
c0de08d0:	f7ff befe 	b.w	c0de06d0 <handle_provide_token>
            handle_query_contract_id(parameters);
c0de08d4:	4608      	mov	r0, r1
c0de08d6:	f7ff bf09 	b.w	c0de06ec <handle_query_contract_id>
            PRINTF("Unhandled message %d\n", message);
c0de08da:	4802      	ldr	r0, [pc, #8]	; (c0de08e4 <dispatch_plugin_calls+0x5c>)
c0de08dc:	4611      	mov	r1, r2
c0de08de:	4478      	add	r0, pc
c0de08e0:	f000 b82a 	b.w	c0de0938 <mcu_usb_printf>
c0de08e4:	00000a3f 	.word	0x00000a3f

c0de08e8 <os_boot>:
#ifndef BOLOS_OS_UPGRADER_APP
void os_boot(void) {
  // // TODO patch entry point when romming (f)
  // // set the default try context to nothing
#ifndef HAVE_BOLOS
  try_context_set(NULL);
c0de08e8:	2000      	movs	r0, #0
c0de08ea:	f000 ba31 	b.w	c0de0d50 <try_context_set>
	...

c0de08f0 <os_longjmp>:
  }
  return xoracc;
}

#ifndef HAVE_BOLOS
void os_longjmp(unsigned int exception) {
c0de08f0:	4604      	mov	r4, r0
#ifdef HAVE_PRINTF  
  unsigned int lr_val;
  __asm volatile("mov %0, lr" :"=r"(lr_val));
c0de08f2:	4672      	mov	r2, lr
  PRINTF("exception[%d]: LR=0x%08X\n", exception, lr_val);
c0de08f4:	4804      	ldr	r0, [pc, #16]	; (c0de0908 <os_longjmp+0x18>)
c0de08f6:	4621      	mov	r1, r4
c0de08f8:	4478      	add	r0, pc
c0de08fa:	f000 f81d 	bl	c0de0938 <mcu_usb_printf>
#endif // HAVE_PRINTF
  longjmp(try_context_get()->jmp_buf, exception);
c0de08fe:	f000 fa1d 	bl	c0de0d3c <try_context_get>
c0de0902:	4621      	mov	r1, r4
c0de0904:	f000 fc02 	bl	c0de110c <longjmp>
c0de0908:	000009a9 	.word	0x000009a9

c0de090c <mcu_usb_prints>:
  return ret;
}
#endif // !defined(APP_UX)

#ifdef HAVE_PRINTF
void mcu_usb_prints(const char* str, unsigned int charcount) {
c0de090c:	b5b0      	push	{r4, r5, r7, lr}
c0de090e:	b082      	sub	sp, #8
c0de0910:	4605      	mov	r5, r0
c0de0912:	205f      	movs	r0, #95	; 0x5f
  unsigned char buf[4];
#ifdef TARGET_NANOS
  buf[0] = SEPROXYHAL_TAG_PRINTF_STATUS;
#else
  buf[0] = SEPROXYHAL_TAG_PRINTF;
c0de0914:	f88d 0004 	strb.w	r0, [sp, #4]
#endif
  buf[1] = charcount >> 8;
c0de0918:	0a08      	lsrs	r0, r1, #8
c0de091a:	460c      	mov	r4, r1
c0de091c:	f88d 0005 	strb.w	r0, [sp, #5]
  buf[2] = charcount;
c0de0920:	f88d 1006 	strb.w	r1, [sp, #6]
c0de0924:	a801      	add	r0, sp, #4
  io_seproxyhal_spi_send(buf, 3);
c0de0926:	2103      	movs	r1, #3
c0de0928:	f000 f9fc 	bl	c0de0d24 <io_seph_send>
  io_seproxyhal_spi_send((const uint8_t *) str, charcount);
c0de092c:	b2a1      	uxth	r1, r4
c0de092e:	4628      	mov	r0, r5
c0de0930:	f000 f9f8 	bl	c0de0d24 <io_seph_send>
}
c0de0934:	b002      	add	sp, #8
c0de0936:	bdb0      	pop	{r4, r5, r7, pc}

c0de0938 <mcu_usb_printf>:
#include "usbd_def.h"
#include "usbd_core.h"

void screen_printf(const char* format, ...) __attribute__ ((weak, alias ("mcu_usb_printf")));

void mcu_usb_printf(const char* format, ...) {
c0de0938:	b083      	sub	sp, #12
c0de093a:	e92d 4df0 	stmdb	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
c0de093e:	b089      	sub	sp, #36	; 0x24
    char cStrlenSet;

    //
    // Check the arguments.
    //
    if(format == 0) {
c0de0940:	2800      	cmp	r0, #0
c0de0942:	e9cd 1211 	strd	r1, r2, [sp, #68]	; 0x44
c0de0946:	9313      	str	r3, [sp, #76]	; 0x4c
c0de0948:	f000 8178 	beq.w	c0de0c3c <mcu_usb_printf+0x304>
c0de094c:	4604      	mov	r4, r0
    va_start(vaArgP, format);

    //
    // Loop while there are more characters in the string.
    //
    while(*format)
c0de094e:	7800      	ldrb	r0, [r0, #0]
c0de0950:	a911      	add	r1, sp, #68	; 0x44
c0de0952:	2800      	cmp	r0, #0
    va_start(vaArgP, format);
c0de0954:	9103      	str	r1, [sp, #12]
    while(*format)
c0de0956:	f000 8171 	beq.w	c0de0c3c <mcu_usb_printf+0x304>
c0de095a:	bf00      	nop
c0de095c:	2700      	movs	r7, #0
c0de095e:	bf00      	nop
    {
        //
        // Find the first non-% character, or the end of the string.
        //
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0de0960:	b130      	cbz	r0, c0de0970 <mcu_usb_printf+0x38>
c0de0962:	2825      	cmp	r0, #37	; 0x25
c0de0964:	d004      	beq.n	c0de0970 <mcu_usb_printf+0x38>
c0de0966:	19e0      	adds	r0, r4, r7
c0de0968:	7840      	ldrb	r0, [r0, #1]
            ulIdx++)
c0de096a:	3701      	adds	r7, #1
c0de096c:	e7f8      	b.n	c0de0960 <mcu_usb_printf+0x28>
c0de096e:	bf00      	nop
        }

        //
        // Write this portion of the string.
        //
        mcu_usb_prints(format, ulIdx);
c0de0970:	4620      	mov	r0, r4
c0de0972:	4639      	mov	r1, r7
c0de0974:	19e5      	adds	r5, r4, r7
c0de0976:	f7ff ffc9 	bl	c0de090c <mcu_usb_prints>
        format += ulIdx;

        //
        // See if the next character is a %.
        //
        if(*format == '%')
c0de097a:	5de0      	ldrb	r0, [r4, r7]
c0de097c:	2825      	cmp	r0, #37	; 0x25
c0de097e:	d14b      	bne.n	c0de0a18 <mcu_usb_printf+0xe0>
            ulCount = 0;
            cFill = ' ';
            ulStrlen = 0;
            cStrlenSet = 0;
            ulCap = 0;
            ulBase = 10;
c0de0980:	1c6c      	adds	r4, r5, #1
c0de0982:	f04f 0800 	mov.w	r8, #0
c0de0986:	2220      	movs	r2, #32
c0de0988:	f04f 0a00 	mov.w	sl, #0
c0de098c:	2000      	movs	r0, #0
again:

            //
            // Determine how to handle the next character.
            //
            switch(*format++)
c0de098e:	3401      	adds	r4, #1
c0de0990:	f814 1c01 	ldrb.w	r1, [r4, #-1]
c0de0994:	3401      	adds	r4, #1
c0de0996:	292d      	cmp	r1, #45	; 0x2d
c0de0998:	dc12      	bgt.n	c0de09c0 <mcu_usb_printf+0x88>
c0de099a:	f04f 0000 	mov.w	r0, #0
c0de099e:	d0f7      	beq.n	c0de0990 <mcu_usb_printf+0x58>
c0de09a0:	2925      	cmp	r1, #37	; 0x25
c0de09a2:	d076      	beq.n	c0de0a92 <mcu_usb_printf+0x15a>
c0de09a4:	292a      	cmp	r1, #42	; 0x2a
c0de09a6:	f040 80fa 	bne.w	c0de0b9e <mcu_usb_printf+0x266>
                  goto error;
                }

                case '*':
                {
                  if (*format == 's' ) {
c0de09aa:	4623      	mov	r3, r4
c0de09ac:	f813 0d01 	ldrb.w	r0, [r3, #-1]!
c0de09b0:	2873      	cmp	r0, #115	; 0x73
c0de09b2:	f040 80f4 	bne.w	c0de0b9e <mcu_usb_printf+0x266>

                    ulStrlen = va_arg(vaArgP, unsigned long);
c0de09b6:	9903      	ldr	r1, [sp, #12]
c0de09b8:	2002      	movs	r0, #2
c0de09ba:	461c      	mov	r4, r3
c0de09bc:	e026      	b.n	c0de0a0c <mcu_usb_printf+0xd4>
c0de09be:	bf00      	nop
            switch(*format++)
c0de09c0:	2947      	cmp	r1, #71	; 0x47
c0de09c2:	dc2b      	bgt.n	c0de0a1c <mcu_usb_printf+0xe4>
c0de09c4:	f1a1 0330 	sub.w	r3, r1, #48	; 0x30
c0de09c8:	2b0a      	cmp	r3, #10
c0de09ca:	d20d      	bcs.n	c0de09e8 <mcu_usb_printf+0xb0>
                    if((format[-1] == '0') && (ulCount == 0))
c0de09cc:	f081 0330 	eor.w	r3, r1, #48	; 0x30
c0de09d0:	ea53 0308 	orrs.w	r3, r3, r8
                    ulCount *= 10;
c0de09d4:	eb08 0388 	add.w	r3, r8, r8, lsl #2
                    ulCount += format[-1] - '0';
c0de09d8:	eb01 0143 	add.w	r1, r1, r3, lsl #1
                    if((format[-1] == '0') && (ulCount == 0))
c0de09dc:	bf08      	it	eq
c0de09de:	2230      	moveq	r2, #48	; 0x30
                    ulCount += format[-1] - '0';
c0de09e0:	f1a1 0830 	sub.w	r8, r1, #48	; 0x30
                    goto again;
c0de09e4:	3c01      	subs	r4, #1
c0de09e6:	e7d2      	b.n	c0de098e <mcu_usb_printf+0x56>
            switch(*format++)
c0de09e8:	292e      	cmp	r1, #46	; 0x2e
c0de09ea:	f040 80d8 	bne.w	c0de0b9e <mcu_usb_printf+0x266>
                  if (format[0] == '*' && (format[1] == 's' || format[1] == 'H' || format[1] == 'h')) {
c0de09ee:	f814 0c01 	ldrb.w	r0, [r4, #-1]
c0de09f2:	282a      	cmp	r0, #42	; 0x2a
c0de09f4:	f040 80d3 	bne.w	c0de0b9e <mcu_usb_printf+0x266>
c0de09f8:	7820      	ldrb	r0, [r4, #0]
c0de09fa:	2848      	cmp	r0, #72	; 0x48
c0de09fc:	d004      	beq.n	c0de0a08 <mcu_usb_printf+0xd0>
c0de09fe:	2873      	cmp	r0, #115	; 0x73
c0de0a00:	d002      	beq.n	c0de0a08 <mcu_usb_printf+0xd0>
c0de0a02:	2868      	cmp	r0, #104	; 0x68
c0de0a04:	f040 80cb 	bne.w	c0de0b9e <mcu_usb_printf+0x266>
                    ulStrlen = va_arg(vaArgP, unsigned long);
c0de0a08:	9903      	ldr	r1, [sp, #12]
c0de0a0a:	2001      	movs	r0, #1
c0de0a0c:	1d0b      	adds	r3, r1, #4
c0de0a0e:	9303      	str	r3, [sp, #12]
c0de0a10:	f8d1 a000 	ldr.w	sl, [r1]
c0de0a14:	e7bb      	b.n	c0de098e <mcu_usb_printf+0x56>
c0de0a16:	bf00      	nop
c0de0a18:	462c      	mov	r4, r5
c0de0a1a:	e0cf      	b.n	c0de0bbc <mcu_usb_printf+0x284>
            switch(*format++)
c0de0a1c:	2967      	cmp	r1, #103	; 0x67
c0de0a1e:	dd08      	ble.n	c0de0a32 <mcu_usb_printf+0xfa>
c0de0a20:	2972      	cmp	r1, #114	; 0x72
c0de0a22:	dd11      	ble.n	c0de0a48 <mcu_usb_printf+0x110>
c0de0a24:	2973      	cmp	r1, #115	; 0x73
c0de0a26:	d036      	beq.n	c0de0a96 <mcu_usb_printf+0x15e>
c0de0a28:	2975      	cmp	r1, #117	; 0x75
c0de0a2a:	d039      	beq.n	c0de0aa0 <mcu_usb_printf+0x168>
c0de0a2c:	2978      	cmp	r1, #120	; 0x78
c0de0a2e:	d011      	beq.n	c0de0a54 <mcu_usb_printf+0x11c>
c0de0a30:	e0b5      	b.n	c0de0b9e <mcu_usb_printf+0x266>
c0de0a32:	2962      	cmp	r1, #98	; 0x62
c0de0a34:	dc18      	bgt.n	c0de0a68 <mcu_usb_printf+0x130>
c0de0a36:	2948      	cmp	r1, #72	; 0x48
c0de0a38:	f000 809e 	beq.w	c0de0b78 <mcu_usb_printf+0x240>
c0de0a3c:	2958      	cmp	r1, #88	; 0x58
c0de0a3e:	f040 80ae 	bne.w	c0de0b9e <mcu_usb_printf+0x266>
c0de0a42:	f04f 0c01 	mov.w	ip, #1
c0de0a46:	e007      	b.n	c0de0a58 <mcu_usb_printf+0x120>
c0de0a48:	2968      	cmp	r1, #104	; 0x68
c0de0a4a:	f000 8098 	beq.w	c0de0b7e <mcu_usb_printf+0x246>
c0de0a4e:	2970      	cmp	r1, #112	; 0x70
c0de0a50:	f040 80a5 	bne.w	c0de0b9e <mcu_usb_printf+0x266>
c0de0a54:	f04f 0c00 	mov.w	ip, #0
                case 'p':
                {
                    //
                    // Get the value from the varargs.
                    //
                    ulValue = va_arg(vaArgP, unsigned long);
c0de0a58:	9803      	ldr	r0, [sp, #12]
c0de0a5a:	2710      	movs	r7, #16
c0de0a5c:	1d01      	adds	r1, r0, #4
c0de0a5e:	9103      	str	r1, [sp, #12]
c0de0a60:	6806      	ldr	r6, [r0, #0]
c0de0a62:	2001      	movs	r0, #1
c0de0a64:	9608      	str	r6, [sp, #32]
c0de0a66:	e024      	b.n	c0de0ab2 <mcu_usb_printf+0x17a>
            switch(*format++)
c0de0a68:	2963      	cmp	r1, #99	; 0x63
c0de0a6a:	f000 809c 	beq.w	c0de0ba6 <mcu_usb_printf+0x26e>
c0de0a6e:	2964      	cmp	r1, #100	; 0x64
c0de0a70:	f040 8095 	bne.w	c0de0b9e <mcu_usb_printf+0x266>
                    ulValue = va_arg(vaArgP, unsigned long);
c0de0a74:	9803      	ldr	r0, [sp, #12]
c0de0a76:	1d01      	adds	r1, r0, #4
c0de0a78:	9103      	str	r1, [sp, #12]
c0de0a7a:	6806      	ldr	r6, [r0, #0]
                    if((long)ulValue < 0)
c0de0a7c:	f1b6 3fff 	cmp.w	r6, #4294967295	; 0xffffffff
                    ulValue = va_arg(vaArgP, unsigned long);
c0de0a80:	9608      	str	r6, [sp, #32]
c0de0a82:	dc12      	bgt.n	c0de0aaa <mcu_usb_printf+0x172>
                        ulValue = -(long)ulValue;
c0de0a84:	4276      	negs	r6, r6
c0de0a86:	9608      	str	r6, [sp, #32]
c0de0a88:	2000      	movs	r0, #0
c0de0a8a:	270a      	movs	r7, #10
            ulCap = 0;
c0de0a8c:	f04f 0c00 	mov.w	ip, #0
c0de0a90:	e00f      	b.n	c0de0ab2 <mcu_usb_printf+0x17a>
                case '%':
                {
                    //
                    // Simply write a single %.
                    //
                    mcu_usb_prints(format - 1, 1);
c0de0a92:	1ea0      	subs	r0, r4, #2
c0de0a94:	e08d      	b.n	c0de0bb2 <mcu_usb_printf+0x27a>
c0de0a96:	496d      	ldr	r1, [pc, #436]	; (c0de0c4c <mcu_usb_printf+0x314>)
c0de0a98:	4479      	add	r1, pc
c0de0a9a:	468c      	mov	ip, r1
c0de0a9c:	2100      	movs	r1, #0
c0de0a9e:	e072      	b.n	c0de0b86 <mcu_usb_printf+0x24e>
                    ulValue = va_arg(vaArgP, unsigned long);
c0de0aa0:	9803      	ldr	r0, [sp, #12]
c0de0aa2:	1d01      	adds	r1, r0, #4
c0de0aa4:	9103      	str	r1, [sp, #12]
c0de0aa6:	6806      	ldr	r6, [r0, #0]
c0de0aa8:	9608      	str	r6, [sp, #32]
c0de0aaa:	f04f 0c00 	mov.w	ip, #0
c0de0aae:	2001      	movs	r0, #1
c0de0ab0:	270a      	movs	r7, #10
                        (((ulIdx * ulBase) <= ulValue) &&
c0de0ab2:	42b7      	cmp	r7, r6
c0de0ab4:	d902      	bls.n	c0de0abc <mcu_usb_printf+0x184>
c0de0ab6:	f04f 0b01 	mov.w	fp, #1
c0de0aba:	e010      	b.n	c0de0ade <mcu_usb_printf+0x1a6>
                    for(ulIdx = 1;
c0de0abc:	f1a8 0301 	sub.w	r3, r8, #1
c0de0ac0:	4639      	mov	r1, r7
c0de0ac2:	bf00      	nop
c0de0ac4:	468b      	mov	fp, r1
                        (((ulIdx * ulBase) <= ulValue) &&
c0de0ac6:	fba7 1501 	umull	r1, r5, r7, r1
c0de0aca:	2d00      	cmp	r5, #0
c0de0acc:	bf18      	it	ne
c0de0ace:	2501      	movne	r5, #1
c0de0ad0:	42b1      	cmp	r1, r6
c0de0ad2:	4698      	mov	r8, r3
c0de0ad4:	d803      	bhi.n	c0de0ade <mcu_usb_printf+0x1a6>
                    for(ulIdx = 1;
c0de0ad6:	2d00      	cmp	r5, #0
c0de0ad8:	f1a8 0301 	sub.w	r3, r8, #1
c0de0adc:	d0f2      	beq.n	c0de0ac4 <mcu_usb_printf+0x18c>
                    if(ulNeg && (cFill == '0'))
c0de0ade:	b118      	cbz	r0, c0de0ae8 <mcu_usb_printf+0x1b0>
c0de0ae0:	2500      	movs	r5, #0
c0de0ae2:	f04f 0a01 	mov.w	sl, #1
c0de0ae6:	e00c      	b.n	c0de0b02 <mcu_usb_printf+0x1ca>
c0de0ae8:	b2d1      	uxtb	r1, r2
c0de0aea:	2930      	cmp	r1, #48	; 0x30
c0de0aec:	d106      	bne.n	c0de0afc <mcu_usb_printf+0x1c4>
                        pcBuf[ulPos++] = '-';
c0de0aee:	212d      	movs	r1, #45	; 0x2d
c0de0af0:	f04f 0a01 	mov.w	sl, #1
c0de0af4:	2501      	movs	r5, #1
c0de0af6:	f88d 1010 	strb.w	r1, [sp, #16]
c0de0afa:	e002      	b.n	c0de0b02 <mcu_usb_printf+0x1ca>
c0de0afc:	f04f 0a00 	mov.w	sl, #0
c0de0b00:	2500      	movs	r5, #0
c0de0b02:	f080 0001 	eor.w	r0, r0, #1
c0de0b06:	eba8 0100 	sub.w	r1, r8, r0
                    if((ulCount > 1) && (ulCount < 16))
c0de0b0a:	1e8b      	subs	r3, r1, #2
c0de0b0c:	2b0d      	cmp	r3, #13
c0de0b0e:	d811      	bhi.n	c0de0b34 <mcu_usb_printf+0x1fc>
c0de0b10:	3901      	subs	r1, #1
c0de0b12:	d00f      	beq.n	c0de0b34 <mcu_usb_printf+0x1fc>
c0de0b14:	4240      	negs	r0, r0
                        for(ulCount--; ulCount; ulCount--)
c0de0b16:	9001      	str	r0, [sp, #4]
c0de0b18:	a804      	add	r0, sp, #16
c0de0b1a:	4428      	add	r0, r5
                            pcBuf[ulPos++] = cFill;
c0de0b1c:	b2d2      	uxtb	r2, r2
c0de0b1e:	f8cd c008 	str.w	ip, [sp, #8]
c0de0b22:	f000 fab8 	bl	c0de1096 <__aeabi_memset>
                        for(ulCount--; ulCount; ulCount--)
c0de0b26:	9901      	ldr	r1, [sp, #4]
c0de0b28:	eb05 0008 	add.w	r0, r5, r8
c0de0b2c:	f8dd c008 	ldr.w	ip, [sp, #8]
c0de0b30:	4408      	add	r0, r1
c0de0b32:	1e45      	subs	r5, r0, #1
                    if(ulNeg)
c0de0b34:	f1ba 0f00 	cmp.w	sl, #0
c0de0b38:	a804      	add	r0, sp, #16
                        pcBuf[ulPos++] = '-';
c0de0b3a:	bf02      	ittt	eq
c0de0b3c:	212d      	moveq	r1, #45	; 0x2d
c0de0b3e:	5541      	strbeq	r1, [r0, r5]
c0de0b40:	3501      	addeq	r5, #1
                    for(; ulIdx; ulIdx /= ulBase)
c0de0b42:	f1bb 0f00 	cmp.w	fp, #0
c0de0b46:	d015      	beq.n	c0de0b74 <mcu_usb_printf+0x23c>
c0de0b48:	4945      	ldr	r1, [pc, #276]	; (c0de0c60 <mcu_usb_printf+0x328>)
c0de0b4a:	4b46      	ldr	r3, [pc, #280]	; (c0de0c64 <mcu_usb_printf+0x32c>)
c0de0b4c:	4479      	add	r1, pc
c0de0b4e:	447b      	add	r3, pc
c0de0b50:	f1bc 0f00 	cmp.w	ip, #0
c0de0b54:	bf08      	it	eq
c0de0b56:	460b      	moveq	r3, r1
c0de0b58:	fbb6 f1fb 	udiv	r1, r6, fp
c0de0b5c:	455f      	cmp	r7, fp
c0de0b5e:	fbb1 f2f7 	udiv	r2, r1, r7
c0de0b62:	fbbb fbf7 	udiv	fp, fp, r7
c0de0b66:	fb02 1117 	mls	r1, r2, r7, r1
c0de0b6a:	5c59      	ldrb	r1, [r3, r1]
                          pcBuf[ulPos++] = g_pcHex[(ulValue / ulIdx) % ulBase];
c0de0b6c:	5541      	strb	r1, [r0, r5]
c0de0b6e:	f105 0501 	add.w	r5, r5, #1
                    for(; ulIdx; ulIdx /= ulBase)
c0de0b72:	d9f1      	bls.n	c0de0b58 <mcu_usb_printf+0x220>
                    mcu_usb_prints(pcBuf, ulPos);
c0de0b74:	4629      	mov	r1, r5
c0de0b76:	e01d      	b.n	c0de0bb4 <mcu_usb_printf+0x27c>
c0de0b78:	4935      	ldr	r1, [pc, #212]	; (c0de0c50 <mcu_usb_printf+0x318>)
c0de0b7a:	4479      	add	r1, pc
c0de0b7c:	e001      	b.n	c0de0b82 <mcu_usb_printf+0x24a>
c0de0b7e:	4935      	ldr	r1, [pc, #212]	; (c0de0c54 <mcu_usb_printf+0x31c>)
c0de0b80:	4479      	add	r1, pc
c0de0b82:	468c      	mov	ip, r1
c0de0b84:	2101      	movs	r1, #1
                    pcStr = va_arg(vaArgP, char *);
c0de0b86:	9a03      	ldr	r2, [sp, #12]
                    switch(cStrlenSet) {
c0de0b88:	b2c0      	uxtb	r0, r0
                    pcStr = va_arg(vaArgP, char *);
c0de0b8a:	1d13      	adds	r3, r2, #4
c0de0b8c:	9303      	str	r3, [sp, #12]
c0de0b8e:	6816      	ldr	r6, [r2, #0]
                    switch(cStrlenSet) {
c0de0b90:	b1c0      	cbz	r0, c0de0bc4 <mcu_usb_printf+0x28c>
c0de0b92:	2801      	cmp	r0, #1
c0de0b94:	d020      	beq.n	c0de0bd8 <mcu_usb_printf+0x2a0>
c0de0b96:	2802      	cmp	r0, #2
c0de0b98:	d11d      	bne.n	c0de0bd6 <mcu_usb_printf+0x29e>
                        if (pcStr[0] == '\0') {
c0de0b9a:	7830      	ldrb	r0, [r6, #0]
c0de0b9c:	b3c0      	cbz	r0, c0de0c10 <mcu_usb_printf+0x2d8>
                default:
                {
                    //
                    // Indicate an error.
                    //
                    mcu_usb_prints("ERROR", 5);
c0de0b9e:	482a      	ldr	r0, [pc, #168]	; (c0de0c48 <mcu_usb_printf+0x310>)
c0de0ba0:	2105      	movs	r1, #5
c0de0ba2:	4478      	add	r0, pc
c0de0ba4:	e006      	b.n	c0de0bb4 <mcu_usb_printf+0x27c>
                    ulValue = va_arg(vaArgP, unsigned long);
c0de0ba6:	9803      	ldr	r0, [sp, #12]
c0de0ba8:	1d01      	adds	r1, r0, #4
c0de0baa:	9103      	str	r1, [sp, #12]
c0de0bac:	6800      	ldr	r0, [r0, #0]
c0de0bae:	9008      	str	r0, [sp, #32]
                    mcu_usb_prints((char *)&ulValue, 1);
c0de0bb0:	a808      	add	r0, sp, #32
c0de0bb2:	2101      	movs	r1, #1
c0de0bb4:	f7ff feaa 	bl	c0de090c <mcu_usb_prints>
    while(*format)
c0de0bb8:	f814 0d01 	ldrb.w	r0, [r4, #-1]!
c0de0bbc:	2800      	cmp	r0, #0
c0de0bbe:	f47f aecd 	bne.w	c0de095c <mcu_usb_printf+0x24>
c0de0bc2:	e03b      	b.n	c0de0c3c <mcu_usb_printf+0x304>
c0de0bc4:	2000      	movs	r0, #0
c0de0bc6:	bf00      	nop
                        for(ulIdx = 0; pcStr[ulIdx] != '\0'; ulIdx++)
c0de0bc8:	5c32      	ldrb	r2, [r6, r0]
c0de0bca:	3001      	adds	r0, #1
c0de0bcc:	2a00      	cmp	r2, #0
c0de0bce:	d1fb      	bne.n	c0de0bc8 <mcu_usb_printf+0x290>
                    switch(ulBase) {
c0de0bd0:	f1a0 0a01 	sub.w	sl, r0, #1
c0de0bd4:	e000      	b.n	c0de0bd8 <mcu_usb_printf+0x2a0>
c0de0bd6:	46ba      	mov	sl, r7
c0de0bd8:	b1a9      	cbz	r1, c0de0c06 <mcu_usb_printf+0x2ce>
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0de0bda:	f1ba 0f00 	cmp.w	sl, #0
c0de0bde:	4665      	mov	r5, ip
c0de0be0:	d0ea      	beq.n	c0de0bb8 <mcu_usb_printf+0x280>
c0de0be2:	bf00      	nop
                          nibble1 = (pcStr[ulCount]>>4)&0xF;
c0de0be4:	f816 0b01 	ldrb.w	r0, [r6], #1
c0de0be8:	2101      	movs	r1, #1
                          nibble2 = pcStr[ulCount]&0xF;
c0de0bea:	f000 070f 	and.w	r7, r0, #15
c0de0bee:	eb05 1010 	add.w	r0, r5, r0, lsr #4
c0de0bf2:	f7ff fe8b 	bl	c0de090c <mcu_usb_prints>
c0de0bf6:	19e8      	adds	r0, r5, r7
c0de0bf8:	2101      	movs	r1, #1
c0de0bfa:	f7ff fe87 	bl	c0de090c <mcu_usb_prints>
                        for (ulCount = 0; ulCount < ulIdx; ulCount++) {
c0de0bfe:	f1ba 0a01 	subs.w	sl, sl, #1
c0de0c02:	d1ef      	bne.n	c0de0be4 <mcu_usb_printf+0x2ac>
c0de0c04:	e7d8      	b.n	c0de0bb8 <mcu_usb_printf+0x280>
                        mcu_usb_prints(pcStr, ulIdx);
c0de0c06:	4630      	mov	r0, r6
c0de0c08:	4651      	mov	r1, sl
c0de0c0a:	f7ff fe7f 	bl	c0de090c <mcu_usb_prints>
c0de0c0e:	e009      	b.n	c0de0c24 <mcu_usb_printf+0x2ec>
                          do {
c0de0c10:	f10a 0501 	add.w	r5, sl, #1
                            mcu_usb_prints(" ", 1);
c0de0c14:	4810      	ldr	r0, [pc, #64]	; (c0de0c58 <mcu_usb_printf+0x320>)
c0de0c16:	2101      	movs	r1, #1
c0de0c18:	4478      	add	r0, pc
c0de0c1a:	f7ff fe77 	bl	c0de090c <mcu_usb_prints>
                          } while(ulStrlen-- > 0);
c0de0c1e:	3d01      	subs	r5, #1
c0de0c20:	d1f8      	bne.n	c0de0c14 <mcu_usb_printf+0x2dc>
        for(ulIdx = 0; (format[ulIdx] != '%') && (format[ulIdx] != '\0');
c0de0c22:	46ba      	mov	sl, r7
                    if(ulCount > ulIdx)
c0de0c24:	45d0      	cmp	r8, sl
c0de0c26:	d9c7      	bls.n	c0de0bb8 <mcu_usb_printf+0x280>
                        while(ulCount--)
c0de0c28:	ebaa 0508 	sub.w	r5, sl, r8
                            mcu_usb_prints(" ", 1);
c0de0c2c:	480b      	ldr	r0, [pc, #44]	; (c0de0c5c <mcu_usb_printf+0x324>)
c0de0c2e:	2101      	movs	r1, #1
c0de0c30:	4478      	add	r0, pc
c0de0c32:	f7ff fe6b 	bl	c0de090c <mcu_usb_prints>
                        while(ulCount--)
c0de0c36:	3501      	adds	r5, #1
c0de0c38:	d3f8      	bcc.n	c0de0c2c <mcu_usb_printf+0x2f4>
c0de0c3a:	e7bd      	b.n	c0de0bb8 <mcu_usb_printf+0x280>

    //
    // End the varargs processing.
    //
    va_end(vaArgP);
}
c0de0c3c:	b009      	add	sp, #36	; 0x24
c0de0c3e:	e8bd 4df0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, sl, fp, lr}
c0de0c42:	b003      	add	sp, #12
c0de0c44:	4770      	bx	lr
c0de0c46:	bf00      	nop
c0de0c48:	00000719 	.word	0x00000719
c0de0c4c:	00000942 	.word	0x00000942
c0de0c50:	00000870 	.word	0x00000870
c0de0c54:	0000085a 	.word	0x0000085a
c0de0c58:	000005be 	.word	0x000005be
c0de0c5c:	000005a6 	.word	0x000005a6
c0de0c60:	0000088e 	.word	0x0000088e
c0de0c64:	0000089c 	.word	0x0000089c

c0de0c68 <pic_internal>:
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"
__attribute__((naked,no_instrument_function)) void *pic_internal(void *link_address)
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");
c0de0c68:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");
c0de0c6a:	4902      	ldr	r1, [pc, #8]	; (c0de0c74 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");
c0de0c6c:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");
c0de0c6e:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");
c0de0c70:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0de0c72:	4770      	bx	lr
c0de0c74:	c0de0c69 	.word	0xc0de0c69

c0de0c78 <pic>:

void *pic(void *link_address) {
  void *n, *en;

  // check if in the LINKED TEXT zone
  __asm volatile("ldr %0, =_nvram":"=r"(n));
c0de0c78:	490a      	ldr	r1, [pc, #40]	; (c0de0ca4 <pic+0x2c>)
  __asm volatile("ldr %0, =_envram":"=r"(en));
  if (link_address >= n && link_address <= en) {
c0de0c7a:	4281      	cmp	r1, r0
  __asm volatile("ldr %0, =_envram":"=r"(en));
c0de0c7c:	490a      	ldr	r1, [pc, #40]	; (c0de0ca8 <pic+0x30>)
  if (link_address >= n && link_address <= en) {
c0de0c7e:	d806      	bhi.n	c0de0c8e <pic+0x16>
c0de0c80:	4281      	cmp	r1, r0
c0de0c82:	d304      	bcc.n	c0de0c8e <pic+0x16>
c0de0c84:	b580      	push	{r7, lr}
    link_address = pic_internal(link_address);
c0de0c86:	f7ff ffef 	bl	c0de0c68 <pic_internal>
c0de0c8a:	e8bd 4080 	ldmia.w	sp!, {r7, lr}
  }

  // check if in the LINKED RAM zone
  __asm volatile("ldr %0, =_bss":"=r"(n));
c0de0c8e:	4907      	ldr	r1, [pc, #28]	; (c0de0cac <pic+0x34>)
  __asm volatile("ldr %0, =_estack":"=r"(en));
  if (link_address >= n && link_address <= en) {
c0de0c90:	4288      	cmp	r0, r1
  __asm volatile("ldr %0, =_estack":"=r"(en));
c0de0c92:	4a07      	ldr	r2, [pc, #28]	; (c0de0cb0 <pic+0x38>)
  if (link_address >= n && link_address <= en) {
c0de0c94:	d305      	bcc.n	c0de0ca2 <pic+0x2a>
c0de0c96:	4290      	cmp	r0, r2
    __asm volatile("mov %0, r9":"=r"(en));
    // deref into the RAM therefore add the RAM offset from R9
    link_address = (char *)link_address - (char *)n + (char *)en;
  }

  return link_address;
c0de0c98:	bf88      	it	hi
c0de0c9a:	4770      	bxhi	lr
    link_address = (char *)link_address - (char *)n + (char *)en;
c0de0c9c:	1a40      	subs	r0, r0, r1
    __asm volatile("mov %0, r9":"=r"(en));
c0de0c9e:	464a      	mov	r2, r9
    link_address = (char *)link_address - (char *)n + (char *)en;
c0de0ca0:	4410      	add	r0, r2
  return link_address;
c0de0ca2:	4770      	bx	lr
c0de0ca4:	c0de0000 	.word	0xc0de0000
c0de0ca8:	c0de1400 	.word	0xc0de1400
c0de0cac:	da7a0000 	.word	0xda7a0000
c0de0cb0:	da7a7800 	.word	0xda7a7800

c0de0cb4 <SVC_Call>:
.thumb
.thumb_func
.global SVC_Call

SVC_Call:
    svc 1
c0de0cb4:	df01      	svc	1
    cmp r1, #0
c0de0cb6:	2900      	cmp	r1, #0
    bne exception
c0de0cb8:	d100      	bne.n	c0de0cbc <exception>
    bx lr
c0de0cba:	4770      	bx	lr

c0de0cbc <exception>:
exception:
    // THROW(ex);
    mov r0, r1
c0de0cbc:	4608      	mov	r0, r1
    bl os_longjmp
c0de0cbe:	f7ff fe17 	bl	c0de08f0 <os_longjmp>

c0de0cc2 <get_api_level>:
#include <string.h>

unsigned int SVC_Call(unsigned int syscall_id, void *parameters);
unsigned int SVC_cx_call(unsigned int syscall_id, unsigned int * parameters);

unsigned int get_api_level(void) {
c0de0cc2:	b580      	push	{r7, lr}
c0de0cc4:	b082      	sub	sp, #8
c0de0cc6:	2000      	movs	r0, #0
  unsigned int parameters[2];
  parameters[0] = 0;
c0de0cc8:	e9cd 0000 	strd	r0, r0, [sp]
c0de0ccc:	4669      	mov	r1, sp
  parameters[1] = 0;
  return SVC_Call(SYSCALL_get_api_level_ID, parameters);
c0de0cce:	2001      	movs	r0, #1
c0de0cd0:	f7ff fff0 	bl	c0de0cb4 <SVC_Call>
c0de0cd4:	b002      	add	sp, #8
c0de0cd6:	bd80      	pop	{r7, pc}

c0de0cd8 <os_lib_call>:
  SVC_Call(SYSCALL_os_ux_result_ID, parameters);
  return;
}
#endif // !defined(APP_UX)

void os_lib_call ( unsigned int * call_parameters ) {
c0de0cd8:	b580      	push	{r7, lr}
c0de0cda:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)call_parameters;
c0de0cdc:	9000      	str	r0, [sp, #0]
c0de0cde:	2000      	movs	r0, #0
  parameters[1] = 0;
c0de0ce0:	9001      	str	r0, [sp, #4]
c0de0ce2:	4803      	ldr	r0, [pc, #12]	; (c0de0cf0 <os_lib_call+0x18>)
c0de0ce4:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_lib_call_ID, parameters);
c0de0ce6:	f7ff ffe5 	bl	c0de0cb4 <SVC_Call>
  return;
}
c0de0cea:	b002      	add	sp, #8
c0de0cec:	bd80      	pop	{r7, pc}
c0de0cee:	bf00      	nop
c0de0cf0:	01000067 	.word	0x01000067

c0de0cf4 <os_lib_end>:

void os_lib_end ( void ) {
c0de0cf4:	b580      	push	{r7, lr}
c0de0cf6:	b082      	sub	sp, #8
c0de0cf8:	2000      	movs	r0, #0
  unsigned int parameters[2];
  parameters[1] = 0;
c0de0cfa:	9001      	str	r0, [sp, #4]
c0de0cfc:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_lib_end_ID, parameters);
c0de0cfe:	2068      	movs	r0, #104	; 0x68
c0de0d00:	f7ff ffd8 	bl	c0de0cb4 <SVC_Call>
  return;
}
c0de0d04:	b002      	add	sp, #8
c0de0d06:	bd80      	pop	{r7, pc}

c0de0d08 <os_sched_exit>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_exec_ID, parameters);
  return;
}

void __attribute__((noreturn)) os_sched_exit ( bolos_task_status_t exit_code ) {
c0de0d08:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)exit_code;
c0de0d0a:	9000      	str	r0, [sp, #0]
c0de0d0c:	2000      	movs	r0, #0
  parameters[1] = 0;
c0de0d0e:	9001      	str	r0, [sp, #4]
c0de0d10:	4803      	ldr	r0, [pc, #12]	; (c0de0d20 <os_sched_exit+0x18>)
c0de0d12:	4669      	mov	r1, sp
  SVC_Call(SYSCALL_os_sched_exit_ID, parameters);
c0de0d14:	f7ff ffce 	bl	c0de0cb4 <SVC_Call>

  // The os_sched_exit syscall should never return. Just in case, prevent the
  // device from freezing (because of the following infinite loop) thanks to an
  // undefined instruction.
  asm volatile ("udf #255");
c0de0d18:	deff      	udf	#255	; 0xff
c0de0d1a:	bf00      	nop

  // remove the warning caused by -Winvalid-noreturn
  while (1) {
c0de0d1c:	e7fe      	b.n	c0de0d1c <os_sched_exit+0x14>
c0de0d1e:	bf00      	nop
c0de0d20:	0100009a 	.word	0x0100009a

c0de0d24 <io_seph_send>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_os_sched_kill_ID, parameters);
  return;
}

void io_seph_send ( const unsigned char * buffer, unsigned short length ) {
c0de0d24:	b580      	push	{r7, lr}
c0de0d26:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)buffer;
c0de0d28:	e9cd 0100 	strd	r0, r1, [sp]
c0de0d2c:	4802      	ldr	r0, [pc, #8]	; (c0de0d38 <io_seph_send+0x14>)
c0de0d2e:	4669      	mov	r1, sp
  parameters[1] = (unsigned int)length;
  SVC_Call(SYSCALL_io_seph_send_ID, parameters);
c0de0d30:	f7ff ffc0 	bl	c0de0cb4 <SVC_Call>
  return;
}
c0de0d34:	b002      	add	sp, #8
c0de0d36:	bd80      	pop	{r7, pc}
c0de0d38:	02000083 	.word	0x02000083

c0de0d3c <try_context_get>:
  parameters[1] = 0;
  SVC_Call(SYSCALL_nvm_erase_page_ID, parameters);
  return;
}

try_context_t * try_context_get ( void ) {
c0de0d3c:	b580      	push	{r7, lr}
c0de0d3e:	b082      	sub	sp, #8
c0de0d40:	2000      	movs	r0, #0
  unsigned int parameters[2];
  parameters[1] = 0;
c0de0d42:	9001      	str	r0, [sp, #4]
c0de0d44:	4669      	mov	r1, sp
  return (try_context_t *) SVC_Call(SYSCALL_try_context_get_ID, parameters);
c0de0d46:	2087      	movs	r0, #135	; 0x87
c0de0d48:	f7ff ffb4 	bl	c0de0cb4 <SVC_Call>
c0de0d4c:	b002      	add	sp, #8
c0de0d4e:	bd80      	pop	{r7, pc}

c0de0d50 <try_context_set>:
}

try_context_t * try_context_set ( try_context_t *context ) {
c0de0d50:	b580      	push	{r7, lr}
c0de0d52:	b082      	sub	sp, #8
  unsigned int parameters[2];
  parameters[0] = (unsigned int)context;
c0de0d54:	9000      	str	r0, [sp, #0]
c0de0d56:	2000      	movs	r0, #0
  parameters[1] = 0;
c0de0d58:	9001      	str	r0, [sp, #4]
c0de0d5a:	4803      	ldr	r0, [pc, #12]	; (c0de0d68 <try_context_set+0x18>)
c0de0d5c:	4669      	mov	r1, sp
  return (try_context_t *) SVC_Call(SYSCALL_try_context_set_ID, parameters);
c0de0d5e:	f7ff ffa9 	bl	c0de0cb4 <SVC_Call>
c0de0d62:	b002      	add	sp, #8
c0de0d64:	bd80      	pop	{r7, pc}
c0de0d66:	bf00      	nop
c0de0d68:	0100010b 	.word	0x0100010b

c0de0d6c <__aeabi_uldivmod>:
c0de0d6c:	b953      	cbnz	r3, c0de0d84 <__aeabi_uldivmod+0x18>
c0de0d6e:	b94a      	cbnz	r2, c0de0d84 <__aeabi_uldivmod+0x18>
c0de0d70:	2900      	cmp	r1, #0
c0de0d72:	bf08      	it	eq
c0de0d74:	2800      	cmpeq	r0, #0
c0de0d76:	bf1c      	itt	ne
c0de0d78:	f04f 31ff 	movne.w	r1, #4294967295	; 0xffffffff
c0de0d7c:	f04f 30ff 	movne.w	r0, #4294967295	; 0xffffffff
c0de0d80:	f000 b80c 	b.w	c0de0d9c <__aeabi_idiv0>
c0de0d84:	f1ad 0c08 	sub.w	ip, sp, #8
c0de0d88:	e96d ce04 	strd	ip, lr, [sp, #-16]!
c0de0d8c:	f000 f808 	bl	c0de0da0 <__udivmoddi4>
c0de0d90:	f8dd e004 	ldr.w	lr, [sp, #4]
c0de0d94:	e9dd 2302 	ldrd	r2, r3, [sp, #8]
c0de0d98:	b004      	add	sp, #16
c0de0d9a:	4770      	bx	lr

c0de0d9c <__aeabi_idiv0>:
c0de0d9c:	4770      	bx	lr
c0de0d9e:	bf00      	nop

c0de0da0 <__udivmoddi4>:
c0de0da0:	e92d 4ff0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
c0de0da4:	9e09      	ldr	r6, [sp, #36]	; 0x24
c0de0da6:	460d      	mov	r5, r1
c0de0da8:	4604      	mov	r4, r0
c0de0daa:	460f      	mov	r7, r1
c0de0dac:	2b00      	cmp	r3, #0
c0de0dae:	d147      	bne.n	c0de0e40 <__udivmoddi4+0xa0>
c0de0db0:	428a      	cmp	r2, r1
c0de0db2:	4694      	mov	ip, r2
c0de0db4:	d95f      	bls.n	c0de0e76 <__udivmoddi4+0xd6>
c0de0db6:	fab2 f382 	clz	r3, r2
c0de0dba:	b143      	cbz	r3, c0de0dce <__udivmoddi4+0x2e>
c0de0dbc:	f1c3 0120 	rsb	r1, r3, #32
c0de0dc0:	409f      	lsls	r7, r3
c0de0dc2:	fa02 fc03 	lsl.w	ip, r2, r3
c0de0dc6:	409c      	lsls	r4, r3
c0de0dc8:	fa20 f101 	lsr.w	r1, r0, r1
c0de0dcc:	430f      	orrs	r7, r1
c0de0dce:	ea4f 451c 	mov.w	r5, ip, lsr #16
c0de0dd2:	fa1f fe8c 	uxth.w	lr, ip
c0de0dd6:	0c22      	lsrs	r2, r4, #16
c0de0dd8:	fbb7 f1f5 	udiv	r1, r7, r5
c0de0ddc:	fb05 7711 	mls	r7, r5, r1, r7
c0de0de0:	fb01 f00e 	mul.w	r0, r1, lr
c0de0de4:	ea42 4207 	orr.w	r2, r2, r7, lsl #16
c0de0de8:	4290      	cmp	r0, r2
c0de0dea:	d908      	bls.n	c0de0dfe <__udivmoddi4+0x5e>
c0de0dec:	eb1c 0202 	adds.w	r2, ip, r2
c0de0df0:	f101 37ff 	add.w	r7, r1, #4294967295	; 0xffffffff
c0de0df4:	d202      	bcs.n	c0de0dfc <__udivmoddi4+0x5c>
c0de0df6:	4290      	cmp	r0, r2
c0de0df8:	f200 8134 	bhi.w	c0de1064 <__udivmoddi4+0x2c4>
c0de0dfc:	4639      	mov	r1, r7
c0de0dfe:	1a12      	subs	r2, r2, r0
c0de0e00:	b2a4      	uxth	r4, r4
c0de0e02:	fbb2 f0f5 	udiv	r0, r2, r5
c0de0e06:	fb05 2210 	mls	r2, r5, r0, r2
c0de0e0a:	fb00 fe0e 	mul.w	lr, r0, lr
c0de0e0e:	ea44 4402 	orr.w	r4, r4, r2, lsl #16
c0de0e12:	45a6      	cmp	lr, r4
c0de0e14:	d908      	bls.n	c0de0e28 <__udivmoddi4+0x88>
c0de0e16:	eb1c 0404 	adds.w	r4, ip, r4
c0de0e1a:	f100 32ff 	add.w	r2, r0, #4294967295	; 0xffffffff
c0de0e1e:	d202      	bcs.n	c0de0e26 <__udivmoddi4+0x86>
c0de0e20:	45a6      	cmp	lr, r4
c0de0e22:	f200 8119 	bhi.w	c0de1058 <__udivmoddi4+0x2b8>
c0de0e26:	4610      	mov	r0, r2
c0de0e28:	ea40 4001 	orr.w	r0, r0, r1, lsl #16
c0de0e2c:	eba4 040e 	sub.w	r4, r4, lr
c0de0e30:	2100      	movs	r1, #0
c0de0e32:	b11e      	cbz	r6, c0de0e3c <__udivmoddi4+0x9c>
c0de0e34:	40dc      	lsrs	r4, r3
c0de0e36:	2300      	movs	r3, #0
c0de0e38:	e9c6 4300 	strd	r4, r3, [r6]
c0de0e3c:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
c0de0e40:	428b      	cmp	r3, r1
c0de0e42:	d908      	bls.n	c0de0e56 <__udivmoddi4+0xb6>
c0de0e44:	2e00      	cmp	r6, #0
c0de0e46:	f000 80fb 	beq.w	c0de1040 <__udivmoddi4+0x2a0>
c0de0e4a:	2100      	movs	r1, #0
c0de0e4c:	e9c6 0500 	strd	r0, r5, [r6]
c0de0e50:	4608      	mov	r0, r1
c0de0e52:	e8bd 8ff0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
c0de0e56:	fab3 f183 	clz	r1, r3
c0de0e5a:	2900      	cmp	r1, #0
c0de0e5c:	d14b      	bne.n	c0de0ef6 <__udivmoddi4+0x156>
c0de0e5e:	42ab      	cmp	r3, r5
c0de0e60:	f0c0 80f1 	bcc.w	c0de1046 <__udivmoddi4+0x2a6>
c0de0e64:	4282      	cmp	r2, r0
c0de0e66:	f240 80ee 	bls.w	c0de1046 <__udivmoddi4+0x2a6>
c0de0e6a:	4608      	mov	r0, r1
c0de0e6c:	2e00      	cmp	r6, #0
c0de0e6e:	d0e5      	beq.n	c0de0e3c <__udivmoddi4+0x9c>
c0de0e70:	e9c6 4700 	strd	r4, r7, [r6]
c0de0e74:	e7e2      	b.n	c0de0e3c <__udivmoddi4+0x9c>
c0de0e76:	b902      	cbnz	r2, c0de0e7a <__udivmoddi4+0xda>
c0de0e78:	deff      	udf	#255	; 0xff
c0de0e7a:	fab2 f382 	clz	r3, r2
c0de0e7e:	2b00      	cmp	r3, #0
c0de0e80:	f040 809d 	bne.w	c0de0fbe <__udivmoddi4+0x21e>
c0de0e84:	1a8d      	subs	r5, r1, r2
c0de0e86:	ea4f 4e12 	mov.w	lr, r2, lsr #16
c0de0e8a:	b297      	uxth	r7, r2
c0de0e8c:	2101      	movs	r1, #1
c0de0e8e:	fbb5 f2fe 	udiv	r2, r5, lr
c0de0e92:	fb0e 5012 	mls	r0, lr, r2, r5
c0de0e96:	0c25      	lsrs	r5, r4, #16
c0de0e98:	ea45 4500 	orr.w	r5, r5, r0, lsl #16
c0de0e9c:	fb07 f002 	mul.w	r0, r7, r2
c0de0ea0:	42a8      	cmp	r0, r5
c0de0ea2:	d90f      	bls.n	c0de0ec4 <__udivmoddi4+0x124>
c0de0ea4:	eb1c 0505 	adds.w	r5, ip, r5
c0de0ea8:	f102 38ff 	add.w	r8, r2, #4294967295	; 0xffffffff
c0de0eac:	bf2c      	ite	cs
c0de0eae:	f04f 0901 	movcs.w	r9, #1
c0de0eb2:	f04f 0900 	movcc.w	r9, #0
c0de0eb6:	42a8      	cmp	r0, r5
c0de0eb8:	d903      	bls.n	c0de0ec2 <__udivmoddi4+0x122>
c0de0eba:	f1b9 0f00 	cmp.w	r9, #0
c0de0ebe:	f000 80ce 	beq.w	c0de105e <__udivmoddi4+0x2be>
c0de0ec2:	4642      	mov	r2, r8
c0de0ec4:	1a2d      	subs	r5, r5, r0
c0de0ec6:	b2a4      	uxth	r4, r4
c0de0ec8:	fbb5 f0fe 	udiv	r0, r5, lr
c0de0ecc:	fb0e 5510 	mls	r5, lr, r0, r5
c0de0ed0:	fb00 f707 	mul.w	r7, r0, r7
c0de0ed4:	ea44 4405 	orr.w	r4, r4, r5, lsl #16
c0de0ed8:	42a7      	cmp	r7, r4
c0de0eda:	d908      	bls.n	c0de0eee <__udivmoddi4+0x14e>
c0de0edc:	eb1c 0404 	adds.w	r4, ip, r4
c0de0ee0:	f100 35ff 	add.w	r5, r0, #4294967295	; 0xffffffff
c0de0ee4:	d202      	bcs.n	c0de0eec <__udivmoddi4+0x14c>
c0de0ee6:	42a7      	cmp	r7, r4
c0de0ee8:	f200 80b3 	bhi.w	c0de1052 <__udivmoddi4+0x2b2>
c0de0eec:	4628      	mov	r0, r5
c0de0eee:	1be4      	subs	r4, r4, r7
c0de0ef0:	ea40 4002 	orr.w	r0, r0, r2, lsl #16
c0de0ef4:	e79d      	b.n	c0de0e32 <__udivmoddi4+0x92>
c0de0ef6:	f1c1 0720 	rsb	r7, r1, #32
c0de0efa:	408b      	lsls	r3, r1
c0de0efc:	fa05 f401 	lsl.w	r4, r5, r1
c0de0f00:	fa22 fc07 	lsr.w	ip, r2, r7
c0de0f04:	40fd      	lsrs	r5, r7
c0de0f06:	408a      	lsls	r2, r1
c0de0f08:	ea4c 0c03 	orr.w	ip, ip, r3
c0de0f0c:	fa20 f307 	lsr.w	r3, r0, r7
c0de0f10:	ea4f 491c 	mov.w	r9, ip, lsr #16
c0de0f14:	431c      	orrs	r4, r3
c0de0f16:	fa1f fe8c 	uxth.w	lr, ip
c0de0f1a:	fa00 f301 	lsl.w	r3, r0, r1
c0de0f1e:	0c20      	lsrs	r0, r4, #16
c0de0f20:	fbb5 f8f9 	udiv	r8, r5, r9
c0de0f24:	fb09 5518 	mls	r5, r9, r8, r5
c0de0f28:	ea40 4505 	orr.w	r5, r0, r5, lsl #16
c0de0f2c:	fb08 f00e 	mul.w	r0, r8, lr
c0de0f30:	42a8      	cmp	r0, r5
c0de0f32:	d90f      	bls.n	c0de0f54 <__udivmoddi4+0x1b4>
c0de0f34:	eb1c 0505 	adds.w	r5, ip, r5
c0de0f38:	f108 3aff 	add.w	sl, r8, #4294967295	; 0xffffffff
c0de0f3c:	bf2c      	ite	cs
c0de0f3e:	f04f 0b01 	movcs.w	fp, #1
c0de0f42:	f04f 0b00 	movcc.w	fp, #0
c0de0f46:	42a8      	cmp	r0, r5
c0de0f48:	d903      	bls.n	c0de0f52 <__udivmoddi4+0x1b2>
c0de0f4a:	f1bb 0f00 	cmp.w	fp, #0
c0de0f4e:	f000 808c 	beq.w	c0de106a <__udivmoddi4+0x2ca>
c0de0f52:	46d0      	mov	r8, sl
c0de0f54:	1a2d      	subs	r5, r5, r0
c0de0f56:	b2a4      	uxth	r4, r4
c0de0f58:	fbb5 f0f9 	udiv	r0, r5, r9
c0de0f5c:	fb09 5510 	mls	r5, r9, r0, r5
c0de0f60:	fb00 fe0e 	mul.w	lr, r0, lr
c0de0f64:	ea44 4505 	orr.w	r5, r4, r5, lsl #16
c0de0f68:	45ae      	cmp	lr, r5
c0de0f6a:	d907      	bls.n	c0de0f7c <__udivmoddi4+0x1dc>
c0de0f6c:	eb1c 0505 	adds.w	r5, ip, r5
c0de0f70:	f100 34ff 	add.w	r4, r0, #4294967295	; 0xffffffff
c0de0f74:	d201      	bcs.n	c0de0f7a <__udivmoddi4+0x1da>
c0de0f76:	45ae      	cmp	lr, r5
c0de0f78:	d87e      	bhi.n	c0de1078 <__udivmoddi4+0x2d8>
c0de0f7a:	4620      	mov	r0, r4
c0de0f7c:	ea40 4008 	orr.w	r0, r0, r8, lsl #16
c0de0f80:	eba5 050e 	sub.w	r5, r5, lr
c0de0f84:	fba0 9802 	umull	r9, r8, r0, r2
c0de0f88:	4545      	cmp	r5, r8
c0de0f8a:	464c      	mov	r4, r9
c0de0f8c:	46c6      	mov	lr, r8
c0de0f8e:	d302      	bcc.n	c0de0f96 <__udivmoddi4+0x1f6>
c0de0f90:	d106      	bne.n	c0de0fa0 <__udivmoddi4+0x200>
c0de0f92:	454b      	cmp	r3, r9
c0de0f94:	d204      	bcs.n	c0de0fa0 <__udivmoddi4+0x200>
c0de0f96:	3801      	subs	r0, #1
c0de0f98:	ebb9 0402 	subs.w	r4, r9, r2
c0de0f9c:	eb68 0e0c 	sbc.w	lr, r8, ip
c0de0fa0:	2e00      	cmp	r6, #0
c0de0fa2:	d06f      	beq.n	c0de1084 <__udivmoddi4+0x2e4>
c0de0fa4:	1b1a      	subs	r2, r3, r4
c0de0fa6:	eb65 050e 	sbc.w	r5, r5, lr
c0de0faa:	fa22 f301 	lsr.w	r3, r2, r1
c0de0fae:	fa05 f707 	lsl.w	r7, r5, r7
c0de0fb2:	40cd      	lsrs	r5, r1
c0de0fb4:	2100      	movs	r1, #0
c0de0fb6:	431f      	orrs	r7, r3
c0de0fb8:	e9c6 7500 	strd	r7, r5, [r6]
c0de0fbc:	e73e      	b.n	c0de0e3c <__udivmoddi4+0x9c>
c0de0fbe:	fa02 fc03 	lsl.w	ip, r2, r3
c0de0fc2:	f1c3 0020 	rsb	r0, r3, #32
c0de0fc6:	fa01 f203 	lsl.w	r2, r1, r3
c0de0fca:	ea4f 4e1c 	mov.w	lr, ip, lsr #16
c0de0fce:	40c1      	lsrs	r1, r0
c0de0fd0:	fa24 f500 	lsr.w	r5, r4, r0
c0de0fd4:	fa1f f78c 	uxth.w	r7, ip
c0de0fd8:	409c      	lsls	r4, r3
c0de0fda:	4315      	orrs	r5, r2
c0de0fdc:	fbb1 f0fe 	udiv	r0, r1, lr
c0de0fe0:	0c2a      	lsrs	r2, r5, #16
c0de0fe2:	fb0e 1110 	mls	r1, lr, r0, r1
c0de0fe6:	ea42 4201 	orr.w	r2, r2, r1, lsl #16
c0de0fea:	fb00 f107 	mul.w	r1, r0, r7
c0de0fee:	4291      	cmp	r1, r2
c0de0ff0:	d90e      	bls.n	c0de1010 <__udivmoddi4+0x270>
c0de0ff2:	eb1c 0202 	adds.w	r2, ip, r2
c0de0ff6:	f100 38ff 	add.w	r8, r0, #4294967295	; 0xffffffff
c0de0ffa:	bf2c      	ite	cs
c0de0ffc:	f04f 0901 	movcs.w	r9, #1
c0de1000:	f04f 0900 	movcc.w	r9, #0
c0de1004:	4291      	cmp	r1, r2
c0de1006:	d902      	bls.n	c0de100e <__udivmoddi4+0x26e>
c0de1008:	f1b9 0f00 	cmp.w	r9, #0
c0de100c:	d031      	beq.n	c0de1072 <__udivmoddi4+0x2d2>
c0de100e:	4640      	mov	r0, r8
c0de1010:	1a52      	subs	r2, r2, r1
c0de1012:	b2ad      	uxth	r5, r5
c0de1014:	fbb2 f1fe 	udiv	r1, r2, lr
c0de1018:	fb0e 2211 	mls	r2, lr, r1, r2
c0de101c:	ea45 4502 	orr.w	r5, r5, r2, lsl #16
c0de1020:	fb01 f207 	mul.w	r2, r1, r7
c0de1024:	42aa      	cmp	r2, r5
c0de1026:	d907      	bls.n	c0de1038 <__udivmoddi4+0x298>
c0de1028:	eb1c 0505 	adds.w	r5, ip, r5
c0de102c:	f101 38ff 	add.w	r8, r1, #4294967295	; 0xffffffff
c0de1030:	d201      	bcs.n	c0de1036 <__udivmoddi4+0x296>
c0de1032:	42aa      	cmp	r2, r5
c0de1034:	d823      	bhi.n	c0de107e <__udivmoddi4+0x2de>
c0de1036:	4641      	mov	r1, r8
c0de1038:	1aad      	subs	r5, r5, r2
c0de103a:	ea41 4100 	orr.w	r1, r1, r0, lsl #16
c0de103e:	e726      	b.n	c0de0e8e <__udivmoddi4+0xee>
c0de1040:	4631      	mov	r1, r6
c0de1042:	4630      	mov	r0, r6
c0de1044:	e6fa      	b.n	c0de0e3c <__udivmoddi4+0x9c>
c0de1046:	1a84      	subs	r4, r0, r2
c0de1048:	eb65 0303 	sbc.w	r3, r5, r3
c0de104c:	2001      	movs	r0, #1
c0de104e:	461f      	mov	r7, r3
c0de1050:	e70c      	b.n	c0de0e6c <__udivmoddi4+0xcc>
c0de1052:	4464      	add	r4, ip
c0de1054:	3802      	subs	r0, #2
c0de1056:	e74a      	b.n	c0de0eee <__udivmoddi4+0x14e>
c0de1058:	4464      	add	r4, ip
c0de105a:	3802      	subs	r0, #2
c0de105c:	e6e4      	b.n	c0de0e28 <__udivmoddi4+0x88>
c0de105e:	3a02      	subs	r2, #2
c0de1060:	4465      	add	r5, ip
c0de1062:	e72f      	b.n	c0de0ec4 <__udivmoddi4+0x124>
c0de1064:	3902      	subs	r1, #2
c0de1066:	4462      	add	r2, ip
c0de1068:	e6c9      	b.n	c0de0dfe <__udivmoddi4+0x5e>
c0de106a:	f1a8 0802 	sub.w	r8, r8, #2
c0de106e:	4465      	add	r5, ip
c0de1070:	e770      	b.n	c0de0f54 <__udivmoddi4+0x1b4>
c0de1072:	3802      	subs	r0, #2
c0de1074:	4462      	add	r2, ip
c0de1076:	e7cb      	b.n	c0de1010 <__udivmoddi4+0x270>
c0de1078:	3802      	subs	r0, #2
c0de107a:	4465      	add	r5, ip
c0de107c:	e77e      	b.n	c0de0f7c <__udivmoddi4+0x1dc>
c0de107e:	3902      	subs	r1, #2
c0de1080:	4465      	add	r5, ip
c0de1082:	e7d9      	b.n	c0de1038 <__udivmoddi4+0x298>
c0de1084:	4631      	mov	r1, r6
c0de1086:	e6d9      	b.n	c0de0e3c <__udivmoddi4+0x9c>

c0de1088 <__aeabi_memclr>:
c0de1088:	2200      	movs	r2, #0
c0de108a:	f000 b804 	b.w	c0de1096 <__aeabi_memset>

c0de108e <__aeabi_memcpy>:
c0de108e:	f000 b807 	b.w	c0de10a0 <memcpy>

c0de1092 <__aeabi_memmove>:
c0de1092:	f000 b812 	b.w	c0de10ba <memmove>

c0de1096 <__aeabi_memset>:
c0de1096:	4613      	mov	r3, r2
c0de1098:	460a      	mov	r2, r1
c0de109a:	4619      	mov	r1, r3
c0de109c:	f000 b827 	b.w	c0de10ee <memset>

c0de10a0 <memcpy>:
c0de10a0:	440a      	add	r2, r1
c0de10a2:	1e43      	subs	r3, r0, #1
c0de10a4:	4291      	cmp	r1, r2
c0de10a6:	d100      	bne.n	c0de10aa <memcpy+0xa>
c0de10a8:	4770      	bx	lr
c0de10aa:	b510      	push	{r4, lr}
c0de10ac:	f811 4b01 	ldrb.w	r4, [r1], #1
c0de10b0:	4291      	cmp	r1, r2
c0de10b2:	f803 4f01 	strb.w	r4, [r3, #1]!
c0de10b6:	d1f9      	bne.n	c0de10ac <memcpy+0xc>
c0de10b8:	bd10      	pop	{r4, pc}

c0de10ba <memmove>:
c0de10ba:	4288      	cmp	r0, r1
c0de10bc:	b510      	push	{r4, lr}
c0de10be:	eb01 0402 	add.w	r4, r1, r2
c0de10c2:	d902      	bls.n	c0de10ca <memmove+0x10>
c0de10c4:	4284      	cmp	r4, r0
c0de10c6:	4623      	mov	r3, r4
c0de10c8:	d807      	bhi.n	c0de10da <memmove+0x20>
c0de10ca:	1e43      	subs	r3, r0, #1
c0de10cc:	42a1      	cmp	r1, r4
c0de10ce:	d008      	beq.n	c0de10e2 <memmove+0x28>
c0de10d0:	f811 2b01 	ldrb.w	r2, [r1], #1
c0de10d4:	f803 2f01 	strb.w	r2, [r3, #1]!
c0de10d8:	e7f8      	b.n	c0de10cc <memmove+0x12>
c0de10da:	4402      	add	r2, r0
c0de10dc:	4601      	mov	r1, r0
c0de10de:	428a      	cmp	r2, r1
c0de10e0:	d100      	bne.n	c0de10e4 <memmove+0x2a>
c0de10e2:	bd10      	pop	{r4, pc}
c0de10e4:	f813 4d01 	ldrb.w	r4, [r3, #-1]!
c0de10e8:	f802 4d01 	strb.w	r4, [r2, #-1]!
c0de10ec:	e7f7      	b.n	c0de10de <memmove+0x24>

c0de10ee <memset>:
c0de10ee:	4402      	add	r2, r0
c0de10f0:	4603      	mov	r3, r0
c0de10f2:	4293      	cmp	r3, r2
c0de10f4:	d100      	bne.n	c0de10f8 <memset+0xa>
c0de10f6:	4770      	bx	lr
c0de10f8:	f803 1b01 	strb.w	r1, [r3], #1
c0de10fc:	e7f9      	b.n	c0de10f2 <memset+0x4>
	...

c0de1100 <setjmp>:
c0de1100:	46ec      	mov	ip, sp
c0de1102:	e8a0 5ff0 	stmia.w	r0!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
c0de1106:	f04f 0000 	mov.w	r0, #0
c0de110a:	4770      	bx	lr

c0de110c <longjmp>:
c0de110c:	e8b0 5ff0 	ldmia.w	r0!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr}
c0de1110:	46e5      	mov	sp, ip
c0de1112:	0008      	movs	r0, r1
c0de1114:	bf08      	it	eq
c0de1116:	2001      	moveq	r0, #1
c0de1118:	4770      	bx	lr
c0de111a:	bf00      	nop

c0de111c <strlcat>:
c0de111c:	b570      	push	{r4, r5, r6, lr}
c0de111e:	4604      	mov	r4, r0
c0de1120:	4608      	mov	r0, r1
c0de1122:	1916      	adds	r6, r2, r4
c0de1124:	4621      	mov	r1, r4
c0de1126:	42b1      	cmp	r1, r6
c0de1128:	460b      	mov	r3, r1
c0de112a:	d106      	bne.n	c0de113a <strlcat+0x1e>
c0de112c:	1b1c      	subs	r4, r3, r4
c0de112e:	1b12      	subs	r2, r2, r4
c0de1130:	d108      	bne.n	c0de1144 <strlcat+0x28>
c0de1132:	f000 f82b 	bl	c0de118c <strlen>
c0de1136:	4420      	add	r0, r4
c0de1138:	bd70      	pop	{r4, r5, r6, pc}
c0de113a:	781d      	ldrb	r5, [r3, #0]
c0de113c:	3101      	adds	r1, #1
c0de113e:	2d00      	cmp	r5, #0
c0de1140:	d1f1      	bne.n	c0de1126 <strlcat+0xa>
c0de1142:	e7f3      	b.n	c0de112c <strlcat+0x10>
c0de1144:	4606      	mov	r6, r0
c0de1146:	4631      	mov	r1, r6
c0de1148:	f816 5b01 	ldrb.w	r5, [r6], #1
c0de114c:	b915      	cbnz	r5, c0de1154 <strlcat+0x38>
c0de114e:	1a08      	subs	r0, r1, r0
c0de1150:	701d      	strb	r5, [r3, #0]
c0de1152:	e7f0      	b.n	c0de1136 <strlcat+0x1a>
c0de1154:	2a01      	cmp	r2, #1
c0de1156:	bf1c      	itt	ne
c0de1158:	f102 32ff 	addne.w	r2, r2, #4294967295	; 0xffffffff
c0de115c:	f803 5b01 	strbne.w	r5, [r3], #1
c0de1160:	e7f1      	b.n	c0de1146 <strlcat+0x2a>

c0de1162 <strlcpy>:
c0de1162:	460b      	mov	r3, r1
c0de1164:	b510      	push	{r4, lr}
c0de1166:	b162      	cbz	r2, c0de1182 <strlcpy+0x20>
c0de1168:	3a01      	subs	r2, #1
c0de116a:	d008      	beq.n	c0de117e <strlcpy+0x1c>
c0de116c:	f813 4b01 	ldrb.w	r4, [r3], #1
c0de1170:	f800 4b01 	strb.w	r4, [r0], #1
c0de1174:	2c00      	cmp	r4, #0
c0de1176:	d1f7      	bne.n	c0de1168 <strlcpy+0x6>
c0de1178:	1a58      	subs	r0, r3, r1
c0de117a:	3801      	subs	r0, #1
c0de117c:	bd10      	pop	{r4, pc}
c0de117e:	2200      	movs	r2, #0
c0de1180:	7002      	strb	r2, [r0, #0]
c0de1182:	f813 2b01 	ldrb.w	r2, [r3], #1
c0de1186:	2a00      	cmp	r2, #0
c0de1188:	d1fb      	bne.n	c0de1182 <strlcpy+0x20>
c0de118a:	e7f5      	b.n	c0de1178 <strlcpy+0x16>

c0de118c <strlen>:
c0de118c:	4603      	mov	r3, r0
c0de118e:	f813 2b01 	ldrb.w	r2, [r3], #1
c0de1192:	2a00      	cmp	r2, #0
c0de1194:	d1fb      	bne.n	c0de118e <strlen+0x2>
c0de1196:	1a18      	subs	r0, r3, r0
c0de1198:	3801      	subs	r0, #1
c0de119a:	4770      	bx	lr

c0de119c <strnlen>:
c0de119c:	4602      	mov	r2, r0
c0de119e:	4401      	add	r1, r0
c0de11a0:	b510      	push	{r4, lr}
c0de11a2:	428a      	cmp	r2, r1
c0de11a4:	4613      	mov	r3, r2
c0de11a6:	d003      	beq.n	c0de11b0 <strnlen+0x14>
c0de11a8:	781c      	ldrb	r4, [r3, #0]
c0de11aa:	3201      	adds	r2, #1
c0de11ac:	2c00      	cmp	r4, #0
c0de11ae:	d1f8      	bne.n	c0de11a2 <strnlen+0x6>
c0de11b0:	1a18      	subs	r0, r3, r0
c0de11b2:	bd10      	pop	{r4, pc}

c0de11b4 <LIDO_SUBMIT_SELECTOR>:
c0de11b4:	90a1 ab3e                                   ..>.

c0de11b8 <LIDO_WRAP_STETH_SELECTOR>:
c0de11b8:	59ea b08c                                   .Y..

c0de11bc <LIDO_UNWRAP_WSTETH_SELECTOR>:
c0de11bc:	0ede 3e9a                                   ...>

c0de11c0 <LIDO_REQUEST_WITHDRAWALS_WITH_PERMIT_SELECTOR>:
c0de11c0:	f4ac 4d1e                                   ...M

c0de11c4 <LIDO_SELECTORS>:
c0de11c4:	11b4 c0de 11b8 c0de 11bc c0de 11c0 c0de     ................
c0de11d4:	774f 656e 0072 0020 6150 6172 206d 6f6e     Owner. .Param no
c0de11e4:	2074 7573 7070 726f 6574 0a64 4500 6874     t supported..Eth
c0de11f4:	7265 7565 006d 0030 7453 6b61 0065 7845     ereum.0.Stake.Ex
c0de1204:	6563 7470 6f69 206e 7830 7825 6320 7561     ception 0x%x cau
c0de1214:	6867 0a74 7000 756c 6967 206e 7270 766f     ght..plugin prov
c0de1224:	6469 2065 6170 6172 656d 6574 2072 6425     ide parameter %d
c0de1234:	2520 2a2e 0a48 6f00 6666 6573 3a74 2520      %.*H..offset: %
c0de1244:	2c64 6320 6568 6b63 6f70 6e69 3a74 2520     d, checkpoint: %
c0de1254:	2c64 7020 7261 6d61 7465 7265 664f 7366     d, parameterOffs
c0de1264:	7465 203a 6425 000a 5445 0048 6156 756c     et: %d..ETH.Valu
c0de1274:	0065 6168 646e 656c 6620 6e69 6c61 7a69     e.handle finaliz
c0de1284:	0a65 7300 4574 4854                          e..stETH.

c0de128d <HEXDIGITS>:
c0de128d:	3130 3332 3534 3736 3938 6261 6463 6665     0123456789abcdef
c0de129d:	7700 7473 5445 0048 7865 6563 7470 6f69     .wstETH.exceptio
c0de12ad:	5b6e 6425 3a5d 4c20 3d52 7830 3025 5838     n[%d]: LR=0x%08X
c0de12bd:	000a 5245 4f52 0052 7830 4d00 7369 6973     ..ERROR.0x.Missi
c0de12cd:	676e 7320 6c65 6365 6f74 4972 646e 7865     ng selectorIndex
c0de12dd:	000a 6c70 6775 6e69 7020 6f72 6976 6564     ..plugin provide
c0de12ed:	7420 6b6f 6e65 203a 7830 7025 202c 7830      token: 0x%p, 0x
c0de12fd:	7025 000a 6552 7571 7365 2074 6977 6874     %p..Request with
c0de130d:	7264 7761 6c61 2073 6977 6874 7020 7265     drawals with per
c0de131d:	696d 0074 6e55 6168 646e 656c 2064 656d     mit.Unhandled me
c0de132d:	7373 6761 2065 6425 000a 694c 6f64 5700     ssage %d..Lido.W
c0de133d:	6172 0070 6553 656c 7463 726f 4920 646e     rap.Selector Ind
c0de134d:	7865 3a20 6425 6e20 746f 7320 7075 6f70     ex :%d not suppo
c0de135d:	7472 6465 000a 6e55 6168 646e 656c 2064     rted..Unhandled 
c0de136d:	6573 656c 7463 726f 4920 646e 7865 203a     selector Index: 
c0de137d:	6425 000a 6e49 6176 696c 2064 6f63 746e     %d..Invalid cont
c0de138d:	7865 0a74 5500 776e 6172 0070 6553 656c     ext..Unwrap.Sele
c0de139d:	7463 726f 4920 646e 7865 2520 2064 6f6e     ctor Index %d no
c0de13ad:	2074 7573 7070 726f 6574 0a64 5200 6365     t supported..Rec
c0de13bd:	6965 6576 2064 6e61 6920 766e 6c61 6469     eived an invalid
c0de13cd:	7320 7263 6565 496e 646e 7865 2520 0a64      screenIndex %d.
	...

c0de13de <g_pcHex>:
c0de13de:	3130 3332 3534 3736 3938 6261 6463 6665     0123456789abcdef

c0de13ee <g_pcHex_cap>:
c0de13ee:	3130 3332 3534 3736 3938 4241 4443 4645     0123456789ABCDEF
	...
