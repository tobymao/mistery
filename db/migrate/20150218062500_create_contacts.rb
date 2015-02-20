class CreateContacts < ActiveRecord::Migration
  TABLE = :contacts

  def change
    create_table TABLE do |t|
      t.string :name
      t.text :text
      t.references :scenario, null: false
      t.references :location

      t.timestamps null: false
    end

    add_index(TABLE, [:scenario_id, :location_id], unique:true)
  end
end
