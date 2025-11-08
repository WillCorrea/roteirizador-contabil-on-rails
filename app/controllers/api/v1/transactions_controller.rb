# app/controllers/api/v1/transactions_controller.rb
module Api
  module V1
    class TransactionsController < ApplicationController
      # POST /api/v1/transactions
      # Body: { transactions: [ {id: "...", product_code: "...", ...}, ... ] }
      def create
        payload = params.require(:transactions)
        result = Ingestion::TransactionIngestor.call(payload)
        render json: { ingested: result[:count], batch_id: result[:batch_id] }, status: :created
      rescue => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end
  end
end
