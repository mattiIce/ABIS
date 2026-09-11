import { describe, it, expect } from 'vitest';
import { problemText } from '../src/api-errors.js';

/**
 * problemText — turning a thrown API error into words.
 *
 * Found in the browser, not by a test: correcting a coil's customer to the customer it was already booked to
 * showed "Customer change failed: [object Object]". The endpoint DECLARES its 400 validation problem, and for
 * a declared status the generated client throws the parsed problem object rather than an exception carrying
 * the body. The first helper only read the body, fell through to String(e), and printed the object.
 */
describe('problemText', () => {
  it('reads a DECLARED validation problem, which the client throws as the parsed object', () => {
    const thrown = {
      title: 'One or more validation errors occurred.',
      status: 400,
      errors: { customerId: ['Coil 5009 is already booked to customer 4002.'] },
    };
    expect(problemText(thrown)).toBe('Coil 5009 is already booked to customer 4002.');
  });

  it('reads an UNDECLARED status, which arrives as an exception carrying the raw body', () => {
    const thrown = {
      message: 'An unexpected server error occurred.',
      status: 409,
      response: JSON.stringify({ title: 'Coil is terminal', detail: 'Coil 5005 is shipped; its customer cannot be changed here.' }),
    };
    expect(problemText(thrown)).toBe('Coil 5005 is shipped; its customer cannot be changed here.');
  });

  it('prefers a specific detail over a generic title', () => {
    expect(problemText({ title: 'Conflict', detail: 'Specific reason.' })).toBe('Specific reason.');
  });

  it('keeps the server reason on a 403 when there is one', () => {
    const thrown = { status: 403, response: JSON.stringify({ title: 'Forbidden', detail: "User 'mlee' lacks the required privilege (1) on feature 'Inventory(Coil)'." }) };
    expect(problemText(thrown)).toContain('Inventory(Coil)');
  });

  it('says a bodiless 403 is a permission problem, not a server error', () => {
    const thrown = { message: 'An unexpected server error occurred.', status: 403, response: '' };
    expect(problemText(thrown)).toBe("You don't have permission to do that.");
  });

  it('never renders [object Object], whatever is thrown', () => {
    for (const thrown of [{}, { status: 400 }, { response: 'not json' }, null, undefined, new Error('boom'), 'plain string']) {
      expect(problemText(thrown)).not.toContain('[object Object]');
    }
    expect(problemText(new Error('boom'))).toBe('boom');
  });
});
