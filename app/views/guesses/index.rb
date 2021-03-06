class Views::Guesses::Index < Views::Layouts::Page
  needs :play
  needs :current_path

  def main
    guesses = Guess
      .includes(:question, :answer, :location, :suspect)
      .where(play: play)

    questions = Question.includes(:answers).where(scenario: play.scenario).order(:id)

    ids = play
      .scenario
      .contacts
      .reject{|c| c.text.blank?}
      .map{|c| c.location_id}
      .compact

    suspects = play.scenario.suspects.order(:name)
    locations = play.scenario.locations.order(:name).reject do |location|
      location.hidden && !ids.include?(location.id)
    end

    form_for play do |f|
      table do
        tbody do
          tr do
            th 'Question'
            th 'Points'
            th 'Answer'
          end

          questions.each do |question|
            guess = guesses.find {|guess| guess.question == question} || Guess.new

            f.fields_for :guesses, guess do |ff|
              tr do
                ff.hidden_field :question_id, value: question.id
                td question.text
                td question.points

                td do
                  if question.suspect?
                    ff.collection_select :suspect_id, suspects, :id, :name
                  elsif question.location?
                    ff.collection_select :location_id, locations, :id, :name
                  else
                    ff.collection_select :answer_id, question.answers.shuffle, :id, :text
                  end
                end
              end
            end
          end

          tr do
            td {f.button 'Finish Game', class: 'edit'}
          end
        end
      end
    end
  end

  def side_bar
    widget Views::Plays::SideBar.new(play: play, current_path: current_path)
  end
end
