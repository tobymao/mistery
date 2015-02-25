class CreateActions < ActiveRecord::Migration
  TABLE = :actions

  def change
    create_table TABLE do |t|
      t.references :play, null: false
      t.references :location, null: false

      t.timestamps null: false
    end

    add_index(TABLE, [:play_id, :location_id], unique:true)
  end
end
