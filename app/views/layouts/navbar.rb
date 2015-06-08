class Views::Layouts::Navbar < Views::Base
  needs :current_user
  needs :current_path

  def content
    html do
      div class: 'logo' do
        link_to root_path do
          image_tag('logo_io.png', height: '45px')
        end
      end

      div class: 'navSetting' do
        if !current_user || current_user.guest
          link 'LOGIN', login_path
          link 'REGISTER', new_user_path
        else
          link "WELCOME #{current_user.login}", user_path(current_user)

          form_tag logout_path do
            button_tag "LOGOUT"
          end
        end
      end
    end
  end

  def link(text, path)
    classes = []
    classes << 'selected' if path == current_path
    link_to text, path, class: classes.join(' ')
  end
end
