class Views::Questions::Edit < Views::Layouts::Page
  needs :scenario
  needs :question

  def main
    h1 'Edit Question'

    form_for [scenario, question] do |f|
      f.label :text, 'Text'
      f.text_area :text

      f.label :multiple_choice, 'Multiple Choice'
      f.check_box :multiple_choice

      f.submit
    end
  end
end
