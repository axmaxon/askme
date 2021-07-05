class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  # Проверка на наличие собственно текста вопроса, соотв-е допустимому размеру.
  # Проверка на наличие атрибута user происходит автоматически, вследствие связи belongs_to
  validates :text, presence: true, length: { maximum: 255 }

  after_commit :do_hashtag, on: [:create, :update]

  private

  def do_hashtag
    self.hashtags.clear

    # Ищем хэштеги по тексту вопроса и по ответа
    hashtags = (self.text + self.answer.to_s).scan(/#[[:word:]]+/)

    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(name: hashtag.downcase.delete('#'))
      self.hashtags << tag
    end
  end
end
