class Views::Users::Scenarios < Views::Layouts::Page
  needs :user

  def main
    h1 "Your Scenarios"

    user.scenarios.each do |scenario|
      widget Views::Shared::Tile.new(object: scenario, link: scenario_path(scenario))
    end
  end
end
