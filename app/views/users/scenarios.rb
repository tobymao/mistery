class Views::Users::Scenarios < Views::Layouts::Page
  needs :user

  def main
    div class: 'tileCollection' do
      user.scenarios.each do |scenario|
        widget Views::Shared::Tile.new(
          object: scenario,
          title_gen: -> (c) {link_to scenario.name, scenario, class: c},
          metadata: nil,
        )
      end
    end
  end
end
