class Views::Users::Scenarios < Views::Layouts::Page
  needs :user

  def main
    h1 "Your Scenarios"

    user.scenarios.each do |scenario|
      widget Views::Shared::Tile.new(
        object: scenario,
        title_widget: Views::Shared::Title.new(name: scenario.name, path: scenario_path(scenario)),
        metadata: nil,
      )
    end
  end
end
