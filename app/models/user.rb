class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  
  has_many :jobs, dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :comments, dependent: :destroy

  enum role: { user: 0, recruiter: 1, admin: 2 }

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
