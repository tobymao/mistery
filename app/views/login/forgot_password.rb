class Views::Login::ForgotPassword < Views::Layouts::Page
    def main
        h1 "You forgot your password"

        form_tag send_password_path do
            fields_for 'send_password' do |f|
            f.label 'Username'
            f.text_field :login

            f.label 'Email'
            f.text_field :email

            f.submit 'Reset Password'
        end
      end
  end
end