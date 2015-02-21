class Views::Scenarios::New < Views::Layouts::Page
  needs :universes
  needs :scenario

  def main
    h1 "Create a scenario!"

    form_for scenario do |f|
      f.label :universe, 'Select a Universe'
      f.collection_select :universe_id, universes, :id, :name

      f.label :name, 'Name'
      f.text_field :name

      f.label :description, 'Description'
      f.text_area :description

      f.label :solution, 'Solution'
      f.text_area :solution

      f.submit
    end
  end
end
