-- =============================================================
-- EstoqueApp — Flores Bruna
-- Tabela de Usuários e Permissões
-- Execute este script no Editor SQL do seu projeto Supabase
-- =============================================================

CREATE TABLE IF NOT EXISTS usuarios (
  id          UUID        DEFAULT gen_random_uuid() PRIMARY KEY,
  nome        TEXT        NOT NULL UNIQUE,
  senha_hash  TEXT        NOT NULL,
  ativo       BOOLEAN     NOT NULL DEFAULT true,
  permissoes  JSONB       NOT NULL DEFAULT '[]'::jsonb,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Habilitar Row Level Security
ALTER TABLE usuarios ENABLE ROW LEVEL SECURITY;

-- Política permissiva (controle de acesso feito na aplicação)
DROP POLICY IF EXISTS "acesso_anon_usuarios" ON usuarios;
CREATE POLICY "acesso_anon_usuarios" ON usuarios
  FOR ALL USING (true) WITH CHECK (true);

-- =============================================================
-- Após executar este SQL, abra  primeiro-acesso.html  no navegador
-- para cadastrar o primeiro usuário administrador com a senha
-- que você quiser — sem precisar digitar hash manualmente.
-- =============================================================
