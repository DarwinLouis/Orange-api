class User < ActiveRecord::Base
	before_save :ensure_authentication_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :membership

  def ensure_authentication_token
	if authentication_token.blank?
		self.authentication_token = generate_authentication_token
	end
  end

  def generate_authentication_token
	loop do
		token = Devise.friendly_token
		break token unless User.where(authentication_token: token).first
	end
  end

  def send_password_reset
	generate_token(:password_reset_token)
	self.password_reset_sent_at = Time.zone.now
	save!
	UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
	begin
		self[column] = SecureRandom.urlsafe_base64
	end while User.exists?(column => self[column])
  end

end
