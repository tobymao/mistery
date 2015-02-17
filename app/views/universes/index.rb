class Views::Universes::Index < Views::Layouts::Page
  needs :universes
  def main
    h1 "Universes"

    universes.each do |universe|
      div do
        link_to(universe.name, universe)
      end
    end
  end
end
