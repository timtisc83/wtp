-- Run once in the Supabase SQL editor (safe to re-run).

create table if not exists public.responses (
  id text primary key,
  session text not null check (char_length(session) <= 30),
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
create index if not exists responses_session_idx on public.responses (session);

alter table public.responses enable row level security;

drop policy if exists "anyone can read"   on public.responses;
drop policy if exists "anyone can insert" on public.responses;
drop policy if exists "anyone can update" on public.responses;
drop policy if exists "anyone can delete" on public.responses;

create policy "anyone can read"   on public.responses for select using (true);
create policy "anyone can insert" on public.responses for insert with check (true);
create policy "anyone can update" on public.responses for update using (true) with check (true);
create policy "anyone can delete" on public.responses for delete using (true);

-- Old key-based reset function from the first version, no longer used:
drop function if exists public.reset_session(text, text);
