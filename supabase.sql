-- Run once in the Supabase SQL editor.
-- Change 'CHANGE_ME' to your own reset key before running.

create table if not exists public.responses (
  id text primary key,
  session text not null check (char_length(session) <= 30),
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
create index if not exists responses_session_idx on public.responses (session);

alter table public.responses enable row level security;

create policy "anyone can read"   on public.responses for select using (true);
create policy "anyone can insert" on public.responses for insert with check (true);
create policy "anyone can update" on public.responses for update using (true) with check (true);
-- No delete policy: anon cannot delete rows directly.

-- Host reset: deletes one session, only with the key.
create or replace function public.reset_session(p_session text, p_key text)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if p_key is distinct from 'CHANGE_ME' then
    raise exception 'wrong key';
  end if;
  delete from public.responses where session = p_session;
end;
$$;
revoke all on function public.reset_session(text, text) from public;
grant execute on function public.reset_session(text, text) to anon;
