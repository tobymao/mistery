class Views::Layouts::Sidebar < Views::Base
  def content
    html do
      div class: 'sideButton' do
        div 'sideSection' do
          link_to "Create Universe", new_universe_path
          link_to "Create Scenario", new_scenario_path
        end

        div 'sideSection' do
          link_to "My Universes", root_path
          link_to "My Scenarios", root_path
        end

        div 'sideSection' do
          link_to "Play", new_scenario_path
        end
      end
    end
  end
end
