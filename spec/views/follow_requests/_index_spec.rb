require 'rails_helper'

RSpec.describe "follow_requests/_index.html.erb", type: :view do
  let!(:follow_requests) do
    create_list(:follow_request, 3) do |follow_request, index|
      follow_request.save!
    end
  end

  it "renders the existing follow requests" do
    render partial: "follow_requests/index", locals: { received_follow_requests: follow_requests }

    request1 = follow_requests.first
    request2 = follow_requests.second
    request3 = follow_requests.third

    expect(rendered).to match(request1.sender.name)
    expect(rendered).to match(request2.sender.name)
    expect(rendered).to match(request3.sender.name)
  end

  # the forms are tested in the helper test folder
end
