class Views::Users::Universes < Views::Layouts::Page
  needs :user

  def main
    h1 "Your universes"

    user.universes.each do |universe|
      div do
        link_to(universe.name, universe)
      end
    end
  end
end
