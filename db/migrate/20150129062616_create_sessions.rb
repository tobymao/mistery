class CreateSessions < ActiveRecord::Migration
  TABLE = :sessions

  def change
    create_table TABLE do |t|
      t.string :token, null: false
      t.string :ip_address, null: false
      t.references :user, index: true, null: false

      t.timestamps null: false
    end

    add_index(TABLE, :token, unique:true)
  end
end
