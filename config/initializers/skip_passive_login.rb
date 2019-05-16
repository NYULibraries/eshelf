ApplicationController.class_eval do
  skip_before_action :passive_login, if: -> { Rails.env.test? }
end
