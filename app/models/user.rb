require 'openssl'
require 'uri'

class User < ApplicationRecord
  # Параметры работы модуля шифрования паролей
  EMAIL_PATTERN = /\A[^@\s]+@[^@\s]+\.[^@\s]+\Z/
  USERNAME_PATTERN = /\A\w+\Z/
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest.new('SHA256')
  URL_PATTERN = /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  COLOR_PATTERN = /\A#\h{6}\z/

  # Добавляем виртуальный атрибут -пароль. Это поле будет в руби-объекте но не в БД
  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :email, :username, presence: true, uniqueness: true
  validates :email, format: { with: EMAIL_PATTERN }
  validates :username, length: { maximum: 40 }, format: { with: USERNAME_PATTERN }
  validates :avatar_url, format: { with: URL_PATTERN }, allow_blank: true
  validates :profile_color, format: { with: COLOR_PATTERN }

  # Валидируем атрибут пароль. Т.е rails перед сохранением проверят и это поле.
  # Валидация будет происходить только при создании нового поль-ля (при выз. экшн create)
  # В объекте должно быть второе поле password_confirmation (для подтверждения пароля)
  validates :password, presence: true, confirmation: true, on: :create

  # Изменяют атр. email и username - приводя к нижнему регистру перед валидацией.(Для искл. дублей)
  before_validation :downcase_email
  before_validation :downcase_username
  # Коллбэк чтобы зашифровать наши пароли ДО сохранения очередного пользователя в базу.
  # (те что будут храниться в полях password_hash password_salt)
  before_save :encrypt_password

  # Служебный метод, преобразующий бинарную строку в 16-ричный формат, для удобства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack1('H*')
  end

  # Метод реализующий возможность залогиниться
  def self.authenticate(email, password)
    email = email&.downcase
    user = find_by(email: email) # сначала находим кандидата по email
    # Здесь сравнивается пароль преобразованный в password_hash
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password,
                                                                                             user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    end
  end

  private

  def encrypt_password
    if password.present?
      # Создаем т.н. "соль" - рандомная строка усложняющая задачу хакерам
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      # Создаем хэш пароля - преобразуем пароль в длинную уникальную строку
      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(password, password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def downcase_email
    email&.downcase!
  end

  def downcase_username
    username&.downcase!
  end
end
