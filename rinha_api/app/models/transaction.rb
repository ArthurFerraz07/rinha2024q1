# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :account

  enum kind: { c: 0, d: 1 }

  validates :amount, :kind, :description, presence: true
  validates :kind, inclusion: { in: %w[c d] }
  validates :amount, numericality: { greater_than: 0 }
end
