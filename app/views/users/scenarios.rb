class Views::Users::Scenarios < Views::Layouts::Page
  needs :user

  def main
    h1 "Your Scenarios"

    user.scenarios.each do |scenario|
      widget Views::Shared::Tile.new(
        object: scenario,
        title_gen: -> (c) {link_to scenario.name, scenario, class: c},
        metadata: nil,
      )
    end
  end
end
