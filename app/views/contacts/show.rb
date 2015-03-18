class Views::Contacts::Show < Views::Layouts::Page
  needs :scenario
  needs :contact

  def main
    h1 "Contact"

    p do
      div "Scenario: #{scenario.name}"
      div "Name: #{contact.name}"
      div 'Text:', class: 'mainText' do
        text simple_format contact.text
      end

      if contact.location
        div "Location Name: #{contact.location.name}", class: 'mainText'
        div "Location Group: #{contact.location.group}", class: 'mainText'
      end
    end

    link_to("Edit Contact", [:edit, scenario, contact])
    br
    link_to("Go To Scenario", scenario)
    br
    link_to("Edit Scenario", edit_scenario_path(scenario))
    br
    link_to('Add Another Contact', new_scenario_contact_path(scenario))
  end
end
