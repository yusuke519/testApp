class User < ActiveRecord::Base
  has_many :streams
  has_secure_password
  validates_uniqueness_of :name
  validates_uniqueness_of :email
  validates :name,:email, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/
  validates_length_of :password, in: 7..32
end
