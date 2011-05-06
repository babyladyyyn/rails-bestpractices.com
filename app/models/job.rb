class Job < ActiveRecord::Base
  has_many :job_job_types
  has_many :job_types, :through => :job_job_types, :source => :job_type
  belongs_to :user

  validates_presence_of :title, :company, :country, :state, :city, :description

  scope :published, where(:published => true)

  after_create :notify_admin

  def location
    [self.state, self.city].join(', ')
  end

  def tweet_title
    "#{company} is looking for a #{title} in #{location}, #{country}"
  end

  def tweet_path
    "jobs/#{to_param}"
  end

  def publish!
    self.update_attribute(:published, true)
    Delayed::Job.enqueue(DelayedJob::Tweet.new('Job', self.id))
  end

  protected
    def notify_admin
      Delayed::Job.enqueue(DelayedJob::NotifyJob.new(self.id))
    end
end
