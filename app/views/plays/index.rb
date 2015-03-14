class Views::Plays::Index < Views::Layouts::Page
  needs :user_plays
  needs :plays

  def main
    h1 'Play a Scenario'

    h3 "Active Games"
    user_plays.each do |play|
      if play.active
        widget Views::Shared::Tile.new(
          object: play.scenario,
          title_widget: Views::Shared::Title.new(name: play.scenario.name, path: play),
          metadata: "Moves #{play.actions.size}"
        )
      end
    end

    h3 "Start A New Game"
    plays.each do |play|
      unless user_plays.any?{|user_play| user_play.active && (user_play.scenario == play.scenario)}
        widget Views::Shared::Tile.new(
          object: play.scenario,
          title_widget: Views::Shared::PlayTitle.new(play: play),
          metadata: "",
        )
      end
    end

    h3 "Game History"
    user_plays.each do |play|
      unless play.active
        widget Views::Shared::Tile.new(
          object: play.scenario,
          title_widget: Views::Shared::Title.new(name: play.scenario.name, path: play),
          metadata: "Score #{play.points}",
        )
      end
    end
  end
end
