class TagDecorator < ApplicationDecorator
  decorates :tag

  def link
    h.link_to name, h.tag_path(name)
  end
end
