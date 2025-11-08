class CreateProcessingLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :processing_logs do |t|
      t.string :context
      t.string :reference_id
      t.string :level
      t.text :message
      t.timestamps
    end
    add_index :processing_logs, :context
  end
end
