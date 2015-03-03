class Views::Guesses::Index < Views::Layouts::Page
  needs :play

  def main
    h1 "Guess a question!"

    guesses = Guess.where(play: play).includes(:question, :contact, :location, :answer)
    answered_questions = guesses.map(&:question)
    unanswered_questions = play.scenario.questions - answered_questions

    unanswered_questions.each do |question|
      div do
        link_to question.text, new_play_guess_path(play, question: question), class: 'mainLink'
      end
    end

    h1 "Answered Questions"

    guesses.each do |guess|
      div do
        label guess.question.text
        label guess.contact.name if guess.contact
        label guess.location.name if guess.location
        label guess.answer.text if guess.answer
      end
    end

    form_tag finish_play_path(play) do
      button_tag 'Finish Game'
    end
  end
end
