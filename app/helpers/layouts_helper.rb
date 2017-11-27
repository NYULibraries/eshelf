module LayoutsHelper

  def gauges_tracking_code
    ENV['GAUGES_TOKEN']
  end

  # Add e-Shelf to the bread crumbs
  def breadcrumbs
    super << "e-Shelf"
  end

  # Back to icon and link
  def back_to
    (icon_tag(:back) + link_to_back) if link_to_back
  end

  # Back to link
  def link_to_back
    link_to wayfinder.text, wayfinder.url if wayfinder.match?
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
