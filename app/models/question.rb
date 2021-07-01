class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  # Проверка на наличие собственно текста вопроса, соотв-е допустимому размеру.
  # Проверка на наличие атрибута user происходит автоматически, вследствие связи belongs_to
  validates :text, presence: true, length: { maximum: 255 }

  after_create do
    question = Question.find_by(id: self.id)
    hashtags = self.text.scan(/#[[:word:]]+/)

    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(name: hashtag.downcase.delete('#'))
      question.hashtags << tag
    end
  end

  before_update do
    question = Question.find_by(id: self.id)
    question.hashtags.clear

    # Ищем хэштеги по тексту вопроса и по ответа
    hashtags = (self.text + self.answer).scan(/#[[:word:]]+/)

    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(name: hashtag.downcase.delete('#'))
      question.hashtags << tag
    end

    # Подчищаем неиспользуемые теги в базе, если такие есть
    Hashtag.all.each do |hashtag|
      hashtag.destroy if hashtag.questions.blank?
    end
  end
end
