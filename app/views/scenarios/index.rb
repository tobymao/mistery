class Views::Scenarios::Index < Views::Layouts::Page
  needs :scenarios
  def main
    h1 "Scenarios"

    scenarios.each do |scenario|
      div do
        link_to(scenario.name, scenario)
      end
    end
  end
end
