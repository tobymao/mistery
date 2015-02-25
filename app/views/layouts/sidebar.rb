class Views::Layouts::Sidebar < Views::Base
  def content
    html do
      div class: 'sideButton' do
        div class: 'sideSection' do
          link_to "Create Universe", new_universe_path, class: 'sideLink'
          link_to "Create Scenario", new_scenario_path, class: 'sideLink'
        end

        div class: 'sideSection' do
          link_to "My Universes", root_path, class: 'sideLink'
          link_to "My Scenarios", root_path, class: 'sideLink'
        end

        div class: 'sideSection' do
          link_to "Play", plays_path, class: 'sideLink'
        end
      end
    end
  end
end
