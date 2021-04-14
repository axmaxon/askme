class UsersController < ApplicationController
  def index
    # Создаём массив из трех болванок пользователей. Вызываем метод # User.new,
    # который создает модель, не записывая её в базу.
    # У каждого юзера мы прописали id, чтобы сымитировать реальную
    # ситуацию – иначе не будет работать хелпер путей
    @users = [
      User.new(
        id: 1,
        name: 'Michael',
        username: 'Blain',
        avatar_url: 'https://avatars.mds.yandex.net/get-kinopoisk-image/'\
          '1946459/bf74dda4-fdae-45af-8fe0-2e5fe5776566/280x420'
      ),

      User.new(
        id: 2,
        name: 'Matthew',
        username: 'McCona',
        avatar_url: 'https://avatars.mds.yandex.net/get-kinopoisk-image/'\
          '1704946/c8d88527-94b8-4ef1-b00b-ebfa21d4dc69/960x960'
      ),
      User.new(id: 3, name: 'Misha', username: 'aristofun')
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Michael',
      username: 'blain',
      avatar_url: 'https://avatars.mds.yandex.net/get-kinopoisk-image/'\
        '1946459/bf74dda4-fdae-45af-8fe0-2e5fe5776566/280x420'
    )

    @questions = [
      Question.new(text: 'Как дела?', created_at: Date.parse('27.03.2016'))
    ]
    @new_question = Question.new
  end
end
