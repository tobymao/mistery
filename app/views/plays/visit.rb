class Views::Plays::Visit < Views::Layouts::Page
  needs :location
  needs :play
  needs :contact
  needs :current_path

  def main
    h1 location.name

    div do
      if contact
        div simple_format contact.text
      else
        text "There doesn't seem to be anybody here..."
      end
    end
  end

  def side_bar
    widget Views::Plays::SideBar.new(play: play, current_path: current_path)
  end
end
