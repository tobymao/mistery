class Views::Scenarios::Index < Views::Layouts::Page
  needs :scenarios

  def main
    h1 "Scenarios"

    scenarios.each do |scenario|
      widget Views::Shared::Tile.new(object: scenario, link: scenario_path(scenario))
    end
  end
end
