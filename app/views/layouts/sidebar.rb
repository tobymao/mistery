class Views::Layouts::Sidebar < Views::Base
  needs :current_user

  def content
    html do
      div class: 'sideButton' do
        div class: 'sideSection' do
          link_to "Create Universe", new_universe_path, class: 'sideLink'
          link_to "Create Scenario", new_scenario_path, class: 'sideLink'
        end

        div class: 'sideSection' do
          link_to "My Universes", universes_user_path(current_user), class: 'sideLink'
          link_to "My Scenarios", scenarios_user_path(current_user), class: 'sideLink'
        end if current_user

        div class: 'sideSection' do
          link_to "Play", plays_path, class: 'sideLink'
        end
      end
    end
  end
end
