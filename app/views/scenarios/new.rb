class Views::Scenarios::New < Views::Layouts::Page
  needs :universes
  needs :scenario

  def main
    h1 "Create a scenario!"

    form_for scenario do |f|
      f.label :universe, 'Select a Universe'
      br
      f.collection_select :universe_id, universes, :id, :name
      br
      br

      f.label :name, 'Name'
      f.text_field :name

      f.label :text, 'Description'
      f.text_area :text

      f.submit
    end
  end
end
