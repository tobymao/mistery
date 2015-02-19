class Views::Contacts::Index < Views::Layouts::Page
  needs :contacts
  needs :scenario

  def main
    h1 "Contacts"

    contacts.each do |contact|
      div do
        link_to(contact.name, [scenario, contact])
      end
    end
  end
end
