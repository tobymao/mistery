class CreateScenarios < ActiveRecord::Migration
  TABLE = :scenarios

  def change
    create_table TABLE do |t|
      t.string :name, index: {case_sensitive: false, unique: true, null: false}
      t.text :description
      t.text :solution
      t.references :universe, index: true, null: false
      t.references :user, index: true, null: false

      t.timestamps null: false
    end
  end
end
