class CreatePasswordResets < ActiveRecord::Migration
  TABLE = :password_resets

  def change
    create_table TABLE do |t|
      t.references :user, index: true, null: false
      t.string :token, null: false
      t.boolean :used, null: false, default: false

      t.timestamps null: false
    end
  end
end
