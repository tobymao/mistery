class Views::Universes::Index < Views::Layouts::Page
  needs :universes
  def main
    h1 "Universes"

    universes.each do |universe|
      widget Views::Shared::Tile.new(object: universe, link: universe_path(universe))
    end
  end
end
