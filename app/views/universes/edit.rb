class Views::Universes::Edit < Views::Layouts::Page
  needs :universe
  needs :locations_csv

  def main
    h1 "Edit Universe"

    form_tag universe_path(universe), method: 'PUT' do
      fields_for 'universe' do |f|
        f.label :name, 'Universe Name'
        f.text_field :name

        f.label :description, 'Description'
        f.text_area :description

        f.label 'Locations - CSV'
        text_area_tag 'universe[locations_csv]', locations_csv

        f.submit 'Update Universe'
      end
    end
  end
end
