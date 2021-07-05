class Hashtag < ApplicationRecord
  has_many :question_hashtags, dependent: :destroy
  has_many :questions, through: :question_hashtags

  validates :name, presence: true, uniqueness: true

  # Только хэштеги у которых есть вопросы (без повторов)
  scope :relevant, -> { Hashtag.joins(:questions).distinct }
end
