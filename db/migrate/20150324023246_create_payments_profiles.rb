class CreatePaymentsProfiles < ActiveRecord::Migration
  TABLE = :payments_profiles

  def change
    create_table TABLE do |t|
      t.references :user, index: true, null: false, unique: true
      t.string :email, null: false
      t.boolean :validated, null: false, default: false

      t.timestamps null: false
    end
  end
end
