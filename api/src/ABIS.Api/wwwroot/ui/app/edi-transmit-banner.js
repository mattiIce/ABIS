// What the EDI transmit banner says.
//
// Extracted from edi.ts so it can be tested. The page module runs its bootstrap at import time
// (initShell, then the DOM scaffold), so anything left inline there can only be checked by driving a
// browser by hand — the same reason skid-weight.ts was pulled out of the DAS console.
//
// This text is on every tab of the EDI page, which makes it, for most people, the answer to "is ABIS
// sending anything". Keep it a pure function of the policy: no DOM, no fetch, no clock.
/**
 * The banner, shown on every tab.
 *
 * <p>Three reasons transmission can be off, and they are NOT interchangeable: the valve is shut,
 * nothing is armed, or nothing is connected to the valve at all. Someone deciding whether it is safe
 * to touch EDI needs to know which one is holding.</p>
 *
 * <p><b>The valve position is stated in every message, including the ones where it is not the
 * operative reason.</b> The first cut short-circuited on `!wired` and never mentioned the valve, so
 * opening it and closing it again produced an identical banner — the one screen that is on every tab
 * concealed the one piece of state a person can actually change. Valve state also persists: the
 * `ABIS_*` tables are excluded from the refresh parfile, so an open valve survives a refresh and
 * nothing will close it on its own.</p>
 */
export function bannerText(p) {
    const n = (p.armed ?? []).length;
    const tail = 'Documents are still generated and stored &mdash; they are just not sent. Legacy '
        + '(ediprocess.sh + GXS.ksh) continues to transmit on its own cron regardless.';
    if (p.transmitting && p.wired) {
        return {
            kind: 'crit',
            title: 'EDI transmission is LIVE',
            body: `The valve is open and ${n} pair${n === 1 ? ' is' : 's are'} armed. Documents ABIS generates `
                + 'for those partners are written to the VAN outbox and transmitted by the GXS cron.',
        };
    }
    // Say the operative reason first, then the valve position — always, even when the valve is not
    // what is stopping traffic.
    const why = !p.wired
        ? 'No generation path is connected to the transport, so nothing is sent whatever the valve says. '
            + (p.valveOpen
                ? 'The valve itself is OPEN. That is harmless while nothing is wired to it, but it will not '
                    + 'close on its own and a database refresh will not close it either.'
                : 'The valve itself is closed.')
        : !p.valveOpen
            ? 'The valve is closed.'
            : `The valve is open, but no partner/document pair is armed (${n}), so nothing is permitted through.`;
    return { kind: 'warn', title: 'EDI transmission is disabled', body: `${why} ${tail}` };
}
