class User < ApplicationRecord
  has_many :pictures 

  validates :email, presence: true
end
