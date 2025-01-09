require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome_email" do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.with(user: user).welcome_email }

    it "sends the email to the correct user" do
      expect(mail.to).to eq([ user.email ])
    end

    it "has the correct subject" do
      expect(mail.subject).to eq("Welcome to Odinbook")
    end
  end
end
