module ApplicationHelper
  # Этот метод возвращает ссылку на аватарку пользователя, если она у него есть.
  # Или ссылку на дефолтную аватарку, которую положим в app/frontend/images
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_pack_path('media/images/avatar.jpg')
    end
  end

  # Вернёт слово "вопрос" в нужной форме (для текущего количества)
  def inclination (number_of_questions)
    # записываем в переменную number остаток от деления на 100 чтобы отсечь
    number_of_questions = number_of_questions % 100

    # если число больше 14 то записываем в переменную number остаток от деления на 10
    if number_of_questions > 14
      number_of_questions = number_of_questions % 10
    end

    # подбираем правильную форму слова под конкретные диапазоны чисел
    case number_of_questions
    when 0
      return 'вопросов'
    when 1
      return 'вопрос'
    when 2..4
      return  'вопроса'
    when 5..14
      return 'вопросов'
    end
  end
end
