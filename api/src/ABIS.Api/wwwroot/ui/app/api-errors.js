// What went wrong, in words the reader can act on — from whatever a page's catch block caught.
//
// The NSwag client fails in two shapes, and neither was readable as pages used it:
//
//  1. A status the endpoint does not DECLARE a typed body for throws an ApiException whose `message` is
//     "An unexpected server error occurred." whatever the status was. A 403 from the feature gate, a
//     409 conflict and a genuine 500 all read the same, and the reader goes looking at the server when
//     the account simply lacks a grant. The server's own explanation is still there, unparsed, in
//     `response`.
//  2. A status it DOES declare a ProblemDetails body for (most 400s, a few 409s and a 503) throws that
//     parsed object itself. It is not an Error and has no `message`, so `(e as Error).message` printed
//     "undefined".
//
// The API answers RFC 9457 problem details: `detail` says what happened (the feature gate's 403 names
// the user, the level and the feature) and a validation 400 carries `errors: { field: [message] }`.
//
// Deliberately free of imports and of the DOM: page modules bootstrap when imported, so this has to be
// loadable by a unit test on its own.
/** The generated client's message for any status it has no typed response for — including 4xx. */
const NSWAG_UNEXPECTED = 'An unexpected server error occurred.';
/** What a status means when the server said nothing more specific. */
const STATUS_TEXT = {
    400: 'The request was not valid.',
    401: 'You are not signed in, or your session has expired.',
    403: "You don't have permission for this action.",
    404: 'Not found.',
    409: 'That conflicts with the current state of the record.',
};
/** ASP.NET Core's default problem titles: they restate the status, so a status phrase reads better. */
const GENERIC_TITLES = new Set([
    'bad request', 'unauthorized', 'forbidden', 'not found', 'conflict', 'precondition failed',
    'unprocessable entity', 'unprocessable content', 'internal server error', 'service unavailable',
    'one or more validation errors occurred.', 'an error occurred while processing your request.',
]);
const nonEmpty = (v) => typeof v === 'string' && v.trim() !== '' ? v.trim() : undefined;
function parseProblem(body) {
    if (typeof body !== 'string' || body.trim() === '')
        return undefined;
    try {
        const p = JSON.parse(body);
        return p !== null && typeof p === 'object' && !Array.isArray(p) ? p : undefined;
    }
    catch {
        return undefined;
    } // an HTML error page from a proxy, say — not ours to show
}
function firstError(errors) {
    if (errors === null || typeof errors !== 'object')
        return undefined;
    for (const v of Object.values(errors)) {
        for (const m of Array.isArray(v) ? v : [v]) {
            const s = nonEmpty(m);
            if (s)
                return s;
        }
    }
    return undefined;
}
/**
 * A user-readable sentence for a thrown error: the problem's `detail`, else its first validation
 * message, else a specific `title`, else what the status means, else the error's own message.
 */
export function problemText(e) {
    if (typeof e === 'string')
        return nonEmpty(e) ?? 'Unknown error.';
    if (e === null || typeof e !== 'object')
        return e === undefined || e === null ? 'Unknown error.' : String(e);
    const x = e;
    // An ApiException carries the body as text; a declared ProblemDetails response IS the problem.
    const problem = parseProblem(x.response) ?? (e instanceof Error ? undefined : e);
    const status = typeof x.status === 'number' ? x.status
        : typeof problem?.status === 'number' ? problem.status : undefined;
    if (problem) {
        const said = nonEmpty(problem.detail) ?? firstError(problem.errors);
        if (said)
            return said;
        const title = nonEmpty(problem.title);
        if (title && !GENERIC_TITLES.has(title.toLowerCase()))
            return title;
    }
    if (status !== undefined && STATUS_TEXT[status])
        return STATUS_TEXT[status];
    const message = nonEmpty(x.message);
    // Never let a 4xx read as a server fault: nothing is broken, the request was refused.
    if (status !== undefined && status >= 400 && status < 500 && (!message || message === NSWAG_UNEXPECTED))
        return `The server refused the request (HTTP ${status}).`;
    if (message)
        return message;
    if (status !== undefined)
        return `The request failed (HTTP ${status}).`;
    return nonEmpty(problem?.title) ?? 'Unknown error.';
}
