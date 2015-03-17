class Views::Layouts::Sidebar < Views::Base
  needs :current_user
  needs :current_path

  def content
    html do
      div class: 'sideSection' do
        div "Create", class: 'group'
        link "Universe", new_universe_path
        link "Scenario", new_scenario_path
      end

      div class: 'sideSection' do
        div "Browse", class: 'group'
        link "Universes", universes_path
        link "Scenarios", scenarios_path
      end
    end
  end

  def link(text, path)
    if path == current_path
        link_to text, path, class: 'sideLink selected'
    else
        link_to text, path, class: 'sideLink'
    end
  end
end
