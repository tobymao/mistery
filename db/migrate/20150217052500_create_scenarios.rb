class CreateScenarios < ActiveRecord::Migration
  TABLE = :scenarios

  def change
    create_table TABLE do |t|
      t.string :name, null: false
      t.text :description
      t.text :solution
      t.references :universe, null: false
      t.references :user, index: true, null: false

      t.timestamps null: false
    end

    add_index(TABLE, [:universe_id, :name], unique:true)
  end
end
