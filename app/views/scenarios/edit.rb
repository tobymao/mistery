class Views::Scenarios::Edit < Views::Layouts::Page
  needs :scenario
  needs :selected_location

  def main
    contacts = {}
    scenario.contacts.each {|contact| contacts[contact.location.id] = contact}

    h1 'Scenario Editor'

    form_for scenario do |f|
      div class: 'formContainer' do
        div class: 'formBlock' do
          f.label :name, 'Name'
          f.text_field :name

          f.label :published, 'Published'
          f.check_box :published

          f.label :description, 'Description'
          f.text_area :description

          f.label :solution, 'Solution'
          f.text_area :solution

          f.label :par, 'Par'
          f.number_field :par

          div class: 'formBlock' do
            h1 'Suspects'

            scenario.suspects.each.with_index do |suspect, index|
              f.fields_for :suspects, suspect do |ff|
                ff.text_field :name, class: 'inlineBlock'
                button_tag name: "scenario[suspects_attributes][#{index}][_destroy]", value: true, class: 'edit' do
                  'Delete'
                end
                br
              end
            end

            f.fields_for :suspects, Suspect.new do |ff|
              ff.text_field :name, placeholder: 'Add New Suspect'
            end

            f.submit 'Update Suspects'
          end
        end

        div class: 'formBlock' do
          div do
            selected_contact = contacts[selected_location.id] || Contact.new(scenario: scenario)

            h1 selected_location.name

            f.fields_for :contacts, selected_contact do |ff|
              ff.hidden_field :location_id, value: selected_location.id
              ff.text_area :text, value: selected_contact.text, class: 'textAreaBig'
            end

            button 'Save Location', selected_location.id
          end if selected_location

          table do
            tbody do
              tr do
                th 'Location'
                th 'Group'
                th 'Text Preview'
                th 'Action'
              end

              scenario.locations.each do |location|
                contact = contacts[location.id]

                tr do
                  td location.name
                  td location.group
                  td class: 'textPreview' do
                    text contact ? truncate(contact.text, length: 100) : ''
                  end
                  td do
                    button contact ? 'Edit Text' : 'Add Text', location.id
                  end
                end
              end
            end
          end
        end

      end

      f.submit
    end


    p 'Questions' do
      scenario.questions.each do |question|
        div do
          link_to(question.text, [scenario, question])
        end
      end

      br
      link_to('Add Question', new_scenario_question_path(scenario))
    end
  end

  def button(text, id)
    button_tag name: 'location', value: id, class: 'edit' do
      text
    end
  end
end
