class NotifierObserver < ActiveRecord::Observer
  observe :comment, :answer
  
  def after_create(model)
    notify(model)
  end

  def before_destroy(model)
    destroy(model)
  end

  private
    def notify(model)
      if model.is_a? Comment
        model.commentable.user.notifications.create(:notifierable => model)
      elsif model.is_a? Answer
        model.question.user.notifications.create(:notifierable => model)
      end
    end

    def destroy(model)
      Notification.where(:notifierable_id => model.id, :notifierable_type => model.class.to_s).first.destroy
    end
end
