import "core-js/stable";
import "regenerator-runtime/runtime";
import Eth from "@ledgerhq/hw-app-eth";
import Zemu from "@zondax/zemu";
import { expect } from "../jest";

const {NANOS_ETH_ELF_PATH, NANOX_ETH_ELF_PATH, NANOS_LIDO_LIB, NANOX_LIDO_LIB, sim_options_nanos, sim_options_nanox, TIMEOUT, getTmpPath} = require("generic.js");

const ORIGINAL_SNAPSHOT_PATH_PREFIX = "snapshots/unwrap/";

const ORIGINAL_SNAPSHOT_PATH_NANOS = ORIGINAL_SNAPSHOT_PATH_PREFIX + "nanos/";
const ORIGINAL_SNAPSHOT_PATH_NANOX = ORIGINAL_SNAPSHOT_PATH_PREFIX + "nanox/";

test("Unwrap nanos", async () => {
  jest.setTimeout(TIMEOUT);

  const sim = new Zemu(NANOS_ETH_ELF_PATH, NANOS_LIDO_LIB);

  let tmpPath = getTmpPath(expect.getState().currentTestName);

  try {
    await sim.start(sim_options_nanos);

    let transport = await sim.getTransport();
    const eth = new Eth(transport);

    // Send transaction
    let tx = eth.signTransaction("44'/60'/0'/1/0", "F8494B8502540BE400830222E0947F39C581F595B53C5CB19BD0B3F8DA6C935E2CA080A4DE0E9A3E0000000000000000000000000000000000000000000000000159D99970F27DC3018080");

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

    // Unwrap (1/3)
    filename = "unwrap_1.png";
    await sim.clickRight(tmpPath + filename);
    const unwrap_1 = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_unwrap_1 = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(unwrap_1).toMatchSnapshot(expected_unwrap_1);

    // unwrap (2/3)
    filename = "unwrap_2.png";
    await sim.clickRight(tmpPath + filename);
    const unwrap_2 = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_unwrap_2 = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(unwrap_2).toMatchSnapshot(expected_unwrap_2);

    // Unwrap (3/3)
    filename = "unwrap_3.png";
    await sim.clickRight(tmpPath + filename);
    const unwrap_3 = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_unwrap_3 = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOS + filename);
    expect(unwrap_3).toMatchSnapshot(expected_unwrap_3);

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
        'r': '2d52718649be9e213293aefaa17e7fa4fa23f92a88b3e6b2e7cb9bc32af1ad7d',
        's': '00a4a8e5fb59a09fb0af8a984fbcc37e042b7dc93380708818e22f8867f8149c',
        'v': '26'
      }
    );
  } finally {
    await sim.close();
  }
});

test.skip("Unwrap nanox", async () => {
  jest.setTimeout(TIMEOUT);

  const sim = new Zemu(NANOX_ETH_ELF_PATH, NANOX_LIDO_LIB);

    let tmpPath = getTmpPath(expect.getState().currentTestName);

  try {
    await sim.start(sim_options_nanox);

    let transport = await sim.getTransport();
    const eth = new Eth(transport);

    // Send transaction
    let tx = eth.signTransaction("44'/60'/0'/1/0", "F8494B8502540BE400830222E0947F39C581F595B53C5CB19BD0B3F8DA6C935E2CA080A4DE0E9A3E0000000000000000000000000000000000000000000000000159D99970F27DC3018080");

    let filename;

    await sim.waitUntilScreenIsNot(sim.getMainMenuSnapshot());
    // Review tx
    filename = "review.png";
    await sim.snapshot(tmpPath + filename);
    const review = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_review = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(review).toMatchSnapshot(expected_review);

    // Lido Wrap message
    filename = "lido.png";
    await sim.clickRight(tmpPath + filename);
    const lido = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_lido = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(lido).toMatchSnapshot(expected_lido);

    // Unwrap
    filename = "unwrap.png";
    await sim.clickRight(tmpPath + filename);
    const unwrap = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_unwrap = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(unwrap).toMatchSnapshot(expected_unwrap);

    // Max Fees
    filename = "fees.png";
    await sim.clickRight(tmpPath + filename);
    const fees = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_fees = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(fees).toMatchSnapshot(expected_fees);

    // Accept
    filename = "accept.png";
    await sim.clickRight(tmpPath + filename);
    const accept = Zemu.LoadPng2RGB(tmpPath + filename);
    const expected_accept = Zemu.LoadPng2RGB(ORIGINAL_SNAPSHOT_PATH_NANOX + filename);
    expect(accept).toMatchSnapshot(expected_accept);

    await sim.clickBoth();

    await expect(tx).resolves.toEqual(
      {
        'r': '2d52718649be9e213293aefaa17e7fa4fa23f92a88b3e6b2e7cb9bc32af1ad7d',
        's': '00a4a8e5fb59a09fb0af8a984fbcc37e042b7dc93380708818e22f8867f8149c',
        'v': '26'
      }
    );
  } finally {
    await sim.close();
  }
});
