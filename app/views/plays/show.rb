class Views::Plays::Show < Views::Layouts::Page
  needs :play

  def main
    h1 "Play Scenario #{play.scenario.name}"
  end
end
