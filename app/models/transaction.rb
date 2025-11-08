# app/models/transaction.rb
class Transaction < ApplicationRecord
  enum status: { pending: 0, processed: 1, failed: 2 }
  validates :external_id, :product_code, :amount_cents, :occurred_at, presence: true
end
