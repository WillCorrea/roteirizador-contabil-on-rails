class CreateIntegrationBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :integration_batches do |t|
      t.integer :status, null: false, default: 0
      t.string :external_protocol
      t.timestamps
    end
  end
end
