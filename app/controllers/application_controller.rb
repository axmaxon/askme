class ApplicationController < ActionController::Base

  # Чтобы метод current_user был доступен в шаблона, нам необходимо объявить
  # его с помощью метода helper_method. Эта строка как бы говорит рельсам:
  # если в шаблоне встретишь current_user — не пугайся, что такого метода нет,
  # дерни этот метод у контроллера.
  helper_method :current_user
  helper_method :get_hashtag_by_name

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  # Метод, который редиректит посетителя на главную с предупреждением о
  # нарушении доступа. Мы будем использовать этот метод, когда надо запретить
  # пользователю что-то.
  def reject_user
    redirect_to users_path, alert: 'Вам сюда нельзя!'
  end

  # Метод контроллера, достающий текущего юзера из базы по данным аутентификации
  # в сессии.
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def not_found
    render file: 'public/404.html', status: :not_found, layout: false
  end

  # Ищет хэштег по имени
  def get_hashtag_by_name(word)
    Hashtag.find_by(name: "#{word.delete('#').downcase}")
  end
end
