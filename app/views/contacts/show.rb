class Views::Contacts::Show < Views::Layouts::Page
  needs :scenario
  needs :contact

  def main
    h1 "Contact"

    link_to("Go To Scenario", scenario)
    br
    link_to("Edit Scenario", edit_scenario_path(scenario)) if current_user == scenario.user

    p do
      div "Scenario: #{scenario.name}"
      div "Name #{contact.name}"
      div "Text: #{contact.text}"

      if contact.location
        div "Location Name: #{contact.location.name}"
        div "Location Group: #{contact.location.group}"
      end
    end

    link_to("Edit Contact", [:edit, scenario, contact])
  end
end
