class UsersController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Michael',
      username: 'blain',
      avatar_url: 'https://avatars.mds.yandex.net/get-kinopoisk-image/1946459/bf74dda4-fdae-45af-8fe0-2e5fe5776566/280x420'
    )
  end
end
