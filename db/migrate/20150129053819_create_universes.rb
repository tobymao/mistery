class CreateUniverses < ActiveRecord::Migration
  TABLE = :universes
  def change
    create_table TABLE do |t|
      t.string :name, null: false
      t.text :description
      t.references :user, index: true, null: false

      t.timestamps null: false
    end

    add_index(TABLE, :name, unique:true)
  end
end
