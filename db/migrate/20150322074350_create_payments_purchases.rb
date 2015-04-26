class CreatePaymentsPurchases < ActiveRecord::Migration
  TABLE = :payments_purchases

  def change
    create_table TABLE do |t|
      t.references :user, index: true, null: false
      t.references :purchased, polymorphic: true, index: true
      t.timestamps null: false
    end

    add_index(TABLE, [:user_id, :purchased_id, :purchased_type], unique:true, name: 'index_purchases_on_u_id_p_id_p_type')
  end
end
