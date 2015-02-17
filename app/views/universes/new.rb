class Views::Universes::New < Views::Layouts::Page
  def main
    h1 "Create a universe!"

    form_tag universes_path do
      fields_for 'universe' do |f|
        f.label :name, 'Universe Name'
        f.text_field :name

        f.label :description, 'Description'
        f.text_area :description

        f.label 'Locations - CSV'
        f.text_area :locations_csv

        f.submit 'Finalize Universe'
      end
    end
  end
end
