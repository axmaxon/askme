class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(id: params[:id]) or not_found
    @questions = @hashtag.questions
  end
end
