# frozen_string_literal: true

class Account < ApplicationRecord
  has_many :transactions

  validates :client_id, :balance, :limit, presence: true
  validate :balance_valid?

  private

  def balance_valid?
    errors.add(:base, 'Balance must respect the account limit') if balance < -limit
  end
end
