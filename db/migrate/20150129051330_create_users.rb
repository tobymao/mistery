class CreateUsers < ActiveRecord::Migration
  TABLE = :users

  def change
    create_table TABLE do |t|
      t.string  :email
      t.string  :name
      t.string  :password
      t.boolean :guest, null: false, default: false

      t.timestamps null: false
    end

    add_index(TABLE, :email, unique:true)
  end
end
