# app/views/layouts/eshelf.rb
module Views
  module Layouts
    class Eshelf < ActionView::Mustache

      # Yep, we have a print stylesheet.
      def print_stylesheet?
        true
      end

      def gauges_tracking_code
        Settings.gauges.tracking_code
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
    end
  end
end
