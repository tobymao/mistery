class CreatePlays < ActiveRecord::Migration
  TABLE = :plays

  def change
    create_table TABLE do |t|
      t.boolean    :active, null: false, default: false
      t.integer    :points
      t.references :user, index: true, null: false
      t.references :scenario, index: true, null: false

      t.timestamps null: false
    end
  end
end
