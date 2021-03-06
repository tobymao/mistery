class Views::Users::Universes < Views::Layouts::Page
  needs :user

  def main
    div class: 'tileCollection' do
      user.universes.each do |universe|
        widget Views::Shared::Tile.new(
          object: universe,
          title_gen: -> (c) {link_to universe.name, universe, class: c},
          metadata: nil,
        )
      end
    end
  end
end
