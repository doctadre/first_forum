class Forum < ActiveRecord::Base
	has_many :topics
	
	def to_param
    "#{id}-#{title.parameterize}"
  end
  
  def to_s
    title
  end
end
