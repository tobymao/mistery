class Views::Contacts::Index < Views::Layouts::Page
  needs :contacts
  needs :scenario

  def main
    h1 "Contacts"

    contacts.each do |contact|
      div class: 'mainText' do
        link_to(contact.text, [scenario, contact])
      end
    end
  end
end
