-- ============================================================
-- PROTEÇÃO DE PEDIDOS ENTREGUES — Flores Bruna
-- Execute no Supabase: SQL Editor → New query → Run
--
-- Objetivo:
--   O app (pedidos.html) já bloqueia edição/exclusão de pedidos
--   com entregue = true na interface. Este script reforça a
--   mesma regra diretamente no banco, via trigger, para que a
--   integridade seja garantida mesmo que alguém tente alterar
--   os dados fora da tela (ex.: chamando a API do Supabase
--   diretamente).
--
--   Regra: se o pedido (SC5) já está com entregue = true,
--   nenhuma alteração ou exclusão é permitida — nem nele, nem
--   nos itens (SC6) vinculados a ele. A transição de
--   entregue = false → true (marcar como entregue) continua
--   funcionando normalmente.
-- ============================================================

-- ── Bloqueia UPDATE/DELETE em SC5 quando já entregue ─────────
CREATE OR REPLACE FUNCTION bloquear_alteracao_pedido_entregue()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'DELETE' THEN
    IF OLD.entregue THEN
      RAISE EXCEPTION 'Pedido #% já foi entregue e não pode ser excluído.', OLD.id;
    END IF;
    RETURN OLD;
  ELSE
    IF OLD.entregue THEN
      RAISE EXCEPTION 'Pedido #% já foi entregue e não pode ser editado.', OLD.id;
    END IF;
    RETURN NEW;
  END IF;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_bloquear_edicao_sc5 ON "SC5";
CREATE TRIGGER trg_bloquear_edicao_sc5
BEFORE UPDATE OR DELETE ON "SC5"
FOR EACH ROW EXECUTE FUNCTION bloquear_alteracao_pedido_entregue();

-- ── Bloqueia INSERT/UPDATE/DELETE em SC6 quando o pedido pai já entregue ──
CREATE OR REPLACE FUNCTION bloquear_alteracao_itens_pedido_entregue()
RETURNS TRIGGER AS $$
DECLARE
  v_entregue  boolean;
  v_pedido_id bigint;
BEGIN
  v_pedido_id := COALESCE(NEW.pedido_id, OLD.pedido_id);

  SELECT entregue INTO v_entregue FROM "SC5" WHERE id = v_pedido_id;

  IF v_entregue THEN
    RAISE EXCEPTION 'O pedido #% já foi entregue; os itens não podem ser alterados.', v_pedido_id;
  END IF;

  IF TG_OP = 'DELETE' THEN RETURN OLD; ELSE RETURN NEW; END IF;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_bloquear_itens_sc6 ON "SC6";
CREATE TRIGGER trg_bloquear_itens_sc6
BEFORE INSERT OR UPDATE OR DELETE ON "SC6"
FOR EACH ROW EXECUTE FUNCTION bloquear_alteracao_itens_pedido_entregue();
