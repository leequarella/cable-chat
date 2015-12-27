class UsersChannel < ApplicationCable::Channel
  def subscribed(user_id)
    stream_from "users:#{user_id}"
  end

end
