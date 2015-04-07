require "rails_helper"

RSpec.describe LoginHelp, type: :mailer do
  let(:user) { create(:user, login: "test", password: "password", email: "test@example.com")}


  describe "username" do
    let(:mail) { LoginHelp.username_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Mistery.io Username")
      expect(mail.to).to eq(["test@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Your Username is test")
    end
  end

  describe "password" do
    let(:mail) { LoginHelp.password_email(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Mistery.io Password")
      expect(mail.to).to eq(["test@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to start_with("Your password has been reset. Your new temporary password is ")
    end
  end

end
