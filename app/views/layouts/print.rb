# app/views/layouts/eshelf.rb
module Views
  module Layouts
    class Print < ActionView::Mustache
      def print_title
        t('application.print_title')
      end

      # Print stylesheet is assumed to be in assets/stylesheets/print.css.
      # Media type is all to to render like it will print in most (all?) browsers.
      def print_stylesheet
        @_view.print_stylesheet :all
      end

      def gauges_tracking_code
        ENV['GAUGES_TOKEN']
      end
    end
  end
end
