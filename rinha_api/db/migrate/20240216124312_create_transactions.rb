class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :account_id, null: false, index: true
      t.integer :amount, null: false
      t.integer :kind, null: false
      t.string :description, null: false, limit: 10

      t.timestamps
    end
  end
end
