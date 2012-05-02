module Markdownable
  def self.included(base)
    base.class_eval do
      before_save :generate_formatted_html
      after_initialize :init_body
    end
  end

  def init_body
    self.body ||= "## Before

description

    # some codes
    # before

description

## Refactor

description

    # somes codes
    # after refactor

description"
  end

  def generate_formatted_html
    self.formatted_html = RDiscount.new(body).to_html
  end
end
