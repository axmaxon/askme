class Hashtag < ApplicationRecord
  has_many :question_hashtags
  validates :name, presence: true, uniqueness: true
end
