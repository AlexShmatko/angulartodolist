class User < ActiveRecord::Base
  has_secure_password

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :first_name, presence: true,
            length: {maximum: 20}
  validates :last_name,  presence: true,
            length: {maximum: 40}
  validates :email, presence: true,
            format: {with: EMAIL_REGEX},
            uniqueness:  {case_sensitive: true}
  validates :password,
            length: {within: 6..40}, on: :create

  def full_name
    name = [first_name, last_name].join(' ').strip
    name.blank? ? email : name
  end

  def send_password_reset
    UserMailer.password_reset(self).deliver_now
  end

  has_many :tasks
end
