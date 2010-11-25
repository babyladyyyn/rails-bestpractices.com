class TweetObserver < ActiveRecord::Observer
  observe :post, :implementation, :question

  def after_create(model)
    Delayed::Job.enqueue(DelayedJob::Tweet.new(model.class.to_s, model.id))
  end
end
