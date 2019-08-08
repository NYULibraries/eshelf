module LayoutsHelper

  def google_analytics?
    google_analytics_tracking_code.present?
  end

  def google_analytics_tracking_code
    ENV['GOOGLE_ANALYTICS_TRACKING_CODE']
  end

  def google_tag_manager_tracking_code
    ENV['GOOGLE_TAG_MANAGER_TRACKING_CODE']
  end

  # Add e-Shelf to the bread crumbs
  def breadcrumbs
    super << "e-Shelf"
  end

  # Back to icon and link
  def back_to
    nil
  end

  def print_title
    t('application.print_title')
  end

  # Print stylesheet is assumed to be in assets/stylesheets/print.css.
  # Media type is all to to render like it will print in most (all?) browsers.
  def print_stylesheet
    stylesheet_link_tag "print", media: :all
  end

end
