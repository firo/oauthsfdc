class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:salesforce]

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    	user.email = auth.info.email
    	user.password = Devise.friendly_token[0,20]
		user.provider = auth.provider
		user.uid = auth.uid
		# user.name = auth.info.name
		# user.oauth_token = auth.credentials.token
		# user.refresh_token = auth.credentials.refresh_token
		# user.instance_url = auth.credentials.instance_url
		# user.save!
  		end
	end
end
