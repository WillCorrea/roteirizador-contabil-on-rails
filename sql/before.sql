-- Consulta lenta (antes)
SELECT t.external_id, SUM(j.amount_cents) AS total_cents
FROM transactions t
JOIN journal_entries j ON j.transaction_id = t.id
WHERE t.occurred_at BETWEEN '2025-11-01' AND '2025-11-30'
GROUP BY t.external_id;