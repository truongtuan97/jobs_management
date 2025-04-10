class Photo < ApplicationRecord
  has_many :notes, as: :noteable
end
