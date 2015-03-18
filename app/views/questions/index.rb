class Views::Questions::Index < Views::Layouts::Page
  needs :scenario
  needs :questions

  def main
    h1 "Questions"

    questions.each do |question|
      div class: 'mainText' do
        link_to(question.text, [scenario, question])
      end
    end
  end
end
