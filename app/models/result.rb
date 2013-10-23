class Result < ActiveRecord::Base
	belongs_to :data_point
	validates :value, presence: true
end
