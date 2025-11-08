# app/services/ingestion/transaction_ingestor.rb
module Ingestion
  class TransactionIngestor
    def self.call(array_payload)
      batch = IntegrationBatch.create!(status: :open)
      count = 0

      array_payload.each do |obj|
        tx = Transaction.create!(
          external_id: obj.fetch(:id),
          product_code: obj.fetch(:product_code),
          amount_cents: (obj.fetch(:amount).to_f * 100).to_i,
          occurred_at: obj.fetch(:occurred_at),
          status: :pending,
          raw_payload: obj.to_json
        )
        ProcessTransactionJob.perform_later(tx.id, batch.id)
        count += 1
      end

      { count: count, batch_id: batch.id }
    end
  end
end
