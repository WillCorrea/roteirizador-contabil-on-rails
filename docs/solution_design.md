# Desenho da Solução — Roteirizador Contábil

## Visão Geral
Pipeline que recebe transações financeiras, normaliza, aplica regras contábeis e integra via lote a um SAP Contábil (mock).

## Fluxo (detalhado)
1. **Ingestão** via `POST /api/v1/transactions` (array de transações)
2. **Validação/Normalização** (campos obrigatórios, tipos, moeda)
3. **Persistência** em `transactions`
4. **Job** `ProcessTransactionJob` aplica **Routing::AccountingRouter**
5. Geração de **journal_entries** (débito/crédito) vinculados a um **integration_batch**
6. **DispatchBatchJob** envia lote ao SAP (mock) e recebe protocolo
7. Atualiza status do lote para **integrated**
8. **Logs** detalham erros e execuções

## Entidades
- **Transaction**: dado financeiro original
- **JournalEntry**: lançamentos contábeis gerados
- **IntegrationBatch**: agrupamento para integração
- **LedgerAccount**: plano de contas (catálogo)
- **ProcessingLog**: rastreabilidade e auditoria

## Regras (exemplo fictício)
- `product_code` contendo `SUBS` → receita de assinatura
- `product_code` contendo `SKU` → receita de produto
- Centro de custo conforme família do produto
- Históricos padronizados por tipo de operação

## Decisões Técnicas (ADR)
- **Jobs assíncronos** para isolamento de falhas e escalabilidade
- **Batching** para reduzir chamadas externas e melhorar throughput
- **Índices em occurred_at e external_id** para consultas e deduplicação
- **Logs estruturados** para observabilidade

