class Views::Questions::Show < Views::Layouts::Page
  needs :scenario
  needs :question

  def main
    h1 "Question"

    link_to("Back To Scenario", scenario)

    div "Question: #{question.text}"

    div "Answers" do
      question.answers.each do |answer|
        div "Location: #{answer.location.name}" if answer.location
        div "Contact: #{answer.contact.name}" if answer.contact
        div "Text: #{answer.text}" if answer.text
      end
    end

    link_to("Edit Question", [:edit, scenario, question])
  end
end
