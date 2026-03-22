create table if not exists public.fos_workspaces (
  slug text primary key,
  name text not null,
  app_state jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default timezone('utc', now()),
  updated_at timestamptz not null default timezone('utc', now())
);

alter table public.fos_workspaces enable row level security;

drop policy if exists "anon_can_read_fos_workspaces" on public.fos_workspaces;
create policy "anon_can_read_fos_workspaces"
on public.fos_workspaces
for select
to anon
using (true);

drop policy if exists "anon_can_write_fos_workspaces" on public.fos_workspaces;
create policy "anon_can_write_fos_workspaces"
on public.fos_workspaces
for insert
to anon
with check (true);

drop policy if exists "anon_can_update_fos_workspaces" on public.fos_workspaces;
create policy "anon_can_update_fos_workspaces"
on public.fos_workspaces
for update
to anon
using (true)
with check (true);
