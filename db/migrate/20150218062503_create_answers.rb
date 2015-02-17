class CreateAnswers < ActiveRecord::Migration
  TABLE = :answers

  def change
    create_table TABLE do |t|
      t.text :text, null: false
      t.integer :points, default: 0, null: false
      t.references :question, null: false

      t.timestamps null: false
    end

    add_index(TABLE, [:question_id, :text], unique:true)
  end
end
