class Views::Users::Universes < Views::Layouts::Page
  needs :user

  def main
    h1 "Your Universes"

    user.universes.each do |universe|
      widget Views::Shared::Tile.new(object: universe, link: universe_path(universe))
    end
  end
end
