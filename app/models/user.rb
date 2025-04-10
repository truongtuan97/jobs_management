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
  has_many :books, foreign_key: 'author_id', dependent: :destroy

  enum role: { user: 0, recruiter: 1, admin: 2 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 18 }, allow_nil: true

  before_create :set_jti
  before_destroy :prevent_admin_deletion

  private

  def set_jti
    self.jti ||= SecureRandom.uuid
  end

  def prevent_admin_deletion
    throw(:abort) if admin?
  end
end
