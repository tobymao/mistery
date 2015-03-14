class Views::Contacts::New < Views::Layouts::Page
  needs :scenario
  needs :contact
  needs :locations

  def main
    h1 "Create a contact!"

    form_for [scenario, contact] do |f|
      f.label :name, 'Name'
      f.text_field :name

      f.label :location, 'Select a location'
      f.collection_select :location_id, locations, :id, :name, include_blank: true
      br
      br

      f.label :text, 'Text (story)'
      f.text_area :text, placeholder: 'You can input a Name and/or Select a Location. The name is only used for the list of suspects when answering questions.

This is the text that will appear when the player visits the selected location. If you do not choose a location, there will be no way to see the text (the contact will only be included for answering questions).'

      f.submit
    end
  end
end
