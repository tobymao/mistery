class CreatePaymentsProducts < ActiveRecord::Migration
  TABLE = :payments_products

  def change
    create_table TABLE do |t|
      t.references :purchasable, polymorphic: true, index: true
      t.integer :price, null: false, default: 0
      t.timestamps null: false
    end
  end
end
