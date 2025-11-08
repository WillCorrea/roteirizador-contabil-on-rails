# db/schema.rb (ilustrativo)
ActiveRecord::Schema.define(version: 2025_11_08_000001) do
  create_table "transactions", force: :cascade do |t|
    t.string   "external_id", null: false
    t.string   "product_code", null: false
    t.integer  "amount_cents", null: false
    t.datetime "occurred_at",  null: false
    t.integer  "status", default: 0, null: false
    t.jsonb    "raw_payload"
    t.timestamps
  end

  create_table "journal_entries", force: :cascade do |t|
    t.integer  "transaction_id", null: false
    t.integer  "integration_batch_id"
    t.string   "account_code", null: false
    t.integer  "amount_cents", null: false
    t.integer  "posting_type", null: false
    t.string   "cost_center"
    t.string   "history"
    t.timestamps
  end

  create_table "ledger_accounts", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.timestamps
  end

  create_table "integration_batches", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string  "external_protocol"
    t.timestamps
  end

  create_table "processing_logs", force: :cascade do |t|
    t.string  "context"
    t.string  "reference_id"
    t.string  "level"
    t.text    "message"
    t.timestamps
  end
end
