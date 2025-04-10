class Post < ApplicationRecord
  has_many :notes, as: :noteable
end
