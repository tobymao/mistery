# Preview all emails at http://localhost:3000/rails/mailers/login_help
class LoginHelpPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/login_help/username
  def username
    LoginHelp.username
  end

  # Preview this email at http://localhost:3000/rails/mailers/login_help/password
  def password
    LoginHelp.password
  end

end
