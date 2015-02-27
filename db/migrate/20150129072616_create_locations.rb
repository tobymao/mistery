class CreateLocations < ActiveRecord::Migration
  TABLE = :locations

  def up
    create_table TABLE do |t|
      t.string :name, null:false
      t.string :group
      t.references :universe, null: false

      t.timestamps null: false
    end

    execute "CREATE UNIQUE INDEX index_locations_on_universe_id_and_name
                 ON locations USING btree (universe_id, lower(name));"
  end

  def down
    drop_table TABLE
  end
end
