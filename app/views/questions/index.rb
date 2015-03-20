class Views::Questions::Index < Views::Layouts::Page
  needs :scenario
  needs :questions

  def main
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

                  if question.suspect?
                    ff.fields_for :answers, answer do |fff|
                      fff.collection_select :suspect_id, scenario.suspects, :id, :name
                    end
                  elsif question.location?
                    ff.fields_for :answers, answer do |fff|
                      fff.collection_select :location_id, scenario.locations.sorted_by_name.visible, :id, :name
                    end
                  end
                end

                td {ff.number_field :points}

                td do
                  button_tag name: "scenario[questions_attributes][#{index}][_destroy]", value: true, class: 'edit' do
                    'Delete'
                  end
                end
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
          f.fields_for :questions, Question.new do |ff|
            tr do
              td do
                ff.text_field :text
              end
              td do
                ff.collection_select :category, Question.categories, :id, :name, {}, onchange: ''
              end
              td do
                ff.text_field :answer
              end
              td do
                ff.number_field :points
              end
              td do
                f.submit 'Add Question'
              end
            end
          end
        end
      end
    end

    h2 "WARNING: If you change the question type. All answers will be deleted."
  end
end
