module FollowRequestsHelper
  def follow_request_decision_form(url, request, button_text, stimulus_action)
    form_with(url: url, method: :post) do |f|
      concat f.hidden_field(:follower_id, value: request.sender.id)
      concat f.hidden_field(:request_id, value: request.id)
      concat f.submit(button_text, data: { controller: "follow-buttons", action: stimulus_action, "follow-buttons-target": "button" })
    end
  end
end
