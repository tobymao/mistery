class Views::Guesses::Index < Views::Layouts::Page
  needs :play
  needs :current_path

  def main

    guesses = Guess.where(play: play).includes(:question, :suspect, :location, :answer)
    answered_questions = guesses.map(&:question)
    unanswered_questions = play.scenario.questions - answered_questions

    form_for play do |f|
      table do
        tbody do
          tr do
            th 'Question'
            th 'Answer'
          end

          play.scenario.questions.each do |question|
            guess = Guess.new

            f.fields_for :guesses, guess do |ff|
              tr do
                ff.hidden_field :question_id, value: question.id
                td question.text

                td do
                  if question.suspect?
                    ff.collection_select :suspect_id, play.scenario.suspects, :id, :name
                  elsif question.location?
                    ff.collection_select :location_id, play.scenario.locatons, :id, :name
                  else
                    ff.collection_select :answer_id, question.answers, :id, :text
                  end
                end
              end
            end
          end

          tr do
            td {f.button 'Make Guess', class: 'edit'}
          end
        end
      end
    end
  end

  def side_bar
    widget Views::Plays::SideBar.new(play: play, current_path: current_path)
  end
end
