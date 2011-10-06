class Forum < ActiveRecord::Base
	has_many :topics, :dependent => :destroy
	belongs_to :user
	
	validates_presence_of :title
	
	def to_param
    "#{id}-#{title.parameterize}"
  end
  
  def to_s
    title
  end
end
