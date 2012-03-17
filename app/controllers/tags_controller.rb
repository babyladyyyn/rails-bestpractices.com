class TagsController < ApplicationController
  def show
    @tag = ActsAsTaggableOn::Tag.find_cached_by_name(params[:id])
    if @tag
      params[:nav] ||= "posts"
      @children = @tag.send(params[:nav])
      @children = @children.published if params[:nav] == "posts"
      @children = @children.page(params[:page] || 1)
    else
      render_404
    end
  end
end
