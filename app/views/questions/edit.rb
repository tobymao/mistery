class Views::Questions::Edit < Views::Layouts::Page
  needs :scenario
  needs :question

  def main
    h1 'Edit Question'

    form_for [scenario, question] do |f|
      f.label :text, 'Text'
      f.text_area :text

      f.label :points, 'Points'
      f.text_field :points

      question.answers << Answer.new

      question.answers.each do |answer|
        f.fields_for :answers, answer do |f|
          answer_fields(f, answer)
        end
      end

      f.submit
    end
  end

  def answer_fields(form, answer)
    contacts = scenario.contacts.named

    form.label :text, 'Multiple Choice Answer'
    form.text_field :text
    form.label :contact_id, 'Contact Answer'
    form.collection_select :contact_id, contacts, :id, :name, include_blank: true
    form.label :location_id, 'Location Answer'
    form.collection_select :location_id, scenario.universe.locations.visible, :id, :name, include_blank: true
    form.label :correct, 'Correct'
    form.check_box :correct
    form.hidden_field :id, value: answer.id
  end
end
