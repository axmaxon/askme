class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :question_hashtags
  # Проверка на наличие собственно текста вопроса, соотв-е допустимому размеру.
  # Проверка на наличие атрибута user происходит автоматически, вследствие связи belongs_to
  validates :text, presence: true, length: { maximum: 255 }

end
