class Stream < ActiveRecord::Base
	has_many :data_points
	belongs_to :user
end
