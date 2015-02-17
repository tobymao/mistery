class CreateContacts < ActiveRecord::Migration
  TABLE = :contacts

  def change
    create_table TABLE do |t|
      t.string :name, null: false
      t.text :text
      t.references :scenario, index: true, null: false
      t.references :location

      t.timestamps null: false
    end
  end
end
