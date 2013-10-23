class DataPoint < ActiveRecord::Base
	belongs_to :stream
	has_many :accelerations
	has_many :results
	validates :from_lat, :from_lng, :to_lat, :to_lng, :start_time, :stop_time, presence: true
end
