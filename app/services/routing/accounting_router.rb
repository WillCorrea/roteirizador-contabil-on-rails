# app/services/routing/accounting_router.rb
module Routing
  class AccountingRouter
    # Retorna um array de hashes [{account_code:, amount_cents:, posting_type:, cost_center:, history:}, ...]
    def self.call(transaction)
      # Regras fictícias baseadas no product_code
      case transaction.product_code
      when /SUBS/ # assinatura
        debit  = { account_code: "1.1.1.01", amount_cents: transaction.amount_cents, posting_type: :debit,  cost_center: "100", history: "Receb. assinatura" }
        credit = { account_code: "3.1.1.01", amount_cents: transaction.amount_cents, posting_type: :credit, cost_center: "100", history: "Receita assinatura" }
        [debit, credit]
      when /SKU/
        debit  = { account_code: "1.1.1.01", amount_cents: transaction.amount_cents, posting_type: :debit,  cost_center: "200", history: "Receb. venda SKU" }
        credit = { account_code: "3.1.1.02", amount_cents: transaction.amount_cents, posting_type: :credit, cost_center: "200", history: "Receita produto" }
        [debit, credit]
      else
        raise "Regra contábil não mapeada para product_code=#{transaction.product_code}"
      end
    end
  end
end
