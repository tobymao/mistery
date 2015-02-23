class CreatePlays < ActiveRecord::Migration
  TABLE = :plays

  def change
    create_table TABLE do |t|
      t.references :user, index: true, null: false
      t.references :scenario, index: true, null: false
      t.bool :active, null: false, defaul: false

      t.timestamps null: false
    end
  end
end
