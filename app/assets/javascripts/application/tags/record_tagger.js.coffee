class RecordTagger
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
    # Create the tag controls for this tagger and attach the 
    # relevant event handlers to them
    @controlSet = new window.eshelf.tags.ControlSet
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
    # Attach the "save" event handler to the form submit event
    @form.submit (event) -> recordTagger.save event, recordTagger
    # Start out in a saved state
    @saved @

  # Event handler for editing the tag list
  edit: (recordTagger) ->
    # Remove the tags
    recordTagger.removeTags()
    # Show the save control
    recordTagger.controlSet.showSave()
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
    # Remove this record tagger if it's already in the DOM
    $("##{@id}").remove()
    # Hide the input, since we've saved
    recordTagger.input.hide()
    # Append this record tagger to the parent in the DOM
    recordTagger.parent.append(@jQuery())
    # If we don't have any tags, show the "Add" control
    # otherwise show the "Edit" control
    if recordTagger._tagList.size() is 0 
      recordTagger.controlSet.showAdd()
    else
      recordTagger.controlSet.showEdit()

  # Remove tags from the DOM and from this record tagger
  removeTags: () ->
    @_tags.remove()
    @_tags = null

  # Returns a tag list based on comma separated tags in the input
  # This function is "live" so it always processes based on the current state
  # of the tag list input.
  tagList: () ->
    tags = []
    # Split the input values based on a comma unless there is nothing there.
    tags = @input.val().split(', ') unless @input.val().length is 0
    # and pass them to the parent
    @_tagList = new window.eshelf.tags.TagList tags...

  # Returns the jQuery'd tag list
  tags: () ->
    @_tags ||= @tagList().jQuery()

  # Returns the jQuery'd control set
  controls: () ->
    @_controls ||= @controlSet.jQuery()

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
