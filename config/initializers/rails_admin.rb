RailsAdmin.config do |config|
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
end
