# app/models/integration_batch.rb
class IntegrationBatch < ApplicationRecord
  has_many :journal_entries
  enum status: { open: 0, dispatched: 1, integrated: 2, failed: 3 }
end
