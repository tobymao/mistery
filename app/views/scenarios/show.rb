class Views::Scenarios::Show < Views::Layouts::Page
  needs :scenario

  def main
    h1 "Scenario"

    p do
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
  end
end
