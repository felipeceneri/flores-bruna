-- ============================================================
-- RLS RESTRITO — Flores Bruna
-- Execute no Supabase: SQL Editor → New query → Run
--
-- Estratégia:
--   • SELECT aberto (dados não são sigilosos ao público)
--   • INSERT/UPDATE permitidos (app precisa criar e editar)
--   • DELETE bloqueado em SE2 (histórico de pagamentos é auditoria)
--   • DELETE permitido nas demais tabelas (validação feita no JS)
-- ============================================================

-- ── SE2 (Pagamentos — nunca deve ser deletado via API) ──────
DROP POLICY IF EXISTS "acesso_anon_SE2" ON "SE2";

CREATE POLICY "se2_select"  ON "SE2" FOR SELECT USING (true);
CREATE POLICY "se2_insert"  ON "SE2" FOR INSERT WITH CHECK (true);
CREATE POLICY "se2_update"  ON "SE2" FOR UPDATE USING (true) WITH CHECK (true);
-- DELETE intencionalmente ausente: nenhuma ação apaga pagamentos registrados

-- ── SA1 (Clientes) ──────────────────────────────────────────
DROP POLICY IF EXISTS "acesso_anon_SA1" ON "SA1";

CREATE POLICY "sa1_select"  ON "SA1" FOR SELECT USING (true);
CREATE POLICY "sa1_insert"  ON "SA1" FOR INSERT WITH CHECK (true);
CREATE POLICY "sa1_update"  ON "SA1" FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "sa1_delete"  ON "SA1" FOR DELETE USING (true);

-- ── SB2 (Lançamentos / Entradas) ────────────────────────────
DROP POLICY IF EXISTS "acesso_anon_SB2" ON "SB2";

CREATE POLICY "sb2_select"  ON "SB2" FOR SELECT USING (true);
CREATE POLICY "sb2_insert"  ON "SB2" FOR INSERT WITH CHECK (true);
CREATE POLICY "sb2_update"  ON "SB2" FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "sb2_delete"  ON "SB2" FOR DELETE USING (true);

-- ── SC5 (Pedidos) ────────────────────────────────────────────
DROP POLICY IF EXISTS "acesso_anon_SC5" ON "SC5";

CREATE POLICY "sc5_select"  ON "SC5" FOR SELECT USING (true);
CREATE POLICY "sc5_insert"  ON "SC5" FOR INSERT WITH CHECK (true);
CREATE POLICY "sc5_update"  ON "SC5" FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "sc5_delete"  ON "SC5" FOR DELETE USING (true);

-- ── SC6 (Itens do Pedido) ────────────────────────────────────
DROP POLICY IF EXISTS "acesso_anon_SC6" ON "SC6";

CREATE POLICY "sc6_select"  ON "SC6" FOR SELECT USING (true);
CREATE POLICY "sc6_insert"  ON "SC6" FOR INSERT WITH CHECK (true);
CREATE POLICY "sc6_update"  ON "SC6" FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "sc6_delete"  ON "SC6" FOR DELETE USING (true);

-- ── produtos ─────────────────────────────────────────────────
DROP POLICY IF EXISTS "acesso_anon_produtos" ON "produtos";

CREATE POLICY "produtos_select" ON "produtos" FOR SELECT USING (true);
CREATE POLICY "produtos_insert" ON "produtos" FOR INSERT WITH CHECK (true);
CREATE POLICY "produtos_update" ON "produtos" FOR UPDATE USING (true) WITH CHECK (true);
CREATE POLICY "produtos_delete" ON "produtos" FOR DELETE USING (true);

-- ── usuarios ─────────────────────────────────────────────────
DROP POLICY IF EXISTS "acesso_anon_usuarios" ON "usuarios";

CREATE POLICY "usuarios_select" ON "usuarios" FOR SELECT USING (true);
CREATE POLICY "usuarios_insert" ON "usuarios" FOR INSERT WITH CHECK (true);
CREATE POLICY "usuarios_update" ON "usuarios" FOR UPDATE USING (true) WITH CHECK (true);
-- DELETE de usuários bloqueado — remoção só pelo admin via app
