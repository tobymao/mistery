class Views::Users::Edit < Views::Layouts::Page
needs :current_user

  def main
    h1 "Edit User"

    form_for current_user do |f|
      f.label :email, 'Your Email'
      f.text_field :email

      f.submit 'Update Email'
    end

    form_for current_user do |f|
      f.label :password, 'Your Password'
      f.password_field :password

      f.submit 'Update Password'
    end
  end
end
