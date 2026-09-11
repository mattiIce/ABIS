import { describe, it, expect } from 'vitest';
import { bannerText } from '../src/edi-transmit-banner.js';
import type { EdiTransmitPolicyView, EdiArmedPair } from '../src/generated/abis-client.js';

/**
 * The EDI transmit banner.
 *
 * This strip renders on every tab of the EDI page, so for most people it IS the answer to "is ABIS
 * sending anything". Three separate things can stop transmission and they are not interchangeable:
 *
 *  - the valve is closed,
 *  - no partner/document pair is armed,
 *  - nothing is connected to the transport at all (the funnel is not wired).
 *
 * The last is the strongest guarantee and the current state. The first is the only one an operator
 * can change from this screen.
 *
 * The bug these tests exist for: the first version short-circuited on `wired` and never mentioned
 * the valve, so opening the valve and closing it again produced a byte-identical banner. Valve state
 * persists across a database refresh (the ABIS_ tables are excluded from the parfile), so an open
 * valve left behind would have sat there invisibly until somebody wired the funnel.
 */
const policy = (o: Partial<EdiTransmitPolicyView>): EdiTransmitPolicyView =>
  ({ valveOpen: false, armed: [] as EdiArmedPair[], transmitting: false, wired: false, ...o }) as EdiTransmitPolicyView;

describe('the EDI transmit banner', () => {
  it('says the valve is open even when the funnel is what is stopping traffic', () => {
    const t = bannerText(policy({ valveOpen: true, wired: false }));
    expect(t.title).toBe('EDI transmission is disabled');
    expect(t.body).toContain('OPEN');
    // and it must not imply somebody else will tidy it up
    expect(t.body).toContain('refresh will not close it');
  });

  it('distinguishes an open valve from a closed one while unwired', () => {
    const open = bannerText(policy({ valveOpen: true, wired: false })).body;
    const shut = bannerText(policy({ valveOpen: false, wired: false })).body;
    expect(open).not.toBe(shut);
  });

  it('names the funnel as the reason when nothing is wired', () => {
    const t = bannerText(policy({ valveOpen: false, wired: false }));
    expect(t.body).toContain('No generation path is connected');
    expect(t.kind).toBe('warn');
  });

  it('says the valve is closed when it is the operative reason', () => {
    const t = bannerText(policy({ valveOpen: false, wired: true }));
    expect(t.body).toContain('The valve is closed.');
  });

  it('an open valve with nothing armed still reads as disabled', () => {
    const t = bannerText(policy({ valveOpen: true, wired: true, transmitting: false }));
    expect(t.title).toBe('EDI transmission is disabled');
    expect(t.body).toContain('no partner/document pair is armed');
  });

  it('goes loud only when the valve is open, a pair is armed AND the funnel is wired', () => {
    const armed = [{ transactionType: '861', customerId: 1153 }] as EdiArmedPair[];
    const live = bannerText(policy({ valveOpen: true, armed, transmitting: true, wired: true }));
    expect(live.kind).toBe('crit');
    expect(live.title).toBe('EDI transmission is LIVE');

    // …and the same policy with the funnel unwired must NOT claim it is live. This is the assertion
    // that keeps a stale `wired` from turning the safest screen into the most misleading one.
    const notWired = bannerText(policy({ valveOpen: true, armed, transmitting: true, wired: false }));
    expect(notWired.kind).toBe('warn');
    expect(notWired.title).toBe('EDI transmission is disabled');
  });

  it('always tells the reader documents are still generated', () => {
    for (const p of [
      policy({}),
      policy({ valveOpen: true }),
      policy({ wired: true }),
      policy({ valveOpen: true, wired: true }),
    ]) {
      expect(bannerText(p).body).toContain('still generated and stored');
    }
  });
});
