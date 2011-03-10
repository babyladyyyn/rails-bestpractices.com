class SearchController < ApplicationController

  def show
    @posts = Post.published.search(params[:search], :page => params[:posts_page] || 1, :per_page => Post.default_per_page)
    @questions = Question.search(params[:search], :page => params[:questions_page] || 1, :per_page => Question.default_per_page)
  end
end
