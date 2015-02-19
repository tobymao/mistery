class Views::Universes::Show < Views::Layouts::Page
  needs :universe
  needs :owner

  def main
    h1 "Universe: #{universe.name}"

    p do
      div "Description: #{universe.description}"

      p "Locations:" do
        universe.locations.each do |location|
          div do
            text "Name: #{location.name} "
            text "Address: #{location.address} "
          end
        end
      end
    end

    if owner
      link_to "Edit Universe", edit_universe_path(universe)
    end
  end
end
