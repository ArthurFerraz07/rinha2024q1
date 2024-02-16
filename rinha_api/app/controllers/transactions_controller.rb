# frozen_string_literal: true

class TransactionsController < ApplicationController
  def create
    load_account

    use_case = CreateTransactionUseCase.new(
      @account,
      transaction_params[:valor],
      transaction_params[:tipo],
      transaction_params[:descricao]
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

  private

  def load_account
    @account = ::Account.find(params[:account_id])
  end

  def transaction_params
    params.permit(:valor, :tipo, :descricao)
  end
end
