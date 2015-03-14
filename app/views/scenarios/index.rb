class Views::Scenarios::Index < Views::Layouts::Page
  needs :scenarios

  def main
    h1 "Scenarios"

    scenarios.each do |scenario|
      widget Views::Shared::Tile.new(
        object: scenario,
        title_widget: Views::Shared::Title.new(name: scenario.name, path: scenario_path(scenario)),
        metadata: nil,
      )
    end
  end
end
