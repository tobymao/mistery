class Views::Users::Universes < Views::Layouts::Page
  needs :user

  def main
    h1 "Your Universes"

    user.universes.each do |universe|
      widget Views::Shared::Tile.new(
        object: universe,
        title_widget: Views::Shared::Title.new(name: universe.name, path: universe_path(universe)),
        metadata: nil,
      )
    end
  end
end
