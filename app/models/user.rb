class User < ActiveRecord::Base
	has_many :data_points
	validates_uniqueness_of :name
	validates_uniqueness_of :email
 	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/, on: :create
end
