class Views::Users::Show < Views::Layouts::Page
  needs :user
  needs :current_user

  def main
    h1 "User Profile"
    link_to "Edit Profile", edit_user_path(user)

    p do
      text "Username: "
      text user.login
    end


    p do
      if(user == current_user)
        text "Your Email: "
        text user.email
        text " "	
      else
        text "Email Private"
      end
    end

    p do
    	text "Member since "
    	text user.created_at.to_date
    end



  end
end
