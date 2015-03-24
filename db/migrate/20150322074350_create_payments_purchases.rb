class CreatePaymentsPurchases < ActiveRecord::Migration
  TABLE = :payments_purchases

  def change
    create_table TABLE do |t|
      t.references :user, index: true, null: false
      t.references :purchased, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
