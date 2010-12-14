class SearchController < ApplicationController

  def show
    @posts = Post.published.search(params[:search], :page => params[:posts_page] || 1, :per_page => Post.per_page)
    @questions = Question.search(params[:search], :page => params[:questions_page], :per_page => Question.per_page)
  end
end
