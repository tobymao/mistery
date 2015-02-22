class Views::Layouts::Navbar < Views::Base
  def content
    html do
      div class: 'logo' do
        link_to root_path do
          image_tag('logo_io.png', height: '45px')
        end
      end

      div class: 'navSetting' do
        link_to "Login", login_path
        link_to "Register", new_user_path
      end

      div class: 'navDivider'

      div class: 'navTab' do
        link_to "Universes", universes_path
        link_to "Scenarios", scenarios_path
      end
    end
  end
end
