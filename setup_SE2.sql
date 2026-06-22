-- Tabela SE2: Registros de pagamentos do Contas a Receber
-- Execute este SQL no Supabase > SQL Editor

CREATE TABLE IF NOT EXISTS SE2 (
  id               UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  pedido_id        INTEGER NOT NULL,
  cliente_nome     TEXT NOT NULL,
  valor_pedido     NUMERIC(10,2) NOT NULL DEFAULT 0,
  valor_pago       NUMERIC(10,2) NOT NULL DEFAULT 0,
  forma_pagamento  TEXT NOT NULL,
  data_pagamento   DATE NOT NULL DEFAULT CURRENT_DATE,
  observacao       TEXT,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

ALTER TABLE SE2 ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "acesso_anon_SE2" ON SE2;
CREATE POLICY "acesso_anon_SE2" ON SE2
  FOR ALL USING (true) WITH CHECK (true);
