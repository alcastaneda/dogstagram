require 'bcrypt'

class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :photos
  has_many :likes
  has_many :liked_photos, through: :likes, source: :photo

  validates :username, presence: true
  validates :username, uniqueness: true

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(username, entered_password)
  	 @user = User.find_by(username: username)
  	 return @user if @user.password == entered_password
  end
end
