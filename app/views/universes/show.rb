class Views::Universes::Show < Views::Layouts::Page
  needs :universe

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
  end
end
