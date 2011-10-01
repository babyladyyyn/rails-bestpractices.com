class QuestionBody < ActiveRecord::Base
  include Markdownable

  belongs_to :question

  validates_presence_of :body

  def initialize(options={})
    super
    self.body = " Before
------

description

    # some codes
    # before

description

Refactor
--------

description

    # somes codes
    # after refactor

description
"
  end
end
