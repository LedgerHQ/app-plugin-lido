import "core-js/stable";
import "regenerator-runtime/runtime";
import Eth from "@ledgerhq/hw-app-eth";
import Zemu from "@zondax/zemu";
import { expect } from "../jest";

const {NANOS_ETH_ELF_PATH, NANOX_ETH_ELF_PATH, NANOS_LIDO_LIB, NANOX_LIDO_LIB, sim_options_nanos, sim_options_nanox, TIMEOUT, getTmpPath} = require("generic.js");

const ORIGINAL_SNAPSHOT_PATH_PREFIX = "snapshots/stake/";

const ORIGINAL_SNAPSHOT_PATH_NANOS = ORIGINAL_SNAPSHOT_PATH_PREFIX + "nanos/";
const ORIGINAL_SNAPSHOT_PATH_NANOX = ORIGINAL_SNAPSHOT_PATH_PREFIX + "nanox/";

test("Stake nanos", async () => {
  jest.setTimeout(TIMEOUT);

  const sim = new Zemu(NANOS_ETH_ELF_PATH, NANOS_LIDO_LIB);

  let tmpPath = getTmpPath(expect.getState().currentTestName);

  try {
    await sim.start(sim_options_nanos);

    let transport = await sim.getTransport();
    const eth = new Eth(transport);

    // Send transaction
    let tx = eth.signTransaction("44'/60'/0'/1/0", "F851488502540BE4008301D4C094AE7AB96520DE3A18E5E111B5EAAB095312D7FE8488016345785D8A0000A4A1903EAB0000000000000000000000000000000000000000000000000000000000000000018080");

    let filename;

    await sim.waitUntilScreenIsNot(sim.getMainMenuSnapshot());
    // Review tx
    filename = "review.png";
    await sim.snapshot(tmpPath + filename);
    const review = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_review = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(review).toMatchSnapshot(expected_review);

    // Lido Stake message
    filename = "lido.png";
    await sim.clickRight(tmpPath + filename);
    const lido = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_lido = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(lido).toMatchSnapshot(expected_lido);

    // Stake
    filename = "stake.png";
    await sim.clickRight(tmpPath + filename);
    const stake = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_stake = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(stake).toMatchSnapshot(expected_stake);

    // Max Fees
    filename = "fees.png";
    await sim.clickRight(tmpPath + filename);
    const fees = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_fees = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(fees).toMatchSnapshot(expected_fees);

    // Accept
    filename = "accept.png";
    await sim.clickRight(tmpPath + filename);
    const accept = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_accept = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(accept).toMatchSnapshot(expected_accept);

    await sim.clickBoth();

    await expect(tx).resolves.toEqual(
      {
        'r': '88bf7b171fa2a30e1b01fb8cd454f63595fbce396544569a95bce06ae7703594',
        's': '36316e231738faa9e22f3951cb44ca515e9f1fd9a3b1ae37c6cd2986f6914695',
        'v': '26'
      }
    );
  } finally {
    await sim.close();
  }
});

test("Stake nanos with referrer", async () => {
  jest.setTimeout(TIMEOUT);

  const sim = new Zemu(NANOS_ETH_ELF_PATH, NANOS_LIDO_LIB);
  
  let tmpPath = getTmpPath(expect.getState().currentTestName);

  try {
    await sim.start(sim_options_nanos);

    let transport = await sim.getTransport();
    const eth = new Eth(transport);

    // Send transaction
    let tx = eth.signTransaction("44'/60'/0'/1/0", "F851488502540BE4008301D4C094AE7AB96520DE3A18E5E111B5EAAB095312D7FE8488016345785D8A0000A4A1903EAB00000000000000000000000000000000000000000000aa998877665544332211018080");

    let filename;

    await sim.waitUntilScreenIsNot(sim.getMainMenuSnapshot());
    // Review tx
    filename = "review.png";
    await sim.snapshot(tmpPath + filename);
    const review = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_review = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(review).toMatchSnapshot(expected_review);

    // Lido Stake message
    filename = "lido.png";
    await sim.clickRight(tmpPath + filename);
    const lido = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_lido = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(lido).toMatchSnapshot(expected_lido);

    // Stake
    filename = "stake.png";
    await sim.clickRight(tmpPath + filename);
    const stake = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_stake = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(stake).toMatchSnapshot(expected_stake);

    // Max Fees
    filename = "fees.png";
    await sim.clickRight(tmpPath + filename);
    const fees = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_fees = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(fees).toMatchSnapshot(expected_fees);

    // Accept
    filename = "accept.png";
    await sim.clickRight(tmpPath + filename);
    const accept = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_accept = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(accept).toMatchSnapshot(expected_accept);

    await sim.clickBoth();

    await expect(tx).resolves.toEqual(
      {
        'r': '45fd653ae09dcad99a2a148297d9a29d032f439b04cbeb04fdfa5b1d8b793f8a',
        's': '61d96a30b475e29e26e769cfab61fc170eae42a0fd51bcaaf4718a558171c6f4',
        'v': '25'
      }
    );
  } finally {
    await sim.close();
  }
});


test("Stake nanox", async () => {
  jest.setTimeout(TIMEOUT);

  const sim = new Zemu(NANOX_ETH_ELF_PATH, NANOX_LIDO_LIB);

  let tmpPath = getTmpPath(expect.getState().currentTestName);

  try {
    await sim.start(sim_options_nanox);

    let transport = await sim.getTransport();
    const eth = new Eth(transport);

    // Send transaction
    let tx = eth.signTransaction("44'/60'/0'/1/0", "F851488502540BE4008301D4C094AE7AB96520DE3A18E5E111B5EAAB095312D7FE8488016345785D8A0000A4A1903EAB0000000000000000000000000000000000000000000000000000000000000000018080");

    let filename;

    await sim.waitUntilScreenIsNot(sim.getMainMenuSnapshot());
    // Review tx
    filename = "review.png";
    await sim.snapshot(tmpPath + filename);
    const review = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_review = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(review).toEqual(expected_review);

    // Lido Stake message
    filename = "lido.png";
    await sim.clickRight(tmpPath + filename);
    const lido = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_lido = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(lido).toEqual(expected_lido);

    // Stake
    filename = "stake.png";
    await sim.clickRight(tmpPath + filename);
    const stake = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_stake = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(stake).toEqual(expected_stake);

    // Max Fees
    filename = "fees.png";
    await sim.clickRight(tmpPath + filename);
    const fees = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_fees = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(fees).toEqual(expected_fees);

    // Accept
    filename = "accept.png";
    await sim.clickRight(tmpPath + filename);
    const accept = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_accept = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(accept).toEqual(expected_accept);

    await sim.clickBoth();

    await expect(tx).resolves.toEqual(
      {
        'r': '88bf7b171fa2a30e1b01fb8cd454f63595fbce396544569a95bce06ae7703594',
        's': '36316e231738faa9e22f3951cb44ca515e9f1fd9a3b1ae37c6cd2986f6914695',
        'v': '26'
      }
    );
  } finally {
    await sim.close();
  }
});

test("Stake nanox with referrer", async () => {
  jest.setTimeout(TIMEOUT);

  const sim = new Zemu(NANOX_ETH_ELF_PATH, NANOX_LIDO_LIB);

  let tmpPath = getTmpPath(expect.getState().currentTestName);

  try {
    await sim.start(sim_options_nanox);

    let transport = await sim.getTransport();
    const eth = new Eth(transport);

    // Send transaction
    let tx = eth.signTransaction("44'/60'/0'/1/0", "F851488502540BE4008301D4C094AE7AB96520DE3A18E5E111B5EAAB095312D7FE8488016345785D8A0000A4A1903EAB00000000000000000000000000000000000000000000aa998877665544332211018080");

    let filename;

    await sim.waitUntilScreenIsNot(sim.getMainMenuSnapshot());
    // Review tx
    filename = "review.png";
    await sim.snapshot(tmpPath + filename);
    const review = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_review = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(review).toEqual(expected_review);

    // Lido Stake message
    filename = "lido.png";
    await sim.clickRight(tmpPath + filename);
    const lido = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_lido = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(lido).toEqual(expected_lido);

    // Stake
    filename = "stake.png";
    await sim.clickRight(tmpPath + filename);
    const stake = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_stake = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(stake).toEqual(expected_stake);

    // Max Fees
    filename = "fees.png";
    await sim.clickRight(tmpPath + filename);
    const fees = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_fees = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(fees).toEqual(expected_fees);

    // Accept
    filename = "accept.png";
    await sim.clickRight(tmpPath + filename);
    const accept = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_accept = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(accept).toEqual(expected_accept);

    await sim.clickBoth();

    await expect(tx).resolves.toEqual(
      {
        'r': '45fd653ae09dcad99a2a148297d9a29d032f439b04cbeb04fdfa5b1d8b793f8a',
        's': '61d96a30b475e29e26e769cfab61fc170eae42a0fd51bcaaf4718a558171c6f4',
        'v': '25'
      }
    );
  } finally {
    await sim.close();
  }
});