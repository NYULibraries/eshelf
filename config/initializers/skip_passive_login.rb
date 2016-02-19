ApplicationController.class_eval do
  skip_before_filter :passive_login, if: -> { Rails.env.test? }
end
