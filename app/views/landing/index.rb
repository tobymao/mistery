class Views::Landing::Index < Views::Layouts::Page
  needs :featured
  needs :scenarios_new
  needs :universes_new
  needs :scenarios_top

  def main
    intro
    featured_scenario
    top_scenarios
    new_scenarios
    new_universes
  end

  def intro
    h1 "Welcome to Mistery.io!"

    div class: 'mainText' do
      h1 do
        text "I've decided not to renew the domain and will be taking the site down Feburary 20, 2017."
        br
        text "I hope you've all enjoyed the site. Thanks!"
      end

      p do
      	text "This is a website where you can create and play your own mystery stories similar to the board game "
      	link_to("Sherlock Holmes: Consulting Detective", "http://boardgamegeek.com/boardgame/2511/sherlock-holmes-consulting-detective", target: "_blank")
      	text "."
      end

      p do
      	text "As a writer, create your own "
      	link_to("universes", new_universe_path)
      	text " and "
      	link_to("mysteries", new_scenario_path)
      	text " to solve."
      end

      p do
      	text "As a player, you can select a "
      	link_to("scenario", scenarios_path)
      	text " to play through. Visit any of the locations to look for clues, and when you feel like you can solve the case, answer the questions to find out your score!"
      end

      p do
      	text "This site is still heavily in development. We appreciate your feedback and we hope to grow a great community here."
      end

      p do
      	text "Email us at misterydotio [at] gmail [dot] com with any feedback or if you would like to contribute."
      end

      h2 "How to Play"

      p do
        text "When you select a "
        link_to("scenario", scenarios_path)
        text ", press the 'Play This Scenario' button under the description. A list of locations will show up on the left bar. Read through the introduction of the scenario, and then click any location on the left bar to visit it. "
        text "Each location can have a story associated with it. You can revisit locations and also revisit the introduction text by pressing 'Back To Indroduction.' "
        text "When you feel like you have visited enough locations to solve the mystery, press 'Solve Mystery' located at the bottom of the left navigation pane. There will be questions for you to answer for a score. "
        text "Click on each question to answer it, and when you are finished answering questions, press the 'Finish Game' button to see your final score! You get points for answering locations correctly, and you lose points for visiting too many locations."
        br
        text "Note: Once you press 'Solve Mystery,' you cannot visit any new locations, but you can revisit locations you've seen before. Also, you currently cannot change your answers to a question."
      end
    end
  end

  static :intro

  def featured_scenario
    div class: 'tileCollection' do
      div "Featured Scenario - For Advanced Players!", class: 'tileHeader'
      scenario_widget(featured)
    end
  end

  def top_scenarios
    div class: 'tileCollection' do
      div "Trending Scenarios", class: 'tileHeader'
      scenarios_top.each do |scenario|
        scenario_widget(scenario)
      end
    end
  end

  def new_scenarios
    div class: 'tileCollection' do
      div "New Scenarios", class: 'tileHeader'
      scenarios_new.each do |scenario|
        scenario_widget(scenario)
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

  def scenario_widget(scenario)
    widget Views::Shared::Tile.new(
      object: scenario,
      title_gen: -> (c) {link_to scenario.name, scenario, class: c},
      metadata: "Plays: #{scenario.plays_count}"
    )
  end
end
