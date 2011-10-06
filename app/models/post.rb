class Post < ActiveRecord::Base

	default_scope :order => "created_at asc"
	
	belongs_to :topic
	belongs_to :user
	
	validates_presence_of  :body
end
