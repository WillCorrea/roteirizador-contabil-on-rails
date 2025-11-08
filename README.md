# Roteirizador Contábil (Portfolio) — Ruby on Rails

> Projeto fictício (inspirado em casos reais) para demonstrar arquitetura, integrações e otimização de dados contábeis.
> **Sem dados confidenciais** e **sem uso de código de empresas**.

## Objetivo
Receber transações financeiras (JSON), **normalizar**, aplicar **regras contábeis**, agregar em **lotes de integração** e enviar (mock) para um **SAP Contábil**.

## Principais pontos
- API REST (Rails-like) para ingestão de transações
- Pipeline assíncrono com **Jobs**
- **PostgreSQL** com índices e queries otimizadas
- Roteirização contábil (regras, contas, centro de custo, histórico)
- Logs e rastreabilidade por **lote**

## Stack
- Ruby on Rails (estrutura), Ruby 3.x (ilustrativo)
- PostgreSQL
- Jobs (ex.: GoodJob/Sidekiq) — aqui como jobs Ruby
- Documentação em `/docs`
- Exemplos em `/examples`

> Este repositório é **didático**. O código está escrito para leitura portfólio e não visa executar _as-is_.

## Fluxo (resumo)
1. `POST /api/v1/transactions` recebe transações em JSON
2. Ingestor salva dados em `transactions` (normaliza e valida)
3. Job `ProcessTransactionJob` aplica **roteirização contábil**
4. Gera **journal_entries** e agrega em **integration_batches**
5. `DispatchBatchJob` envia lote ao **SAP (mock)** e marca como integrado
6. Logs completos do processamento

## Como navegar
- **Controllers**: `/app/controllers/api/v1`
- **Models**: `/app/models`
- **Services**
  - Ingestão: `/app/services/ingestion`
  - Roteirização: `/app/services/routing`
  - Integração SAP (mock): `/app/services/integration`
- **Jobs**: `/app/jobs`
- **Banco**: `/db/migrate`, `/db/schema.rb` (ilustrativo)
- **Docs**: `/docs`
- **SQL Tuning**: `/sql`

## Métricas (exemplos de impacto)
- Redução de tempo de processamento por lote: **-68%** (ex.: 12m → 3m50s)
- Falhas recorrentes por inconsistência de dados: **-80%**
- Ganho de throughput por otimização de índices: **+2.4x**

---

## Endpoints principais
- `POST /api/v1/transactions` — ingere transações
- `POST /api/v1/batches/:id/dispatch` — dispara envio ao SAP (mock)

Veja os payloads em `/examples`.

## Licença
MIT — uso livre para fins de estudo e portfólio.
