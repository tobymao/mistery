class CreateActions < ActiveRecord::Migration
  TABLE = :actions

  def change
    create_table TABLE do |t|
      t.references :play, index: true, null: false
      t.references :location, index: true, null: false

      t.timestamps null: false
    end
  end
end
