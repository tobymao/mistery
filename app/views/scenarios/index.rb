class Views::Scenarios::Index < Views::Layouts::Page
  needs :scenarios
  needs :start
  needs :count

  def main
    div class: 'tileCollection' do
      scenarios.each do |scenario|
        widget Views::Shared::Tile.new(
          object: scenario,
          title_gen: -> (c) {link_to scenario.name, scenario, class: c},
          metadata: nil,
        )
      end
    end

    widget Views::Shared::Pager.new(
      start: start,
      count: count,
      path_gen: -> (index) {scenarios_path(start: index)}
    )
  end
end
