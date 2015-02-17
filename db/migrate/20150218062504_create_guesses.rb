class CreateGuesses < ActiveRecord::Migration
  TABLE = :guesses

  def change
    create_table TABLE do |t|
      t.text :text
      t.references :play, index: true, null: false
      t.references :question, index: true, null: false
      t.references :answer

      t.timestamps null: false
    end
  end
end
