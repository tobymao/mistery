class CreateUsers < ActiveRecord::Migration
  TABLE = :users

  def change
    create_table TABLE do |t|
      t.string :login, null: false
      t.string :email, null: false
      t.string :fname
      t.string :lname
      t.string :password, null: false

      t.timestamps null: false
    end

    add_index(TABLE, :login, unique:true)
    add_index(TABLE, :email, unique:true)
  end
end
