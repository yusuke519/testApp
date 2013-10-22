class User < ActiveRecord::Base
	has_many :data_points
	validates_uniqueness_of :name
	validates_uniqueness_of :email
	validates_length_of :password, in: 7..32, allow_nil: false, allow_blank: nil, message:"password must contain 7-32 characters or numbers"
end
