class RecordTagger
  # Contructor requires an input
  constructor: (input) ->
    # jQuery the input
    @input = $(input)
    # Get the form associated with the input
    @form = @input.closest("form")
    # Get the input's parent
    @parent = @input.parent()
    # Get the record id
    # Input IDs are of the form NNN_record_tag_list
    @recordId = parseInt (/^[0-9]+/.exec @input.attr("id")).shift()
    # Set the ID for this record tagger based on the record id
    @id = "#{@recordId}_record_tagger"
    # Need to put @ in the referencing environment for the closure
    # so we set it to a local variable, recordTagger
    recordTagger = @
    # Attach the "save" event handler to the form submit event
    @form.submit (event) -> recordTagger.save recordTagger
    # Start out in a saved state
    @saved @

  # Refresh the RecordTagger
  refresh: () ->
    # Remove this record tagger if it's already in the DOM
    $("##{@id}").remove()
    # Reset the instance vars
    @_tags = null
    @_tagList = null
    @_controlSet = null
    @_controls = null
    # Append this record tagger to the parent in the DOM
    @parent.append(@jQuery())

  # Event handler for editing the tag list
  edit: (recordTagger) ->
    # Refresh the tagger
    recordTagger.refresh()
    # Hide the tags
    recordTagger.tags().hide()
    # Show the save control
    recordTagger.controlSet().showSave()
    # Show the tags input field
    recordTagger.input.show()

  # Event handler for saving the tag list
  save: (recordTagger) ->
    # Get the URL to which we're posting the tag list from the form
    url = recordTagger.form.attr("action")
    # Get the data from the form
    data = recordTagger.form.serialize()
    # Need to put @saved in the referencing environment for the closure
    # so we set it to a local variable
    saved = () -> recordTagger.saved(recordTagger)
    # Post the data (RESTfully saving)
    $.post url, data, (data, textStatus, jqXHR) ->
      # Callback to saved on success.
      saved()
      # If it successfully saved, we want to trigger a tagListSaved event
      $(document).trigger("tagListSaved")

  # Callback after a successful save
  saved: (recordTagger) ->
    recordTagger.refresh()
    # Hide the input, since we've saved
    recordTagger.input.hide()
    # Show the tags
    recordTagger.tags().show()
    # If we don't have any tags, show the "Add" control
    # otherwise show the "Edit" control
    if recordTagger.tagList().size() is 0
      recordTagger.controlSet().showAdd()
    else
      recordTagger.controlSet().showEdit()

  # Returns a string array of tags based on comma separated tags in the input
  parseTags: () ->
    parsedTags = []
    # Split the input values based on a comma unless there is nothing there.
    parsedTags = @input.val().split(', ') unless @input.val().length is 0
    parsedTags

  # Returns a tag list based on parsed tags from the input
  tagList: () ->
    # Parse the tags and pass them to the parent
    @_tagList ||= new window.eshelf.tags.TagList @parseTags()...

  # Returns the jQuery'd tag list
  tags: () ->
    @_tags ||= @tagList().jQuery()

  # Create the tag controls for this tagger and attach the
  # relevant event handlers to them
  controlSet: () ->
    # Need to put @ in the referencing environment for the closure
    # so we set it to a local variable, recordTagger
    recordTagger = @
    @_controlSet ||= new window.eshelf.tags.ControlSet
      add: (event) ->
        recordTagger.edit recordTagger
        event.preventDefault()
        event.stopImmediatePropagation()
      edit: (event) ->
        recordTagger.edit recordTagger
        event.preventDefault()
        event.stopImmediatePropagation()
      save: (event) ->
        recordTagger.save recordTagger
        event.preventDefault()
        event.stopImmediatePropagation()

  # Returns the jQuery'd control set
  controls: () ->
    @_controls ||= @controlSet().jQuery()

  # RecordTagger as a jQuery Object
  # This function is "live" since tags change and we want to get
  # updates based on the latest from the tag list input
  jQuery: () ->
    $("<span/>").attr("id", @id).append(@tags()).append(@controls())

  # RecordTagger as an HTML string
  # This function is "live" since tags change and we want to get
  # updates based on the latest from the tag list input
  html: () ->
    $("<span/>").append(@jQuery()).html()

# Make the class accessible
window.eshelf ||= {}
window.eshelf.tags ||= {}
window.eshelf.tags.RecordTagger = RecordTagger
