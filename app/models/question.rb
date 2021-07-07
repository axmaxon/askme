class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  has_many :question_hashtags, dependent: :destroy
  has_many :hashtags, through: :question_hashtags

  # Проверка на наличие собственно текста вопроса, соотв-е допустимому размеру.
  # Проверка на наличие атрибута user происходит автоматически, вследствие связи belongs_to
  validates :text, presence: true, length: { maximum: 255 }

  after_commit :create_or_update_hashtags, on: [:create, :update]

  private

  def create_or_update_hashtags
    # Ищем хэштеги по тексту вопроса и ответа
    unique_hashtags = ("#{text} #{answer.to_s}").scan(/#[[:word:]]+/).uniq

    self.hashtags =
      unique_hashtags.map do |unique_hashtag|
        Hashtag.find_or_create_by(name: unique_hashtag.downcase.delete('#'))
      end
  end
end
