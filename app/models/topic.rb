class Topic < ActiveRecord::Base
	belongs_to :forum
	belongs_to :user
	validates_presence_of :title
	has_many :posts, :dependent => :destroy
	
	def to_param
    "#{id}#{"/"}#{"/posts".parameterize}"
  end
end
