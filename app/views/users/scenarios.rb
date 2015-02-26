class Views::Users::Scenarios < Views::Layouts::Page
  needs :user

  def main
    h1 "Your scenarios"

    user.scenarios.each do |scenario|
      div do
        link_to(scenario.name, scenario)
      end
    end
  end
end
