class Views::Plays::Show < Views::Layouts::Page
  needs :play

  def main
    h1 "Play Scenario: #{play.scenario.name}"
    div do
      play.scenario.description
    end
  end

  def side_bar
    widget Views::Plays::SideBar.new(play: play)
  end
end
