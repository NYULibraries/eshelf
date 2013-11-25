# Tag model
class Tag
  # Contructor requires a record id and the value
  constructor: (attributes) ->
    @value = attributes.value

  # Returns the tag as a jQuery object
  # Wraps an anchor in a span so the anchor
  # is the jQuery object's html.
  to_jquery: () ->
    $("<a/>").attr("href", "?tag=#{encodeURIComponent(@value)}").text(@value)

  # Returns the tag as an HTML anchor
  to_html: () ->
   $("<span/>").append(@to_jquery()).html()

# Make the Tag class accessible
window.eshelf ||= {}
window.eshelf.tags ||= {}
window.eshelf.tags.Tag = Tag
