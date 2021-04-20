class QuestionsController < ApplicationController
  before_action :load_question, only: %i[ show edit update destroy ]
  before_action :authorize_user, except: [:create]

  # GET /questions/1/edit
  def edit
  end

  # Действие create будет отзываться при POST-запросе по адресу /questions из
  # формы нового вопроса, которая находится в шаблоне на странице
  # /questions/edit
  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to user_path(@question.user), notice: 'Вопрос задан'
    else
      render :edit
    end
  end

  # Действие update будет отзываться при PUT-запросе из формы редактирования
  # вопроса, которая находится по адресу /questions/:id, например, /questions/1
  #
  # Перед этим действием сработает before_action :load_questions и в переменной
  # @question у нас будет лежать вопрос с нужным id равным params[:id].
  def update
    if @question.update(question_params)
      redirect_to user_path(@question.user), notice: 'Вопрос сохранен'
    else
      render :edit
    end
  end

  # Действие destroy будет отзываться при DELETE-запросе со страницы
  # пользователя, которая находится по адресу /users/:id/show.
  #
  # Перед этим действием сработает before_action :load_questions и в переменной
  # @question у нас будет лежать вопрос с нужным id равным params[:id].
  def destroy
    # Перед тем, как удалять вопрос, сохраним пользователя, чтобы знать, куда
    # редиректить после удаления.
    user = @question.user

    # Удаляем вопрос
    @question.destroy

    # Отправляем пользователя на страницу адресата вопроса с сообщением
    redirect_to user_path(user), notice: 'Вопрос удален :('
  end

  private

  # Если загруженный из базы вопрос не пренадлежит и текущему залогиненному
  # пользователю — посылаем его с помощью описанного в контроллере
  # ApplicationController метода reject_user.
  def authorize_user
    reject_user unless @question.user == current_user
  end

  # Use callbacks to share common setup or constraints between actions.
  def load_question
    @question = Question.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def question_params
    params.require(:question).permit(:user_id, :text, :answer)
  end
end
