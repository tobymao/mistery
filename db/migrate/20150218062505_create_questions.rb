class CreateQuestions < ActiveRecord::Migration
  TABLE = :questions

  def change
    create_table TABLE do |t|
      t.text :text, null: false
      t.integer :points, null: false
      t.references :scenario, index: true, null: false

      t.timestamps null: false
    end
  end
end
