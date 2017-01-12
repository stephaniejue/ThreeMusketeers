class User < ActiveRecord::Base
  has_many :apartments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      if auth.provider = "facebook"
        user.email = auth.uid + "@" + auth.provider + ".com"
        user.password = Devise.friendly_token[0,20]
      elsif auth.provider = "twitter"
        user.email = auth.info.nickname + "@" + auth.provider + ".com"
        user.password = Devise.friendly_token[0,20]
      end
    end
  end
end
