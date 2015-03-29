class Views::Plays::Result < Views::Layouts::Page
  needs :play

  def main
    h1 "Finished Game"

    div 'Solution:' do
      text simple_format play.scenario.solution, class: 'mainText'
    end

    div "Score #{play.points}"

    guesses = Guess
      .includes({question: {answers: [:location, :suspect]}}, :answer, :location, :suspect)
      .where(play: play)

    guesses.each do |guess|
      br
      div class: 'mainText' do
        text "Question: #{guess.question.text}"
        br
        text "Your answer: #{guess.guess_string}"
        br
        if guess.points
          text "You earned #{guess.question.points} points"
        else
          text "Correct answer: #{guess.question.answer_string}"
        end
      end
    end
  end
end
