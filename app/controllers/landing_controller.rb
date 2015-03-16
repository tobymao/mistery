class LandingController < ApplicationController
  NEW_SCENARIO_LIMIT = 100
  NEW_UNIVERSE_LIMIT = 10

  # GET /
  def index
    scenarios = Scenario
      .includes(:user)
      .published
      .last(NEW_SCENARIO_LIMIT)

    @scenarios_new = scenarios.last(10).reverse
    @scenarios_top = scenarios.sort_by(&:plays_count).reverse.take(10)
    @universes_new = Universe
      .includes(:user)
      .published
      .last(NEW_UNIVERSE_LIMIT)
  end
end
