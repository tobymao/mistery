class CreatePaymentsOrderItems < ActiveRecord::Migration
  TABLE = :payments_order_items

  def change
    create_table TABLE do |t|
      t.references :order, index: true, null: false
      t.references :product, index: true, null: false
      t.integer :amount, null: false, default: 0

      t.timestamps null: false
    end
  end
end
