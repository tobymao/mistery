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

      answers = question.answers.map{|answer| answer} << Answer.new

      answers.each do |answer|
        f.fields_for :answers, answer do |a|
          answer_fields(a)
        end
      end

      f.submit
    end
  end

  def answer_fields(a)
    a.label :text, 'Multiple Choice Answer'
    a.text_field :text
    a.label :contact_id, 'Contact Answer'
    a.collection_select :contact_id, scenario.contacts, :id, :name, include_blank: true
    a.label :location_id, 'Location Answer'
    a.collection_select :location_id, scenario.universe.locations, :id, :name, include_blank: true
    a.label :correct, 'Correct'
    a.check_box :correct
  end
end
