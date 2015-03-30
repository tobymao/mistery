class Views::Login::ForgotUsername < Views::Layouts::Page
    def main
        h1 "You forgot your username"

        form_tag send_username_path do

            label_tag 'Email'
            text_field_tag :email

            submit_tag 'Send Username'
        end
        
    end

end