class Views::Scenarios::Show < Views::Layouts::Page
  needs :scenario
  needs :play
  needs :owner

  def main
    h1 "Scenario"

    div "Universe: #{scenario.universe.name}"
    div "Name: #{scenario.name}"
    div "Par: #{scenario.par}"
    div "Description:"
    div simple_format scenario.description, class: 'mainText'


    form_for play do |f|
      f.hidden_field :scenario_id, value: scenario.id
      f.button 'Play This Scenario', class: 'mainLink'
    end

    if owner
      p 'Contacts' do
        scenario.contacts.each do |contact|
          div do
            name = ""
            name += contact.location.name + ", " + contact.location.group if contact.location
            name += " - " if contact.name and contact.location
            name += contact.name if contact.name
            text name
          end
        end
      end

      link_to "Edit Scenario", edit_scenario_path(scenario)
    end
  end
end
