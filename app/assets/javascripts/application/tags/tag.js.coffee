# Tag model
class Tag
  # Contructor requires a value
  constructor: (value) ->
    @value = value

  # Returns the tag as a jQuery object
  # Wraps an anchor in a span so the anchor
  # is the jQuery object's html.
  jQuery: () ->
    @_jQuery ||=
      $("<a/>").attr("href", "?tag=#{encodeURIComponent(@value)}").text(@value)

  # Returns the tag as an HTML anchor
  html: () ->
    $("<span/>").append(@jQuery()).html()

# Make the class accessible
window.eshelf ||= {}
window.eshelf.tags ||= {}
window.eshelf.tags.Tag = Tag
