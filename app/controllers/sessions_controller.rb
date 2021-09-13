# Контроллер, управляющий сессиями
# 1. Показывает страницу логина
# 2. Создает новую сессию (логин)
# 3. Позволяет разлогиниваться (удаляет сессию)
class SessionsController < ApplicationController
  # Пустой экшен, только показывает свой шаблон
  def new; end

  # Создает в объекте session новый факт залогиненности пользователя, если он
  # правильно сообщил мэйл/пароль
  def create
    user = User.authenticate(params[:email], params[:password])

    if user.present?
      session[:user_id] = user.id
      redirect_to users_path, notice: 'вы успешно залогинились'
    else
      # Это будет показанно в текущем запросе (за счет now)
      flash.now.alert = 'Неправильный мэйл или пароль'
      render :new
    end
  end

  # Удаляет сессию залогиненного юзера
  def destroy
    # Затираем в сессии значение ключа :user_id
    session[:user_id] = nil

    # Редиректим пользователя на главную с сообщением
    redirect_to users_path, notice: 'Вы разлогинились! Приходите еще!'
  end
end
