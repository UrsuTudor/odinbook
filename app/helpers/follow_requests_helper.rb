module FollowRequestsHelper
  def follow_request_decision_form(url, request, button_text, stimulus_action, stimulus_target)
    form_with(url: url, method: :post) do |f|
      concat f.hidden_field(:follower_id, value: request.sender.id)
      concat f.hidden_field(:request_id, value: request.id)
      concat f.submit(button_text, data: { action: stimulus_action, target: stimulus_target })
    end
  end

  def follow_request_form(user, sent_follow_requests)
    form_with(url: follow_requests_path, method: :post) do |f|
      concat user.name

      if current_user.followees.include?(user)
        concat f.submit "Following", disabled: true
      elsif !sent_follow_requests.include?(user.id)
        concat f.hidden_field :recipient_id, value: user.id
        concat f.submit "Send Follow Request", data: { controller: "follow-buttons", action: "click->follow-buttons#change_request_button", target: "follow-buttons.button" }
      end
    end
  end
end
