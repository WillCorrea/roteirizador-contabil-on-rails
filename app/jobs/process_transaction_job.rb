# app/jobs/process_transaction_job.rb
class ProcessTransactionJob < ApplicationJob
  queue_as :default

  def perform(transaction_id, batch_id)
    tx = Transaction.find(transaction_id)
    entries = Routing::AccountingRouter.call(tx)

    entries.each do |e|
      JournalEntry.create!(
        transaction_id: tx.id,
        integration_batch_id: batch_id,
        account_code: e[:account_code],
        amount_cents: e[:amount_cents],
        posting_type: JournalEntry.posting_types[e[:posting_type]],
        cost_center: e[:cost_center],
        history: e[:history]
      )
    end

    tx.processed!
  rescue => e
    tx.failed! if tx
    ProcessingLog.create!(context: "ProcessTransactionJob", reference_id: transaction_id, level: "error", message: e.message)
    raise
  end
end
