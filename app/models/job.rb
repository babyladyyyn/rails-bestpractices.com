class Job < ActiveRecord::Base
  has_many :job_job_types
  has_many :job_types, :through => :job_job_types, :source => :job_type

  validates_presence_of :title, :company, :country, :state, :city, :description

  def location
    [self.state, self.city].join(', ')
  end
end
