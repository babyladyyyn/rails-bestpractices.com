ActsAsTaggableOn::Tag.class_eval do
  attr_accessible :name, :important
end

RailsAdmin.config do |config|

  config.current_user_method { current_user } #auto-generated
  config.authorize_with :cancan

  config.included_models = %w(Answer AnswerBody BlogPost Comment Job JobType JobJobType JobPartner Notification NotificationSetting Page Post PostBody Question QuestionBody Sponsor SponsorTrack User Vote Delayed::Job ActsAsTaggableOn::Tag)

  config.model BlogPost do
    edit do
      field :title
      field :body do
        ckeditor true
      end
      field :user
    end
  end

  config.model Job do
    list do
      field :title
      field :published
      field :source
      field :apply_email
    end
    edit do
      field :title
      field :description do
        ckeditor true
      end
      field :published
      field :source
      field :apply_email
    end
  end
end
