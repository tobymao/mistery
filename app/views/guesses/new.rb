class Views::Guesses::New < Views::Layouts::Page
  needs :play
  needs :guess

  def main
    question = guess.question

    h1 "Make the guess"

    div do
      text "Question: #{question.text}"
      br
      text "Points: #{question.points}"
    end

    form_for [play, guess] do |f|
      f.hidden_field :question_id, value: question.id

      if question.multiple_choice?
        question.answers.each do |answer|
          div do
            f.radio_button :answer_id, answer.id
            f.label :answer_id, answer.text
          end
        end
      end

      if question.contact?
        f.label "Choose a contact"
        f.collection_select :contact_id, play.scenario.contacts, :id, :name
      end

      if question.location?
        f.label "Choose a location"
        f.collection_select :location_id, play.scenario.locations, :id, :name
      end

      f.submit 'Make Guess!'
    end
  end

  def side_bar
    widget Views::Plays::SideBar.new(play: play)
  end
end
