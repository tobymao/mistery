class CreatePaymentsPurchases < ActiveRecord::Migration
  TABLE = :payments_purchases

  def change
    create_table TABLE do |t|
      t.references :user, null: false
      t.references :purchased, polymorphic: true, index: true, null: false
      t.timestamps null: false
    end

    add_index(TABLE, [:user_id, :purchased_id, :purchased_type], unique:true, name: 'idx_user_id_purchased_id_purchased_type')
  end
end
