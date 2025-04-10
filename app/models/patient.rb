class Patient < ApplicationRecord
  has_many :appointments
  has_many :doctors, through: :appointments

  validates :name, presence: true
  validates :age, presence: true
  validates :age, numericality: { only_integer: true }
  validates :age, numericality: { greater_than: 0 }
end
