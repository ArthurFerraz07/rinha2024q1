# frozen_string_literal: true

# Use case to create a transaction
class CreateTransactionUseCase < BaseUseCase
  attr_accessor :transaction, :account

  def initialize(account, amount, kind, desciption)
    super()
    @account = account
    @amount = amount
    @kind = kind
    @desciption = desciption
  end

  def call
    @account.with_lock do
      @account.reload
      Transaction.transaction do
        create_transaction
        update_account_balance
      end
    end

    true
  rescue ActiveRecord::RecordInvalid => e
    raise BaseException.new(message: e.message, code: 'invalid_transaction')
  rescue BaseException => e
    raise e
  rescue StandardError => e
    raise BaseException.new(message: e.message, code: 'unexpected_error')
  ensure
    finish
  end

  private

  def create_transaction
    @transaction = Transaction.create!(amount: @amount, kind: @kind, description: @desciption, account: @account)
  end

  def update_account_balance
    alpha = @kind == 'd' ? -1 : 1

    @account.balance += @amount * alpha
    @account.save!
  end
end
