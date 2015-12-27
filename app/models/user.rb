class User < ApplicationRecord
  include TempPasswords
  include Roles
  possible_role "super"
  possible_role "normal"
  has_secure_password

  validates_uniqueness_of :email

  scope :active,  -> { where(active: true)}
  scope :by_name, -> (name) {
    #where(active: true)
    where("lower(name) LIKE(?) ", "%#{name.downcase}%")
  }

  def self.temp
    self.new(active: false)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
