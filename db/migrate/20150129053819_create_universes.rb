class CreateUniverses < ActiveRecord::Migration
  TABLE = :universes
  def change
    create_table TABLE do |t|
      t.string :name, index: {case_sensitive: false, unique: true, null: false}
      t.text :description
      t.references :user, index: true, null: false

      t.timestamps null: false
    end
  end
end
