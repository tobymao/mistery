class Views::Plays::Index < Views::Layouts::Page
  needs :user_plays
  needs :plays

  def main
    h1 'Play a Scenario'

    h3 "Active Games"
    user_plays.each do |play|
      if !play.points
        widget Views::Shared::Tile.new(
          object: play.scenario,
          title_gen: -> (c) {link_to play.scenario.name, play, class: c},
          metadata: play.active ? "Moves #{play.actions.size}" : "Ready To Guess",
        )
      end
    end

    h3 "Start A New Game"
    plays.each do |play|
      unless user_plays.any?{|user_play| user_play.scenario == play.scenario}
        widget Views::Shared::Tile.new(
          object: play.scenario,
          metadata: "",
          title_gen: -> (c) {
            form_for play do |f|
              f.hidden_field :scenario_id, value: play.scenario.id
              f.button play.scenario.name, class: c
            end
          },
        )
      end
    end

    h3 "Game History"
    user_plays.each do |play|
      if play.points
        widget Views::Shared::Tile.new(
          object: play.scenario,
          title_gen: -> (c) {link_to play.scenario.name, play, class: c},
          metadata: "Score #{play.points}",
        )
      end
    end
  end
end
