class Views::Plays::Visit < Views::Layouts::Page
  needs :location
  needs :play
  needs :contact

  def main
    h1 location.name

    div do
      if contact
        text contact.text
      else
        text "There doesn't seem to be anybody here..."
      end
    end
  end

  def side_bar
    widget Views::Plays::SideBar.new(play: play)
  end
end
