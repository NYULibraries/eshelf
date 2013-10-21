# Module for namespacing record decorators. 
# Includes convenience methods for attaining a decorated record:
#   ::email - returns an email decorated record with expected decorator nesting
#   ::print - returns a print decorated record with expected decorator nesting
#   ::institution - returns an institution decorated record with expected decorator nesting
#
# Author::    scotdalton
# Copyright:: Copyright (c) 2013 New York University
# License::   Distributes under the same terms as Ruby
module RecordDecorator
  # Returns an email decorated record with expected decorator nesting
  def self.email(*args)
    EmailDecorator.new(_content_type(*args))
  end

  # Returns a print decorated record with expected decorator nesting
  def self.print(*args)
    PrintDecorator.new(_content_type(*args))
  end

  # Returns a content type record with expected decorator nesting
  # For internal use.
  def self._content_type(*args)
    _attribute_decorator(:content_type, _citation(*args))
  end

  # Returns a citation record with expected decorator nesting
  # For internal use.
  def self._citation(*args)
    citation_style = args.pop
    CitationDecorator.new(_label(*args), citation_style)
  end

  # Returns a labeled record with expected decorator nesting
  # For internal use.
  def self._label(*args)
    LabelDecorator.new(_normalize(*args))
  end

  # Returns a normalized record with expected decorator nesting
  # For internal use.
  def self._normalize(*args)
    NormalizeDecorator.new(*args)
  end

  # Returns a record decorated by the given attribute
  # For internal use.
  def self._attribute_decorator(attribute, *args)
    record = args.shift
    ("RecordDecorator::#{record.send(attribute.to_sym).capitalize}Decorator".safe_constantize) ? 
      "RecordDecorator::#{record.send(attribute.to_sym).capitalize}Decorator".safe_constantize.new(record, *args) : record
  end
end
