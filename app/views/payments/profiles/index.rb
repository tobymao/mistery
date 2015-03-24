class Views::Payments::Profiles::Index < Views::Layouts::Page
  needs :current_user
  needs :profile

  def main
    form_for profile do |f|
      f.label :email, 'Paypal Email'
      f.text_field :email
      f.submit
    end
  end
end
