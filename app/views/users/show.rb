class Views::Users::Show < Views::Layouts::Page
  needs :user

  def main
    h1 "User Profile"
    link_to "Edit Profile", edit_user_path(user)

    p do
      text "Your Username: "
      text user.login
    end

    p do
    	text "Your Email: "
    	text user.email
    	text " "
    	
    end

    p do
    	text "You have been a member for "
    	text (Date.today - user.created_at.to_date).to_i
    	text " days"
    end



  end
end
