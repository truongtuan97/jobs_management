class User < ApplicationRecord
  has_secure_password
  
  has_many :jobs, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum role: { user: 0, recruiter: 1, admin: 2 }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
