# Especificação Funcional (Fictícia)

## Endpoint: Ingestão de Transações
- **POST** `/api/v1/transactions`
- `Content-Type: application/json`
- Body: `{"transactions":[...]]}`

### Regras de Negócio
- Validar campos obrigatórios: `id`, `product_code`, `amount`, `occurred_at`
- Rejeitar payloads duplicados por `id` (idempotência)
- Normalizar moeda (centavos)
- Agrupar por **batch**

## Integração SAP (Mock)
- **POST** `/sap_mock/batch` (interno ao serviço)
- Retorna `external_protocol`
- Caso indisponível, reprocesso por Job

## Erros & Logs
- Logs por transação e por lote
- Status por transação: `pending`, `processed`, `failed`
- Status por lote: `open`, `integrated`, `failed`

