class Views::Landing::Index < Views::Layouts::Page
  needs :scenarios_new
  needs :universes_new
  needs :scenarios_top
  needs :scenario_featured

  def main
    featured_scenario
    top_scenarios
    new_scenarios
    new_universes
  end

  def featured_scenario
    widget Views::Landing::FeaturedScenario.new(scenario: scenario_featured)
  end

  def top_scenarios
    div class: 'tileCollection' do
      div "Trending Scenarios", class: 'tileHeader'
      scenarios_top.each do |scenario|
        widget Views::Shared::Tile.new(
          object: scenario,
          title_gen: -> (c) {link_to scenario.name, scenario, class: c},
          metadata: "Plays: #{scenario.plays_count}"
        )
      end
    end
  end

  def new_scenarios
    div class: 'tileCollection' do
      div "New Scenarios", class: 'tileHeader'
      scenarios_new.each do |scenario|
        widget Views::Shared::Tile.new(
          object: scenario,
          title_gen: -> (c) {link_to scenario.name, scenario, class: c},
          metadata: "Plays: #{scenario.plays_count}"
        )
      end
    end
  end

  # TODO: I know this is an n+1. But this will probably be cached later and smarter.
  def new_universes
    div class: 'tileCollection' do
      div "New Universes", class: 'tileHeader'
      universes_new.each do |universe|
        widget Views::Shared::Tile.new(
          object: universe,
          title_gen: -> (c) {link_to universe.name, universe, class: c},
          metadata: "Scenarios: #{universe.scenarios.published.size}"
        )
      end
    end
  end
end
