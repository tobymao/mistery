class Views::Universes::Show < Views::Layouts::Page
  needs :universe
  needs :owner

  def main
    h1 "Universe: #{universe.name}"

    div simple_format universe.description

    div class: 'tileCollection' do
      div "Scenarios", class: 'tileHeader'
      universe.scenarios.published.each do |scenario|
        widget Views::Shared::Tile.new(
          object: scenario,
          title_gen: -> (c) {link_to scenario.name, scenario, class: c},
          metadata: "Plays: #{scenario.plays_count}"
        )
      end
    end

    p "Locations:" do
      universe.locations.visible.each do |location|
        div do
          text "Name: #{location.name} "
          text "Group: #{location.group} "
        end
      end
    end


    if owner
      link_to "Edit Universe", edit_universe_path(universe)
    end
  end
end
