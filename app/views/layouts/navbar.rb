class Views::Layouts::Navbar < Views::Base
  def content
    html do
      div class: 'navTab' do
        link_to "Home", root_path
        link_to "Universes", universes_path
        link_to "Scenarios", scenarios_path
      end

      div class: 'navSetting' do
        link_to "Login", login_path
        link_to "Register", new_user_path
      end
    end
  end
end
