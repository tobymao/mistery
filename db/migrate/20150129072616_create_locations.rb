class CreateLocations < ActiveRecord::Migration
  TABLE = :locations

  def change
    create_table TABLE do |t|
      t.string :address, null: false
      t.string :name, null: false
      t.references :universe, null: false

      t.timestamps null: false
    end

    add_index(TABLE, [:universe_id, :address], unique: true)
  end
end
