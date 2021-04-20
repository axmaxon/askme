class UsersController < ApplicationController
  # Создадим отдельный метод для повторяющегося кода, который будет выполняться
  # перед каждым экшеном (кроме исключенных (except))
  before_action :load_user, except: [:index, :create, :new ]

  def index
    # Все пользователи
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    # Аналогично create, мы получаем параметры нового (обновленного)
    # пользователя с помощью метода user_params, и пытаемся обновить @user с
    # этими значениями.
    if @user.update(user_params)
      # Если получилось, отправялем пользователя на его страницу с сообщением,
      # что пользователь успешно обновлен.
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      # Если не получилось, как и в create рисуем страницу редактирования
      # пользователя, на которой нам будет доступен объект @user, содержащий
      # информацию об ошибках валидации, которые отобразит форма.
      render 'edit'
    end
  end

  def show
    # Достаем вопросы пользователя с помощью метода questions, который мы
    # объявили в модели User (has_many :questions), у результата возврата этого
    # метода вызываем метод order, который отсортирует вопросы по дате.
    @questions = @user.questions.order(created_at: :desc)

    # Для формы нового вопроса, которая есть у нас на странице пользователя,
    # создаем болванку вопроса, вызывая метод build у результата вызова метода
    # @user.questions.
    @new_question = @user.questions.build

    # Создаем три счётчика: для количества вопросов, отвеченных вопросов и
    # неотвеченных вопросов
    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  # Действие create будет отзываться при POST-запросе по адресу /users из формы
  # нового пользователя, которая находится в шаблоне на странице /users/new.
  def create
    # создаём нового пользователя с параметрами
    @user = User.new(user_params)

    # Если юзер сохранен, перенаправляем запрос на root, который определн нами в routes
    if @user.save
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
      # Если не удалось по какой-то причине сохранить пользователя, то рисуем
      # (и это не редирект), страницу new с формой пользователя, который у нас
      # лежит в переменной @user. В этом объекте
      # содержатся ошибки валидации, которые выведет шаблон формы.
      render 'new'
    end
  end

  private

  # Ищем юзера, используя в кач-ве идентификатора используем значение id из params
  def load_user
    @user ||= User.find params[:id]
  end

  # Явно задаем список разрешенных параметров для модели User. Мы говорим, что
  # у хэша params должен быть ключ :user. Значением этого ключа может быть хэш с
  # ключами: :email, :password, :password_confirmation, :name, :username и
  # :avatar_url. Другие ключи будут отброшены.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url)
  end
end
