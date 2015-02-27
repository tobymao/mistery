class CreateUniverses < ActiveRecord::Migration
  TABLE = :universes

  def up
    create_table TABLE do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.boolean :published, null: false, default: false
      t.references :user, index: true, null: false

      t.timestamps null: false
    end

    execute "CREATE UNIQUE INDEX index_universes_on_name
                 ON universes USING btree (lower(name));"
  end

  def down
    drop_table TABLE
  end
end
