module Subscribable
  def self.included(base)
    base.extend(ClassMethods)
  end

  def subscribe! *users
    users.each { |user| subscribe_user(user) }
  end

  def unsubscribe! *users
    users.each { |user| unsubscribe_user(user) }
  end

  def subscribe_user(user)
    return if self.subscriptions.where(user: user).count > 0
    self.subscriptions.create(user: user)
  end

  def unsubscribe_user(user)
    return if self.subscriptions.where(user: user).count == 0
    self.subscriptions.where(user: user).destroy_all
  end

  module ClassMethods
    def subscribed_emails_for obj, exclude=nil
      addresses = obj.subscriptions.collect do |subscription|
        next if exclude && subscription.user == exclude
        if subscription.user.send_notifications
          subscription.user.email
        end
      end
      addresses.join ";"
    end
  end
end
