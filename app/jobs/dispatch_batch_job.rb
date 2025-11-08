# app/jobs/dispatch_batch_job.rb
class DispatchBatchJob < ApplicationJob
  queue_as :default

  def perform(batch_id)
    batch = IntegrationBatch.find(batch_id)
    entries = batch.journal_entries

    protocol = Integration::SapClient.dispatch(batch, entries)
    batch.update!(status: :integrated, external_protocol: protocol)
  rescue => e
    batch.update!(status: :failed) if batch
    ProcessingLog.create!(context: "DispatchBatchJob", reference_id: batch_id, level: "error", message: e.message)
    raise
  end
end
