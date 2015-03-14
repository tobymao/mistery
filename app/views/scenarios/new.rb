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
      f.text_area :description, placeholder: 'This is the introduction text to your mistery story'

      f.label :solution, 'Solution'
      f.text_area :solution, placeholder: 'This is the solution text at the end of your mistery story'

      f.label :par, 'Par # of Locations Visited'
      f.number_field :par

      f.label :published, 'Published (check to make public)'
      f.check_box :published

      f.submit
    end
  end
end
