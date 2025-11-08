# app/services/integration/sap_client.rb
module Integration
  class SapClient
    def self.dispatch(batch, entries)
      # Mock: envia lote e retorna protocolo fictício
      sleep(0.1) # simula rede
      "SAP-PROT-#{batch.id}-#{Time.now.to_i}"
    end
  end
end
