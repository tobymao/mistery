class Views::Login::ResetPassword < Views::Layouts::Page
  needs :password_reset

  def main
    h1 "Reset Password"

    if password_reset.token_valid?
      form_tag reset_password_user_path(password_reset.user), method: 'PUT' do
        hidden_field_tag :token, password_reset.token
        label_tag 'Password'
        password_field_tag :password

        button_tag 'Reset Password'
      end
    else
      text "Sorry, password reset does not exist or is expired."
    end
  end
end
