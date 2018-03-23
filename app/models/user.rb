class User < ApplicationRecord
  has_secure_password
  validates_uniqueness_of :email

# create SESSIONS for the active user, and terminate on signing out

end
