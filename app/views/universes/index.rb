class Views::Universes::Index < Views::Layouts::Page
  needs :universes
  needs :start
  needs :count

  def main
    h1 "Universes"

    universes.each do |universe|
      widget Views::Shared::Tile.new(
        object: universe,
        title_gen: -> (c) {link_to universe.name, universe, class: c},
        metadata: nil,
      )
    end

    widget Views::Shared::Pager.new(
      start: start,
      count: count,
      path_gen: -> (index) {universes_path(start: index)}
    )
  end
end
