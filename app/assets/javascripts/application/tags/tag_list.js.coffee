class TagList
  constructor: (attributes) ->
    @input = attributes.input
    # Split the input values based on a comma
    values = $(@input).val().split(', ')
    # Create an array of tags from the input values
    @tags = (new window.eshelf.tags.Tag(value: value) for value in values)

# Make the Tag class accessible
window.eshelf ||= {}
window.eshelf.tags ||= {}
window.eshelf.tags.TagList = TagList
