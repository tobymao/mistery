class Views::Layouts::Sidebar < Views::Base
  def content
    html do
      div class: 'sideButton' do
        link_to "Create Universe", new_universe_path
        link_to "Create Scenario", new_scenario_path
      end
    end
  end
end
