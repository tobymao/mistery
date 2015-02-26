class CreateScenarios < ActiveRecord::Migration
  TABLE = :scenarios

  def up
    create_table TABLE do |t|
      t.string :name
      t.text :description
      t.text :solution
      t.references :universe, index: true, null: false
      t.references :user, index: true, null: false

      t.timestamps null: false
    end

    execute "CREATE UNIQUE INDEX index_scenarios_on_name
                 ON scenarios USING btree (lower(name));"
  end

  def down
    drop_table TABLE
  end
end
