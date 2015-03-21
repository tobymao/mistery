class Views::Questions::Index < Views::Layouts::Page
  needs :scenario
  needs :new_answer

  def main
    questions = scenario.questions.order(:id)

    form_for scenario do |f|
      table do
        tbody do
          tr do
            th 'Question'
            th 'Type'
            th 'Answer'
            th 'Points'
            th 'Edit'
          end

          questions.each.with_index do |question, index|
            f.fields_for :questions, question do |ff|
              tr do
                td {ff.text_field :text}

                td do
                  ff.collection_select :category, Question.categories, :id, :name, {}, onchange: 'this.form.submit();'
                end

                td do
                  answer = question.answer || Answer.new
                  answer_field(ff, question, answer, true)
                end

                td {ff.number_field :points}

                td do
                  button_tag name: "scenario[questions_attributes][#{index}][_destroy]", value: true, class: 'edit' do
                    'Delete'
                  end

                  button_tag name: 'new_answer', value: question.id, class: 'edit' do
                    'Add Another Answer'
                  end
                end
              end

              question.answers.offset(1).each do |answer|
                additional_answer_row {answer_field(ff, question, answer, false)}
              end

              if new_answer == question.id
                additional_answer_row {answer_field(ff, question, Answer.new, false)}
              end
            end
          end

          tr do
            td {f.submit 'Save', class: 'inlineBlock'}
          end
        end
      end
    end

    form_for scenario do |f|
      table do
        tbody do
          question = Question.new
          f.fields_for :questions, question do |ff|
            tr do
              td do
                ff.text_field :text, placeholder: 'Question Text'
              end
              td do
                ff.collection_select :category, Question.categories, :id, :name, {}, onchange: ''
              end
              td do
                ff.number_field :points, placeholder: 'Points'
              end
              td do
                f.submit 'Add Question'
              end
            end
          end
        end
      end
    end

    h2 'After you choose the type of question and add it, you can add answers.'
    h2 'For location and suspect questions, all options will be presented to the user.'
    h2 'If there is more than one answer, then the user needs to guess all of them in order to score points.'
    h2 'For multiple choice, only the first answer will be correct. All others will be shown as options.'
    h2 'WARNING: If you change the question type. All answers for that questions will be deleted'
    link_to 'Back To Scenario', edit_scenario_path(scenario), class: 'mainLink'
  end

  def additional_answer_row
    tr do
      td
      td
      td do
        yield
      end
      td
    end
  end

  def answer_field(form, question, answer, first)
    if question.suspect?
      form.fields_for :answers, answer do |ff|
        ff.hidden_field :correct, value: true
        ff.collection_select :suspect_id, scenario.suspects, :id, :name, include_blank: true
      end
    elsif question.location?
      form.fields_for :answers, answer do |ff|
        ff.hidden_field :correct, value: true
        ff.collection_select :location_id, scenario.locations.sorted_by_name.visible, :id, :name, include_blank: true
      end
    else
      form.fields_for :answers, answer do |ff|
        ff.hidden_field :correct, value: first
        ff.text_field :text
      end
    end
  end
end
