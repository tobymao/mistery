class CreateUsers < ActiveRecord::Migration
  TABLE = :users

  def change
    create_table TABLE do |t|
      t.string  :login, index: {case_sensitive: false, unique: true}
      t.string  :email, index: {case_sensitive: false, unique: true}
      t.string  :password
      t.boolean :guest, null: false, default: false
      t.boolean :admin, null: false, default: false

      t.timestamps null: false
    end
  end
end
