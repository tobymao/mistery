class CreateAnswers < ActiveRecord::Migration
  TABLE = :answers

  def change
    create_table TABLE do |t|
      t.references :question, index: true, null: false
      t.boolean    :correct, null: false, default: true
      t.references :location
      t.references :contact
      t.text       :text

      t.timestamps null: false
    end

    add_index(TABLE, [:question_id, :location_id], unique:true)
    add_index(TABLE, [:question_id, :contact_id], unique:true)
    add_index(TABLE, [:question_id, :text], unique:true)
  end
end
