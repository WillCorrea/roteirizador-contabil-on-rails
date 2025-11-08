# app/controllers/api/v1/batches_controller.rb
module Api
  module V1
    class BatchesController < ApplicationController
      # POST /api/v1/batches/:id/dispatch
      def dispatch
        batch = IntegrationBatch.find(params[:id])
        DispatchBatchJob.perform_later(batch.id)
        render json: { message: "Dispatch scheduled", batch_id: batch.id }
      rescue => e
        render json: { error: e.message }, status: :not_found
      end
    end
  end
end
