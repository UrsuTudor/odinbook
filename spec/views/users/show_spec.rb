require 'rails_helper'

RSpec.describe "users/show.html.erb", type: :view do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  it "renders the user's data" do
    allow(view).to receive(:current_user).and_return(user)
    assign(:user, user)
    user.posts << post
    render template: "users/show"

    expect(rendered).to match(user.name)
    expect(rendered).to match(user.age.to_s)
    expect(rendered).to match(user.city)
    expect(rendered).to match(user.posts.first.body)
  end
end
