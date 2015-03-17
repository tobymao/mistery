class Views::Users::Edit < Views::Layouts::Page
needs :current_user

  def main
    h1 "Edit User"

    form_tag user_path(current_user), method: 'PUT' do
      fields_for 'current_user' do |f|

        f.label :email, 'Your Email'
        f.text_field :email

        f.submit 'Update Email'
      end
    end

    #text_field asdf

    form_tag user_path(current_user), method: 'PUT' do
      fields_for 'current_user' do |f|

        f.label :password, 'Your Password'
        f.text_field :password

        f.submit 'Update Password'
      end
    end

  end
end
