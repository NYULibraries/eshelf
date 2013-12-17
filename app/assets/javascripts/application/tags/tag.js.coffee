# Tag model
class Tag
  # Contructor requires a value
  constructor: (value, institution) ->
    @value = value
    @institution = institution

  # Returns the tag as a jQuery object
  # Wraps an anchor in a span so the anchor
  # is the jQuery object's html.
  jQuery: () ->
    return @_jQuery if @_jQuery
    href = "?tag=#{encodeURIComponent(@value)}"
    if @institution
      href += "&institution=#{encodeURIComponent(@institution)}"
    @_jQuery = $("<a/>").attr("href", href).text(@value)

  # Returns the tag as an HTML anchor
  html: () ->
    $("<span/>").append(@jQuery()).html()

# Make the class accessible
window.eshelf ||= {}
window.eshelf.tags ||= {}
window.eshelf.tags.Tag = Tag
