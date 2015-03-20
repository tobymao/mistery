class AddCategoryToQuestions < ActiveRecord::Migration
  TABLE = :questions

  def change
    add_column TABLE, :category, :integer, null: false, default: Question::CATEGORY_SUSPECT

    Question.all.each do |question|
      if !!question.answers.first.try(:text)
        question.category = Question::CATEGORY_MULTIPLE_CHOICE
      elsif !!question.answers.first.try(:location)
        question.category = Question::CATEGORY_LOCATION
      end

      question.save
    end
  end
end
