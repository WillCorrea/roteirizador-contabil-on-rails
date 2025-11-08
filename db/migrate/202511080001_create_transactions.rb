class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :external_id, null: false
      t.string :product_code, null: false
      t.integer :amount_cents, null: false
      t.datetime :occurred_at, null: false
      t.integer :status, null: false, default: 0
      t.jsonb :raw_payload
      t.timestamps
    end
    add_index :transactions, :external_id, unique: true
    add_index :transactions, :occurred_at
  end
end
