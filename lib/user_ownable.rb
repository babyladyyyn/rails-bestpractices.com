module UserOwnable

  def self.included(base)
    base.class_eval do
      belongs_to :user, :counter_cache => true
    end
  end

end
