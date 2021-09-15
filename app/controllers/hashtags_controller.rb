class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.relevant.find_by!(name: params[:name])
    @questions = @hashtag.questions
  end
end
