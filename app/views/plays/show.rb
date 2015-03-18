class Views::Plays::Show < Views::Layouts::Page
  needs :play
  needs :current_path

  def main
    h1 play.scenario.name

    div do
      div simple_format play.scenario.description, class: 'mainText'
    end
  end

  def side_bar
    widget Views::Plays::SideBar.new(play: play, current_path: current_path)
  end
end
