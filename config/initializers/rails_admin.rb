module RailsAdmin
  module Config
    module Actions
      class Publish < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          bindings[:object].respond_to? :publish!
        end

        register_instance_option :member do
          true
        end

        register_instance_option :http_methods do
          [:get]
        end

        register_instance_option :authorization_key do
          :publish
        end

        register_instance_option :controller do
          Proc.new do
            @object.publish!
            redirect_to :back
          end
        end

        register_instance_option :link_icon do
          'icon-ok-sign'
        end
      end
    end
  end
end

RailsAdmin.config do |config|
  config.actions do
    # root actions
    dashboard                     # mandatory
    # collection actions
    index                         # mandatory
    new
    export
    history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app
    publish
  end

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

  config.model Post do
    list do
      field :title
      field :published
      field :user
    end
  end
end
