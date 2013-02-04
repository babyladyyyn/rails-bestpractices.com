class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.find_cached_by_name(params[:id])
    if @tag
      params[:nav] ||= "posts"
      nav = params[:nav] == "questsions" ? "questions" : "posts"
      @children = @tag.send(nav)
      @children = @children.published if nav == "posts"
      @children = @children.page(params[:page] || 1)
    else
      render_404
    end
  end
end
