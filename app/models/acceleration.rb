class Acceleration < ActiveRecord::Base
	belongs_to :data_point
	validates :time, :x, :y, :z, :sequence, presence: true
end
