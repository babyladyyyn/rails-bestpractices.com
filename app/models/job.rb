# == Schema Information
#
# Table name: jobs
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  description :text
#  company     :string(255)
#  company_url :string(255)
#  country     :string(255)
#  state       :string(255)
#  city        :string(255)
#  address     :string(255)
#  salary      :string(255)
#  apply_email :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer(4)
#  published   :boolean(1)
#  source      :string(255)
#  external_id :integer(4)
#

class Job < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Cacheable

  has_many :job_job_types
  has_many :job_types, :through => :job_job_types, :source => :job_type
  belongs_to :user

  validates_presence_of :title, :company, :country, :city, :description, :apply_email

  scope :published, -> { where(:published => true) }
  scope :owner, -> { where("source IS NULL") }

  after_create :notify_admin

  model_cache do
    with_key
    with_method :job_type_names
    with_association :user
  end

  def job_type_names
    self.job_types.map(&:name)
  end

  def location
    [self.state, self.city, self.country].compact.join(', ')
  end

  def tweet_title
    "#{company} is looking for #{title} in #{location}"
  end

  def tweet_path
    "jobs/#{to_param}"
  end

  def publish!
    self.update_attribute(:published, true)
    # Delayed::Job.enqueue(DelayedJob::Tweet.new('Job', self.id))
  end

  protected
    def notify_admin
      Delayed::Job.enqueue(DelayedJob::NotifyJob.new(self.id))
    end
end
