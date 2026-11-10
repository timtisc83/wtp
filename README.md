# WTP Lab

Live classroom tool: students answer five willingness-to-pay (WTP) tasks for an energy drink, the host projects the results.

Methods: direct question, Van Westendorp, Gabor-Granger, BDM (incentive-compatible), price A/B test, plus a comparison view.

## Setup

1. Supabase: create a project, open the SQL editor, paste `supabase.sql` (set your own reset key first) and run it.
2. In `index.html`, fill `CFG.SUPABASE_URL` and `CFG.SUPABASE_ANON_KEY` (Project Settings > API, use the anon public key, never the service key).
3. GitHub: Settings > Pages > Deploy from branch `main`, folder `/ (root)`.

## Use

- Students: `https://timtisc83.github.io/wtp/?s=ppd26`
- Host (projector): `https://timtisc83.github.io/wtp/?s=ppd26&host=true`
- `s` separates sessions (cohorts). Without Supabase config the page runs in demo mode with an "Add 60 simulated students" button in the host view.

## Notes

- Row-level security allows anyone with the anon key to read, insert and update responses. Responses are anonymous; do not collect personal data.
- Reset of a session requires the key set in `supabase.sql`.
- The BDM purchase is simulated unless you execute a real transaction.
