class LoginHelp < ApplicationMailer
  
  def index
  end

  def username(user_email)

    if users.email.include? user_email
      
      mail to: current_user.email, subject "Your Username is #{current_user.username}"
    else
      respond_to do |format|
        format.html {redirect_to login_help, notice: "Username not found"}
        format.json {render json: :new}
      end
    end


    
  end

  def password
    @greeting = "Hi"

    mail to: "cscampbell@gmail.com"
  end
end
