class Views::Universes::Index < Views::Layouts::Page
  needs :universes
  def main
    h1 "Universes"

    universes.each do |universe|
      widget Views::Shared::Tile.new(
        object: universe,
        title_widget: Views::Shared::Title.new(name: universe.name, path: universe_path(universe)),
        metadata: nil,
      )
    end
  end
end
