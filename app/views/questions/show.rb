class Views::Questions::Show < Views::Layouts::Page
  needs :scenario
  needs :question

  def main
    h1 "Question"

    link_to("Go To Scenario", scenario)
    br
    link_to("Edit Scenario", edit_scenario_path(scenario)) if current_user == scenario.user

    div "Question: #{question.text}", class: 'mainText'

    div "Answers", class: 'mainText' do
      question.answers.each do |answer|
        div "Location: #{answer.location.name}" if answer.location_id
        div "Suspect: #{answer.suspect.name}" if answer.contact_id
        div "Text: #{answer.text}" if answer.text
      end
    end

    link_to("Edit Question", [:edit, scenario, question])
  end
end
