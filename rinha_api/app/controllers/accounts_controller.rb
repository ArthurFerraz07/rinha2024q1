# frozen_string_literal: true

class AccountsController < ApplicationController
  def extract
    @account = ::Account.find(params[:account_id])

    @transactions = @account.transactions.order(created_at: :desc).limit(10)

    render json: {
      "saldo": {
        "total": @account.balance,
        "data_extrato": Time.now,
        "limite": @account.limit
      },
      "ultimas_transacoes": @transactions.map do |transaction|
        {
          "valor": transaction.amount,
          "tipo": transaction.kind,
          "descricao": transaction.description,
          "realizada_em": transaction.created_at
        }
      end
    }
  end
end
