class Views::Questions::New < Views::Layouts::Page
  needs :scenario
  needs :question

  def main
    h1 "Create a question!"

    form_for [scenario, question] do |f|
      f.label :text, 'Text'
      f.text_area :text, placeholder: 'Input questions for the player to score at the end of the game. The question can be multiple choice, or have a contacts or location answer.

If the question is multiple choice, you will insert multiple answers and check the answer that is correct. If the answer is a contact or location, select the correct contact or location and the player will be able to select from the entire list.'

      f.label :points, 'Points'
      f.text_field :points

      f.submit
    end
  end
end
