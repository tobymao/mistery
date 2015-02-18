class Views::Scenarios::Edit < Views::Layouts::Page
  needs :scenario

  def main
    h1 "Edit a scenario!"

    form_for scenario do |f|
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
