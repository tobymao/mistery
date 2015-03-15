class Views::Layouts::Navbar < Views::Base
  needs :current_user

  def content
    html do
      div class: 'logo' do
        link_to root_path do
          image_tag('logo_io.png', height: '45px')
        end
      end

      div class: 'navSetting' do
        if !current_user || current_user.guest
          link_to "Login", login_path
          link_to "Register", new_user_path
        else
          link_to "Welcome #{current_user.login}", current_user

          form_tag logout_path do
            button_tag "Logout"
          end
        end
      end

      div class: 'navDivider'

      div class: 'navTab' do
        unless current_user.guest
          link_to "My Universes", universes_user_path(current_user)
          link_to "My Scenarios", scenarios_user_path(current_user)
        end

        link_to "My Plays", plays_path
      end if current_user
    end
  end
end
