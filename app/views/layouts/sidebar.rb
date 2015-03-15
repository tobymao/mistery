class Views::Layouts::Sidebar < Views::Base
  needs :current_user

  def content
    html do
      div class: 'sideSection' do
        div "Create", class: 'group'
        link_to "Universe", new_universe_path, class: 'sideLink'
        link_to "Scenario", new_scenario_path, class: 'sideLink'
      end

      div class: 'sideSection' do
        div "Browse", class: 'group'
        link_to "Universes", universes_path, class: 'sideLink'
        link_to "Scenarios", scenarios_path, class: 'sideLink'
      end
    end
  end
end
