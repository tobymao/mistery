class CreateUsers < ActiveRecord::Migration
  TABLE = :users

  def change
    create_table TABLE do |t|
      t.string  :login, null: false
      t.string  :email
      t.string  :password
      t.boolean :guest, null: false, default: false

      t.timestamps null: false
    end

    add_index(TABLE, :login, unique:true)
    add_index(TABLE, :email, unique:true)
  end
end
