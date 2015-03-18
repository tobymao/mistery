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

      f.label :par, 'Par'
      f.number_field :par

      f.label :published, 'Published'
      f.check_box :published

      f.submit
    end

    #p 'Contacts' do
    #  scenario.contacts.each do |contact|
    #    div do
    #      name = ""
    #      name += contact.location.name if contact.location
    #      link_to(name, [scenario, contact])
    #    end
    #  end

    #  br
    #  link_to('Add Contact', new_scenario_contact_path(scenario))
    #end

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
end
