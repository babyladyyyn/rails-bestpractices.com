class TagsController < InheritedResources::Base
  actions :show

  show! do |format|
    if @tag
      params[:nav] ||= "posts"
      @children = @tag.send(params[:nav])
      @children = @children.published if params[:nav] == "posts"
      @children = @children.includes(:user, :tags).page(params[:page].to_i)
    else
      format.html { render_404 }
    end
  end

  protected
    def resource
      @tag = ActsAsTaggableOn::Tag.find_by_name(params[:id])
    end
end
