# app/models/ledger_account.rb
class LedgerAccount < ApplicationRecord
  validates :code, :name, presence: true
  # Ex.: 1.1.1.01 — Caixa; 3.1.1.01 — Receita
end
