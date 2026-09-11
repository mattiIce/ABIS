// Turning a thrown API error into words a person can act on.
//
// Kept out of the page modules on purpose: a page bootstraps itself at import time, so anything left
// inline there can only be checked by driving a browser — which is exactly how the bug below was found.
//
// Two shapes arrive in a catch block, and both must be read:
//  - For a status the endpoint DECLARES (e.g. `.ProducesValidationProblem()` → 400), the generated NSwag
//    client throws the PARSED problem object itself: `{ title, status, detail?, errors? }`.
//  - For a status it does not declare, it throws an ApiException whose `response` is the raw body text and
//    whose `message` is the generic "An unexpected server error occurred." — wrong for a 403 or a 409.
// Reading only the second shape printed "[object Object]" for every validation refusal (2026-09-11).
export function problemText(e) {
    if (typeof e === 'string')
        return e;
    const x = (e ?? {});
    let p = x;
    if (typeof x.response === 'string' && x.response.trim()) {
        try {
            p = JSON.parse(x.response);
        }
        catch { /* not a problem body */ }
    }
    const firstError = p.errors
        ? Object.values(p.errors).flat().find((m) => typeof m === 'string' && m.trim().length > 0)
        : undefined;
    if (p.detail)
        return p.detail;
    if (firstError)
        return firstError;
    if (x.status === 403)
        return "You don't have permission to do that.";
    if (x.status === 404)
        return 'Not found.';
    if (p.title)
        return p.title;
    if (typeof x.status === 'number')
        return `The request failed (${x.status}).`;
    return x.message || 'The request failed.';
}
