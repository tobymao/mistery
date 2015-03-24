class CreatePaymentsOrders < ActiveRecord::Migration
  TABLE = :payments_orders

  def change
    create_table TABLE do |t|
      t.references :user, index: true, null: false
      t.string :ip_address, null: false
      t.string :status, null: false
      t.string :transaction_id, index: true
      t.integer :amount, null: false, default: 0

      t.timestamps null: false
    end
  end
end
