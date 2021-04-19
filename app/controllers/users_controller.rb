class UsersController < ApplicationController
  def index
    # Все пользователи
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit

  end

  def show

  end

  # Действие create будет отзываться при POST-запросе по адресу /users из формы
  # нового пользователя, которая находится в шаблоне на странице /users/new.
  def create
    # создаём нового пользователя с параметрами
    @user = User.new(user_params)

    # Если юзер сохранен, перенаправляем запрос на root, который определн нами в routes
    if @user.save
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    end
  end
end

private

# Явно задаем список разрешенных параметров для модели User. Мы говорим, что
# у хэша params должен быть ключ :user. Значением этого ключа может быть хэш с
# ключами: :email, :password, :password_confirmation, :name, :username и
# :avatar_url. Другие ключи будут отброшены.
def user_params
  params.require(:user).permit(:email, :password, :password_confirmation,
                               :name, :username, :avatar_url)
end
