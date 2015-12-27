module TempPasswords
  include BCrypt
  def give_temp_password!
    new_temp_password = SecureRandom.urlsafe_base64(32)
    self.update({
      temp_password_hash: Password.create(new_temp_password),
      temp_password_expiration_date: 3.days.from_now
    })
    return new_temp_password
  end

  def temp_password
    @temp_password ||= Password.new(temp_password_hash)
  end

  def temp_password=(new_password)
    @temp_password = Password.create(new_password)
    self.temp_password_hash = @password
  end

  def temp_password_expired?
    temp_password_expiration_date.nil? ||
      temp_password_expiration_date < Time.now
  end
end
