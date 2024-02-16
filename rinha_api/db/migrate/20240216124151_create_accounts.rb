class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.integer :client_id
      t.integer :balance, default: 0, null: false
      t.integer :limit, default: 0, null: false

      t.index :client_id, unique: true

      t.timestamps
    end
  end
end
