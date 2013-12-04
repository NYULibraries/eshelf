class TagList
  constructor: (tags...) ->
    # Create an array of tags from the given values
    @tags = []
    @tags = (new window.eshelf.tags.Tag(tag) for tag in tags)

  size: () ->
    @tags.length

  jQuery: ()->
    @_jQuery ||= $("<span/>").append((tag.html() for tag in @tags).join(", "))

  html: () ->
    $("<span/>").append(@jQuery()).html()

# Make the class accessible
window.eshelf ||= {}
window.eshelf.tags ||= {}
window.eshelf.tags.TagList = TagList
