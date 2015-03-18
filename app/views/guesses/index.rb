class Views::Guesses::Index < Views::Layouts::Page
  needs :play
  needs :current_path

  def main
    h1 "Guess a question!"

    guesses = Guess.where(play: play).includes(:question, :contact, :location, :answer)
    answered_questions = guesses.map(&:question)
    unanswered_questions = play.scenario.questions - answered_questions

    unanswered_questions.each do |question|
      div class: 'mainText' do
        link_to question.text, new_play_guess_path(play, question: question), class: 'mainLink'
      end
    end

    h1 "Answered Questions"

    guesses.each do |guess|
      div class: 'mainText' do
        label guess.question.text
        label guess.suspect.name if guess.suspect_id
        label guess.location.name if guess.location_id
        label guess.answer.text if guess.answer_id
      end
    end

    form_tag finish_play_path(play) do
      button_tag 'Finish Game'
    end
  end

  def side_bar
    widget Views::Plays::SideBar.new(play: play, current_path: current_path)
  end
end
