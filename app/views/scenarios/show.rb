class Views::Scenarios::Show < Views::Layouts::Page
  needs :scenario
  needs :can_edit

  def main
    h1 "Scenario"

    p do
      div "Universe: #{scenario.universe.name}"
      div "Name: #{scenario.name}"
      div "Description: #{scenario.description}"
    end

    p 'Contacts' do
      scenario.contacts.each do |contact|
        div do
          label "Name: #{contact.name}"
          label "Address: #{contact.location.address}"
        end
      end
    end

    if can_edit
      link_to "Edit Scenario", edit_scenario_path(scenario)
    end
  end
end
