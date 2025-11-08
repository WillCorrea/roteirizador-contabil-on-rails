# app/models/journal_entry.rb
class JournalEntry < ApplicationRecord
  belongs_to :transaction
  belongs_to :integration_batch, optional: true

  enum posting_type: { debit: 0, credit: 1 }
  validates :account_code, :amount_cents, :posting_type, presence: true
end
