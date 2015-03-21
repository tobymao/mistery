require "rails_helper"

RSpec.describe LoginHelp, type: :mailer do
  describe "username" do
    let(:mail) { LoginHelp.username }

    it "renders the headers" do
      expect(mail.subject).to eq("Username")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "password" do
    let(:mail) { LoginHelp.password }

    it "renders the headers" do
      expect(mail.subject).to eq("Password")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
