class User < ApplicationRecord
   has_secure_password
    has_many :to_dos, dependent: :destroy 
end
