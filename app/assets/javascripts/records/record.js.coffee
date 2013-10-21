# Record Model
class Record
  # Contructor requires external system and external id.
  # Other attributes are optional
  constructor: (attributes) ->
    @external_system = attributes.external_system
    @external_id = attributes.external_id
    @format = attributes.format if attributes.format?
    @data = attributes.data if attributes.data?
    @title = attributes.title if attributes.title?
    @author = attributes.author if attributes.author?
    @url = attributes.url if attributes.url?
    @content_type = attributes.content_type if attributes.content_type?
    @title_sort = attributes.title_sort if attributes.title_sort?

# Make the Record class accessible
window.eshelf ||= {}
window.eshelf.Record = Record
