-- Consulta otimizada (depois)
-- Índices:
--  CREATE INDEX idx_transactions_occurred_at ON transactions(occurred_at);
--  CREATE INDEX idx_journal_entries_tx_id ON journal_entries(transaction_id);

SELECT t.external_id, SUM(j.amount_cents) AS total_cents
FROM transactions t
JOIN journal_entries j ON j.transaction_id = t.id
WHERE t.occurred_at >= DATE '2025-11-01'
  AND t.occurred_at <  DATE '2025-12-01'
GROUP BY t.external_id;