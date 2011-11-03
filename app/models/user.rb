class User < ActiveRecord::Base
	has_many :posts
	has_many :topics
	has_many :forums
	
	attr_accessor   :password
	attr_accessible :first_name, :last_name, :username, :active, :email, :password, :password_confirmation
	
	scope 	 :active, where(:active => true)
	
	validates_presence_of	:first_name
	validates_presence_of	:last_name
	validates	:username,	:uniqueness =>true, 
							:presence => true,
							:length		=> { :within => 6..40}
	validates 	:email, :uniqueness =>true, 
						:presence => true, 
						:format => {:with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i }
	validates :password, :presence =>true,
						:confirmation=>true,
						:length		=> { :within => 6..40}
						
						
	before_save :encrypt_password
	
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	
	class << self
		def authenticate(email, submitted_password)
			user = find_by_email(email)
			(user && user.has_password?(submitted_password)) ? user : nil
		end
		
		def authenticate_with_salt(id, cookie_salt)
			user = find_by_id(id)
			(user && user.salt == cookie_salt) ? user :nil
		end
	end
	
	private
		
		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end
		
		def encrypt(string)
			secure_hash("#{salt}---#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}---#{password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
end
