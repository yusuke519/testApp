class User < ActiveRecord::Base
  has_secure_password
  validates_uniqueness_of :name
  validates_uniqueness_of :email
  validates_format_of :email, with: /[A-Z|a-z|1-9]/ 
  validates_length_of :password, in: 7..32
end
