class UsersChannel < ApplicationCable::Channel
  def subscribed
  end

  def follow(user_id)
    stream_from "users:#{user_id}"
  end

end
