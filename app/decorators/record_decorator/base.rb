require 'delegate'
module RecordDecorator
  # Base class for decorating Records
  # Takes an optional controller
  #
  # Author::    scotdalton
  # Copyright:: Copyright (c) 2013 New York University
  # License::   Distributes under the same terms as Ruby
  class Base < SimpleDelegator
    attr_reader :view_context, :base
    protected :base

    # Initialize with a record and an optional view_context
    def initialize(*args)
      @view_context = args.pop if args.length > 1
      @base = args.shift
      super(@base)
      # "Inherit" view context from base, if available and it wasn't given
      @view_context ||= base.view_context if base.respond_to? :view_context
    end

    def citation_attributes
      @citation_attributes ||= send("#{citation_style}_attributes".to_sym) if respond_to?("#{citation_style}_attributes".to_sym)
    end

    def collect_citation_attributes
      # Collect the attributes,
      # only keep them if they are not blank
      citation_attributes.collect { |attribute| send(attribute.to_sym) }.
        delete_if { |attribute| attribute.blank? } unless citation_attributes.nil?
    end
  end
end
