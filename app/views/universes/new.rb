class Views::Universes::New < Views::Layouts::Page
  def main
    h1 "Create a universe!"

    form_tag universes_path do
      fields_for 'universe' do |f|
        f.label :name, 'Universe Name'
        f.text_field :name

        f.label :description, 'Description'
        f.text_area :description, placeholder: 'This will show up on the Universe page'

        f.label 'Locations - CSV'
        f.text_area :locations_csv, placeholder: 'Locations that can be visited, separated into groups
Location 1, Group 1
Location 2, Group 1
Location 3, Group 2'

        f.label :publish, 'Published (check to make public)'
        f.check_box :published

        f.submit 'Finalize Universe'
      end
    end
  end

end
