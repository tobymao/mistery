class Views::Contacts::Index < Views::Layouts::Page
  needs :contacts

  def main
    h1 "Contacts"

    contacts.each do |contact|
      div do
        link_to(contact.name, contact)
      end
    end
  end
end
