class Views::Questions::Show < Views::Layouts::Page
  needs :scenario
  needs :question

  def main
    h1 "Question"

    p do
      div "Question: #{question.text}"
    end

    link_to("Edit Question", [:edit, scenario, question])
  end
end
