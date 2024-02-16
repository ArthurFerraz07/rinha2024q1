# frozen_string_literal: true

class TransactionsController < ApplicationController
  def create
    @account = Account.find_by!(client_id: params[:account_id])

    use_case = CreateTransactionUseCase.new(
      @account,
      params[:valor],
      params[:tipo],
      params[:descricao]
    )
    use_case.call

    render json: {
      "limite": @account.limit,
      "saldo": @account.balance
    }
  rescue BaseException => e
    render json: { code: e.code, error: e.message }, status: :unprocessable_entity
  rescue ActiveRecord::RecordNotFound => e
    render json: { code: 'account_not_found', error: e.message }, status: :not_found
  rescue StandardError => e
    render json: { code: 'unexpected_error', error: e.message }, status: :unprocessable_entity
  end
end
