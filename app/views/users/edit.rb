class Views::Users::Edit < Views::Layouts::Page
  needs :user

  def main
    h1 "Edit User"
  end
end
