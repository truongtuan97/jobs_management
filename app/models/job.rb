class Job < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :applications, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :salary, numericality: { greater_than: 0 }
end
