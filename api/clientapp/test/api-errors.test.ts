import { describe, it, expect } from 'vitest';
import { problemText } from '../src/api-errors.js';
import { AbisClient, ApiException, HttpValidationProblemDetails, ProblemDetails } from '../src/generated/abis-client.js';

/**
 * What a page shows when an API call fails.
 *
 * Both failures were found in the browser, not by a test:
 *  - minting a receiving BOL as a user without Shipment(Receiving) showed "Mint failed: An unexpected server
 *    error occurred." — the generated client's message for EVERY status an endpoint does not declare, 403
 *    included, with the server's explanation left unparsed in `response`;
 *  - correcting a coil's customer showed "Customer change failed: [object Object]" — for a status the
 *    endpoint DOES declare a problem body for, the client throws the parsed problem, which has no message.
 *
 * Where the shape matters these drive the real generated client, so a regeneration that changes either
 * shape fails here rather than on the plant floor.
 */

/** A client whose every call gets this response. */
const answering = (status: number, body = ''): AbisClient =>
  new AbisClient('', {
    fetch: async () => ({ status, headers: new Map(), text: async () => body }) as unknown as Response,
  });

async function rejection(p: Promise<unknown>): Promise<unknown> {
  try { await p; } catch (e) { return e; }
  throw new Error('expected the call to fail');
}

const GATE_403 = JSON.stringify({
  type: 'https://tools.ietf.org/html/rfc9110#section-15.5.4', title: 'Forbidden', status: 403,
  detail: "User 'jsmith' lacks the required privilege (1) on feature 'Shipment(Receiving)'.",
});

describe('problemText — what the generated client throws', () => {
  it('reads the feature gate 403 the mint endpoint does not declare, instead of "unexpected server error"', async () => {
    const e = await rejection(answering(403, GATE_403).mintBolCoils(7));
    expect(ApiException.isApiException(e)).toBe(true);
    expect((e as Error).message).toBe('An unexpected server error occurred.');   // the bug, as generated
    expect(problemText(e)).toBe("User 'jsmith' lacks the required privilege (1) on feature 'Shipment(Receiving)'.");
  });

  it('says it is a permission problem when a 403 carries no body', async () => {
    expect(problemText(await rejection(answering(403).mintBolCoils(7)))).toBe("You don't have permission for this action.");
  });

  it('does not mistake a problem\'s default "Forbidden" title for an explanation', async () => {
    const body = JSON.stringify({ title: 'Forbidden', status: 403 });
    expect(problemText(await rejection(answering(403, body).mintBolCoils(7)))).toBe("You don't have permission for this action.");
  });

  it('says "Not found." for a bare 404', async () => {
    expect(problemText(await rejection(answering(404).mintBolCoils(7)))).toBe('Not found.');
  });

  it('takes the first validation message from an ApiException body', async () => {
    const body = JSON.stringify({ title: 'One or more validation errors occurred.', status: 400,
      errors: { bol: [''], customerId: ['customerId is required.', 'customerId must be positive.'] } });
    expect(problemText(await rejection(answering(400, body).mintBolCoils(7)))).toBe('customerId is required.');
  });

  it('reads a declared validation problem, which is thrown as the problem object and has no message', () => {
    const e = HttpValidationProblemDetails.fromJS({ title: 'One or more validation errors occurred.', status: 400,
      errors: { customerId: ['Coil 5009 is already booked to customer 4002.'] } });
    expect((e as unknown as Error).message).toBeUndefined();
    expect(problemText(e)).toBe('Coil 5009 is already booked to customer 4002.');
  });

  it('prefers a problem\'s detail over its validation messages', () => {
    const e = HttpValidationProblemDetails.fromJS({ status: 400, detail: 'Nothing on this BOL can be minted.',
      errors: { coils: ['coils is empty.'] } });
    expect(problemText(e)).toBe('Nothing on this BOL can be minted.');
  });

  it('reads the detail of an undeclared 409, over its title', async () => {
    const body = JSON.stringify({ title: 'Coil is terminal', detail: 'Coil 5005 is shipped; its customer cannot be changed here.' });
    expect(problemText(await rejection(answering(409, body).mintBolCoils(7))))
      .toBe('Coil 5005 is shipped; its customer cannot be changed here.');
  });

  it('uses a specific title when there is no detail', () => {
    expect(problemText(ProblemDetails.fromJS({ status: 409, title: 'Nothing to mint' }))).toBe('Nothing to mint');
    expect(problemText(ProblemDetails.fromJS({ status: 409, title: 'Conflict' })))
      .toBe('That conflicts with the current state of the record.');
  });

  it('never calls an unexplained 4xx a server error', async () => {
    expect(problemText(await rejection(answering(422).mintBolCoils(7)))).toBe('The server refused the request (HTTP 422).');
  });

  it('keeps the generic message for a real server fault, ignoring a non-JSON body', async () => {
    const e = await rejection(answering(502, '<html><body>Bad Gateway</body></html>').mintBolCoils(7));
    expect(problemText(e)).toBe('An unexpected server error occurred.');
  });
});

describe('problemText — everything else a catch block sees', () => {
  it('passes an ordinary Error through unchanged', () => {
    expect(problemText(new Error('Failed to fetch'))).toBe('Failed to fetch');
    // accounting.ts branches on this prefix from its own fetch helper.
    expect(problemText(new Error('404 Not Found'))).toBe('404 Not Found');
  });

  it('copes with a thrown string or nothing at all', () => {
    expect(problemText('Could not read CSV')).toBe('Could not read CSV');
    expect(problemText(undefined)).toBe('Unknown error.');
    expect(problemText(null)).toBe('Unknown error.');
  });

  it('never renders [object Object] or undefined, whatever is thrown', () => {
    for (const thrown of [{}, { status: 400 }, { response: 'not json' }, { response: '[1,2]' }, null, undefined,
      new Error(''), 'plain string', 42]) {
      const text = problemText(thrown);
      expect(text).not.toContain('[object Object]');
      expect(text).not.toContain('undefined');
      expect(text.trim()).not.toBe('');
    }
  });
});
