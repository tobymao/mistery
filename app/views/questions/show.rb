class Views::Questions::Show < Views::Layouts::Page
  needs :scenario
  needs :question

  def main
    h1 "Question"

    link_to("Go To Scenario", scenario)
    br
    link_to("Edit Scenario", edit_scenario_path(scenario)) if current_user == scenario.user

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
