class CreatePaymentsNotifications < ActiveRecord::Migration
  TABLE = :payments_notifications

  def change
    create_table TABLE do |t|
      t.references :order, index: true
      t.text :params

      t.timestamps null: false
    end
  end
end
