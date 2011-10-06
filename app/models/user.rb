class User < ActiveRecord::Base
	has_many :posts
	has_many :topics
	has_many :forums
	
	validates_presence_of	:first_name
	validates_presence_of	:last_name
	validates	:username,	:uniqueness =>true, 
							:presence => true
	validates 	:email, :uniqueness =>true, 
						:presence => true, 
						:format => {:with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i }
end
