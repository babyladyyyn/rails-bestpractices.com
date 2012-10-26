class NotifierObserver < ActiveRecord::Observer
  observe :answer

  def after_create(model)
    notify(model)
  end

  def before_destroy(model)
    destroy(model)
  end

  private
    def notify(model)
      if model.is_a?(Answer) && model.question.user != model.user
        model.question.user.notifications.create(:notifierable => model)
      end
    end

    def destroy(model)
      Notification.where(:notifierable_id => model.id, :notifierable_type => model.class.to_s).map(&:destroy)
    end
end
