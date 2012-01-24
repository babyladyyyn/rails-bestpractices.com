RailsAdmin.config do |config|

  config.current_user_method { current_user } #auto-generated
  config.authorize_with :cancan

  config.excluded_models << "Authentication"

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
    end
    edit do
      field :title
      field :description do
        ckeditor true
      end
      field :published
      field :source
    end
  end
end
