class CreateJournalEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :journal_entries do |t|
      t.references :transaction, null: false, foreign_key: true
      t.references :integration_batch, foreign_key: true
      t.string :account_code, null: false
      t.integer :amount_cents, null: false
      t.integer :posting_type, null: false
      t.string :cost_center
      t.string :history
      t.timestamps
    end
    add_index :journal_entries, :account_code
  end
end
