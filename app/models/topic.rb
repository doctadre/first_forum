class Topic < ActiveRecord::Base
	belongs_to :forum
	belongs_to :user
	validates_presence_of :title
	has_many :posts, :dependent => :destroy
end
