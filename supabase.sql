-- ABA Gestão online: tabelas do ABA dentro de um projeto Supabase que já tem outro site.
-- Tudo aqui tem o prefixo aba_ e não mexe em nenhuma tabela, política ou configuração do outro site.
--
-- ANTES DE RODAR: troque SEU_EMAIL_AQUI (lá no final) pelo e-mail que você usa para entrar.
-- Depois cole tudo no SQL Editor e clique em Run. Pode rodar de novo sem problema.

-- 0. Segurança: se já existir uma tabela com esses nomes que não seja do ABA, para aqui sem mexer em nada
do $$
begin
  if exists (select 1 from information_schema.tables where table_schema = 'public' and table_name = 'aba_dados')
     and not exists (select 1 from information_schema.columns where table_schema = 'public' and table_name = 'aba_dados' and column_name = 'versao') then
    raise exception 'Já existe uma tabela public.aba_dados que não é do ABA Gestão. Nada foi alterado.';
  end if;
end $$;

-- 1. Quem pode usar o ABA. O login é o mesmo do outro site, então ter conta no projeto não basta:
--    só os usuários desta lista enxergam ou salvam dados do ABA.
create table if not exists public.aba_usuarios (
  user_id   uuid primary key references auth.users(id) on delete cascade,
  criado_em timestamptz not null default now()
);

-- 2. Dados de cada usuário (uma linha por conta, com tudo dentro de "dados")
create table if not exists public.aba_dados (
  user_id       uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  dados         jsonb not null,
  versao        integer not null default 1,
  atualizado_em timestamptz not null default now()
);

-- 3. Cópias automáticas (no máximo uma a cada 10 minutos, guarda as últimas 100)
create table if not exists public.aba_historico (
  id       bigint generated always as identity primary key,
  user_id  uuid not null references auth.users(id) on delete cascade,
  dados    jsonb not null,
  versao   integer not null,
  salvo_em timestamptz not null default now()
);
create index if not exists aba_historico_user_idx on public.aba_historico (user_id, salvo_em desc);

-- 4. Regras de acesso: só o dono, e só se estiver na lista do ABA
alter table public.aba_usuarios  enable row level security;
alter table public.aba_dados     enable row level security;
alter table public.aba_historico enable row level security;

drop policy if exists "aba ve o proprio acesso" on public.aba_usuarios;
drop policy if exists "aba dono le"       on public.aba_dados;
drop policy if exists "aba dono cria"     on public.aba_dados;
drop policy if exists "aba dono altera"   on public.aba_dados;
drop policy if exists "aba dono le copias" on public.aba_historico;

create policy "aba ve o proprio acesso" on public.aba_usuarios
  for select to authenticated using (auth.uid() = user_id);

create policy "aba dono le" on public.aba_dados for select to authenticated
  using (auth.uid() = user_id and exists (select 1 from public.aba_usuarios u where u.user_id = auth.uid()));
create policy "aba dono cria" on public.aba_dados for insert to authenticated
  with check (auth.uid() = user_id and exists (select 1 from public.aba_usuarios u where u.user_id = auth.uid()));
create policy "aba dono altera" on public.aba_dados for update to authenticated
  using (auth.uid() = user_id and exists (select 1 from public.aba_usuarios u where u.user_id = auth.uid()))
  with check (auth.uid() = user_id);
create policy "aba dono le copias" on public.aba_historico for select to authenticated
  using (auth.uid() = user_id and exists (select 1 from public.aba_usuarios u where u.user_id = auth.uid()));
-- Sem política de delete e sem insert em aba_usuarios/aba_historico: pelo site ninguém apaga dados
-- nem se dá acesso. O histórico só é gravado pelo gatilho abaixo.

-- 5. Antes de cada gravação: confere a versão e guarda a cópia anterior
create or replace function public.aba_antes_de_salvar()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  new.atualizado_em := now();
  if new.versao <> old.versao + 1 then
    raise exception 'versao fora de ordem (esperado %, recebido %)', old.versao + 1, new.versao;
  end if;
  if not exists (
    select 1 from aba_historico
    where user_id = old.user_id and salvo_em > now() - interval '10 minutes'
  ) then
    insert into aba_historico (user_id, dados, versao) values (old.user_id, old.dados, old.versao);
    delete from aba_historico
    where user_id = old.user_id
      and id not in (select id from aba_historico where user_id = old.user_id order by salvo_em desc limit 100);
  end if;
  return new;
end;
$$;

drop trigger if exists aba_antes_de_salvar on public.aba_dados;
create trigger aba_antes_de_salvar
  before update on public.aba_dados
  for each row execute function public.aba_antes_de_salvar();

-- 6. Libera o seu login no ABA. TROQUE O E-MAIL ABAIXO.
do $$
declare
  v_email text := 'SEU_EMAIL_AQUI';
begin
  insert into public.aba_usuarios (user_id)
  select id from auth.users where lower(email) = lower(v_email)
  on conflict do nothing;
  if not exists (select 1 from public.aba_usuarios u join auth.users a on a.id = u.user_id where lower(a.email) = lower(v_email)) then
    raise exception 'Não existe usuário com o e-mail "%" neste projeto. Crie em Authentication > Users (ou confira o e-mail) e rode de novo.', v_email;
  end if;
end $$;
