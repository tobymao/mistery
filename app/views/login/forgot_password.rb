class Views::Login::ForgotPassword < Views::Layouts::Page
  def main
    h1 "You forgot your password"

    form_tag send_password_path do

      label_tag 'Email'
      text_field_tag :email

      submit_tag 'Reset Password'
    end
  end
end
