class SearchController < ApplicationController
  def show
    search = params[:search].gsub("/", " ")
    @posts = Post.search(search, :page => params[:posts_page] || 1, :per_page => 10)
    @questions = Question.search(search, :page => params[:questions_page] || 1, :per_page => 10)
  end
end
