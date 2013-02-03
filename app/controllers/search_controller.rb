class SearchController < ApplicationController
  def show
    @posts = Post.search(params[:search], :page => params[:posts_page] || 1, :per_page => 10)
    @questions = Question.search(params[:search], :page => params[:questions_page] || 1, :per_page => 10)
  end
end
