import "core-js/stable";
import "regenerator-runtime/runtime";
import Eth from "@ledgerhq/hw-app-eth";
import { byContractAddress } from "@ledgerhq/hw-app-eth/erc20";
import Zemu from "@zondax/zemu";
import { TransportStatusError } from "@ledgerhq/errors";
import { expect } from "../jest";

const {NANOS_ETH_ELF_PATH, NANOX_ETH_ELF_PATH, NANOS_LIDO_LIB, NANOX_LIDO_LIB, sim_options_nanos, sim_options_nanox, TIMEOUT} = require("generic.js");

const ORIGINAL_SNAPSHOT_PATH_PREFIX = "snapshots/stake/";
const SNAPSHOT_PATH_PREFIX = "snapshots/tmp/";

const ORIGINAL_SNAPSHOT_PATH_NANOS = ORIGINAL_SNAPSHOT_PATH_PREFIX + "nanos/";
const ORIGINAL_SNAPSHOT_PATH_NANOX = ORIGINAL_SNAPSHOT_PATH_PREFIX + "nanox/";

const SNAPSHOT_PATH_NANOS = SNAPSHOT_PATH_PREFIX + "nanos/";
const SNAPSHOT_PATH_NANOX = SNAPSHOT_PATH_PREFIX + "nanox/";

test("Transfer nanos", async () => {
  jest.setTimeout(TIMEOUT);

  const sim = new Zemu(NANOS_ETH_ELF_PATH, NANOS_LIDO_LIB);

  try {
    await sim.start(sim_options_nanos);

    let transport = await sim.getTransport();
    const eth = new Eth(transport);

    let buffer = Buffer.from("058000002C8000003C800000010000000000000000F851488502540BE4008301D4C094AE7AB96520DE3A18E5E111B5EAAB095312D7FE8488016345785D8A0000A4A1903EAB0000000000000000000000000000000000000000000000000000000000000000018080", "hex");

    await eth.setExternalPlugin("ae7ab96520de3a18e5e111b5eaab095312d7fe84", "a1903eab");

    // Send transaction
    let tx = transport.send(0xe0, 0x04, 0x00, 0x00, buffer);
    let filename;

    await sim.waitUntilScreenIsNot(sim.getMainMenuSnapshot());
    // Review tx
    filename = "review.png";
    await sim.snapshot(SNAPSHOT_PATH_NANOS + filename);
    const review = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_review = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(review).toEqual(expected_review);

    // Lido Stake message
    filename = "lido.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const lido = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_lido = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(lido).toEqual(expected_lido);

    // Stake 1/2 
    filename = "stake_1.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const stake_1 = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_stake_1 = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(stake_1).toEqual(expected_stake_1);

    // Stake 2/2
    filename = "stake_2.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const stake_2 = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_stake_2 = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(stake_2).toEqual(expected_stake_2);

    // Max Fees
    filename = "fees.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const fees = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_fees = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(fees).toEqual(expected_fees);

    // Accept
    filename = "accept.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const accept = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_accept = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(accept).toEqual(expected_accept);

    await sim.clickBoth();

    await expect(tx).resolves.toEqual(
      Buffer.from([37, 58, 117, 33, 222, 177, 118, 205, 109, 64, 199, 254, 254, 98, 128, 162, 170, 45, 142, 50, 202, 51, 13, 224, 167, 106, 126, 52, 218, 62, 14, 93, 150, 92, 135, 129, 2, 6, 2, 22, 176, 87, 239, 126, 100, 158, 160, 167, 149, 110, 143, 61, 111, 95, 250, 186, 131, 168, 205, 180, 167, 149, 236, 53, 99, 144, 0])
    );
  } finally {
    await sim.close();
  }
});

test("Transfer nanos with referrer", async () => {
  jest.setTimeout(TIMEOUT);

  const sim = new Zemu(NANOS_ETH_ELF_PATH, NANOS_LIDO_LIB);

  try {
    await sim.start(sim_options_nanos);

    let transport = await sim.getTransport();
    const eth = new Eth(transport);

    let buffer = Buffer.from("058000002C8000003C800000010000000000000000F851488502540BE4008301D4C094AE7AB96520DE3A18E5E111B5EAAB095312D7FE8488016345785D8A0000A4A1903EAB00000000000000000000000000000000000000000000aa998877665544332211018080", "hex");

    await eth.setExternalPlugin("ae7ab96520de3a18e5e111b5eaab095312d7fe84", "a1903eab");

    // Send transaction
    let tx = transport.send(0xe0, 0x04, 0x00, 0x00, buffer);
    let filename;

    await sim.waitUntilScreenIsNot(sim.getMainMenuSnapshot());
    // Review tx
    filename = "review.png";
    await sim.snapshot(SNAPSHOT_PATH_NANOS + filename);
    const review = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_review = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(review).toEqual(expected_review);

    // Lido Stake message
    filename = "lido.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const lido = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_lido = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(lido).toEqual(expected_lido);

    // Stake 1/2 
    filename = "stake_1.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const stake_1 = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_stake_1 = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(stake_1).toEqual(expected_stake_1);

    // Stake 2/2
    filename = "stake_2.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const stake_2 = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_stake_2 = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(stake_2).toEqual(expected_stake_2);

    // Referrer 1/3
    filename = "referrer_1.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const referrer_1 = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_referrer_1 = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(referrer_1).toEqual(expected_referrer_1);
    
    // Referrer 2/3
    filename = "referrer_2.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const referrer_2 = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_referrer_2 = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(referrer_2).toEqual(expected_referrer_2);    
    
    // Referrer 3/3
    filename = "referrer_3.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const referrer_3 = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_referrer_3 = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(referrer_3).toEqual(expected_referrer_3);

    // Max Fees
    filename = "fees.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const fees = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_fees = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(fees).toEqual(expected_fees);

    // Accept
    filename = "accept.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOS + filename);
    const accept = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOS + filename);
    const expected_accept = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(accept).toEqual(expected_accept);

    await sim.clickBoth();

    await expect(tx).resolves.toEqual(
      Buffer.from([38, 73, 77, 225, 83, 156, 235, 27, 107, 225, 85, 175, 31, 202, 30, 205, 46, 76, 70, 101, 79, 99, 67, 62, 188, 183, 114, 95, 40, 173, 85, 215, 48, 124, 130, 126, 250, 67, 93, 98, 42, 214, 59, 223, 141, 194, 216, 27, 182, 238, 19, 11, 90, 4, 120, 4, 237, 196, 102, 133, 233, 69, 138, 54, 151, 144, 0])
    );
  } finally {
    await sim.close();
  }
});


test("Transfer nanox", async () => {
  jest.setTimeout(TIMEOUT);

  const sim = new Zemu(NANOX_ETH_ELF_PATH, NANOX_LIDO_LIB);

  try {
    await sim.start(sim_options_nanox);

    let transport = await sim.getTransport();
    const eth = new Eth(transport);

    let buffer = Buffer.from("058000002C8000003C800000010000000000000000F851488502540BE4008301D4C094AE7AB96520DE3A18E5E111B5EAAB095312D7FE8488016345785D8A0000A4A1903EAB0000000000000000000000000000000000000000000000000000000000000000018080", "hex");

    await eth.setExternalPlugin("ae7ab96520de3a18e5e111b5eaab095312d7fe84", "a1903eab");

    // Send transaction
    let tx = transport.send(0xe0, 0x04, 0x00, 0x00, buffer);
    let filename;

    await sim.waitUntilScreenIsNot(sim.getMainMenuSnapshot());
    // Review tx
    filename = "review.png";
    await sim.snapshot(SNAPSHOT_PATH_NANOX + filename);
    const review = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOX + filename);
    const expected_review = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(review).toEqual(expected_review);

    // Lido Stake message
    filename = "lido.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOX + filename);
    const lido = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOX + filename);
    const expected_lido = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(lido).toEqual(expected_lido);

    // Stake
    filename = "stake.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOX + filename);
    const stake = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOX + filename);
    const expected_stake = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(stake).toEqual(expected_stake);

    // Max Fees
    filename = "fees.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOX + filename);
    const fees = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOX + filename);
    const expected_fees = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(fees).toEqual(expected_fees);

    // Accept
    filename = "accept.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOX + filename);
    const accept = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOX + filename);
    const expected_accept = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(accept).toEqual(expected_accept);

    await sim.clickBoth();

    await expect(tx).resolves.toEqual(
      Buffer.from([37, 58, 117, 33, 222, 177, 118, 205, 109, 64, 199, 254, 254, 98, 128, 162, 170, 45, 142, 50, 202, 51, 13, 224, 167, 106, 126, 52, 218, 62, 14, 93, 150, 92, 135, 129, 2, 6, 2, 22, 176, 87, 239, 126, 100, 158, 160, 167, 149, 110, 143, 61, 111, 95, 250, 186, 131, 168, 205, 180, 167, 149, 236, 53, 99, 144, 0])
    );
  } finally {
    await sim.close();
  }
});

test("Transfer nanox with referrer", async () => {
  jest.setTimeout(TIMEOUT);

  const sim = new Zemu(NANOX_ETH_ELF_PATH, NANOX_LIDO_LIB);

  try {
    await sim.start(sim_options_nanox);

    let transport = await sim.getTransport();
    const eth = new Eth(transport);

    let buffer = Buffer.from("058000002C8000003C800000010000000000000000F851488502540BE4008301D4C094AE7AB96520DE3A18E5E111B5EAAB095312D7FE8488016345785D8A0000A4A1903EAB00000000000000000000000000000000000000000000aa998877665544332211018080", "hex");

    await eth.setExternalPlugin("ae7ab96520de3a18e5e111b5eaab095312d7fe84", "a1903eab");

    // Send transaction
    let tx = transport.send(0xe0, 0x04, 0x00, 0x00, buffer);
    let filename;

    await sim.waitUntilScreenIsNot(sim.getMainMenuSnapshot());
    // Review tx
    filename = "review.png";
    await sim.snapshot(SNAPSHOT_PATH_NANOX + filename);
    const review = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOX + filename);
    const expected_review = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(review).toEqual(expected_review);

    // Lido Stake message
    filename = "lido.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOX + filename);
    const lido = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOX + filename);
    const expected_lido = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(lido).toEqual(expected_lido);

    // Stake
    filename = "stake.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOX + filename);
    const stake = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOX + filename);
    const expected_stake = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(stake).toEqual(expected_stake);

    // Referrer
    filename = "referrer.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOX + filename);
    const referrer = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOX + filename);
    const expected_referrer = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(referrer).toEqual(expected_referrer);

    // Max Fees
    filename = "fees.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOX + filename);
    const fees = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOX + filename);
    const expected_fees = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(fees).toEqual(expected_fees);

    // Accept
    filename = "accept.png";
    await sim.clickRight(SNAPSHOT_PATH_NANOX + filename);
    const accept = Zemu.LoadPng2RGB(SNAPSHOT_PATH_NANOX + filename);
    const expected_accept = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(accept).toEqual(expected_accept);

    await sim.clickBoth();

    await expect(tx).resolves.toEqual(
      Buffer.from([38, 73, 77, 225, 83, 156, 235, 27, 107, 225, 85, 175, 31, 202, 30, 205, 46, 76, 70, 101, 79, 99, 67, 62, 188, 183, 114, 95, 40, 173, 85, 215, 48, 124, 130, 126, 250, 67, 93, 98, 42, 214, 59, 223, 141, 194, 216, 27, 182, 238, 19, 11, 90, 4, 120, 4, 237, 196, 102, 133, 233, 69, 138, 54, 151, 144, 0])
    );
  } finally {
    await sim.close();
  }
});