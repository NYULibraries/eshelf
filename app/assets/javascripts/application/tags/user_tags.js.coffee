# UserTags
class UserTags
  # Contructor requires a container
  constructor: (container) ->
    @container = $(container)
    @form = @container.prevAll('form')
    @url = @form.attr("action")
    @input = $("input[name='tag']", @form)
    @disabled = false
    # Need to put @ in the referencing environment for the closures
    # so we set it to a local variable, userTags
    userTags = @
    # RecordTagger triggers a "tagListSaved" event from document on a successful
    # save of a tag list.  Bind an event handler to that event which updates the
    # user's tags.
    $(document).bind "tagListSaved", (event) ->
      userTags.filter(userTags.input.val())
    # Disable the user's tags search form
    @form.submit (event)-> false
    # and attach a typeahead
    @input.typeahead
      minLength: 0
    ,
      source: (query, process) -> userTags.filter(query)
    # and attach a handler to the keyup event to handle
    # a cleared input field
    # http://stackoverflow.com/questions/4403444/jquery-how-to-trigger-an-event-when-the-user-clear-a-textbox
    @input.keyup (event) ->
      userTags.filter() unless userTags.input.val().length >> 0
    @enableNext()
    # Filter with no input to initialize
    @filter()

  size: () ->
    $('.tags-list > li', @container).length

  height: () ->
    @container.height()

  enableNext: () ->
    # Need to put @ in the referencing environment for the closures
    # so we set it to a local variable, userTags
    userTags = @
    @container.on "scroll", () ->
      if userTags.container.scrollTop() > userTags.height() - 200
        userTags.next userTags.input.val()

  handleNext: (response) ->
    # Set the scrollbar style
    if @height() < $('.tags-list', @container).height()
      @container.addClass("scroll")
    else
      @container.removeClass("scroll")
    if $("li", response).length < 20
      @container.off "scroll"

  # Filter based on the query
  filter: (query) ->
    # (Re)Set current page
    @currentPage = 1
    # Need to put @ in the referencing environment for the closures
    # so we set it to a local variable, userTags
    userTags = @
    # Get the tags-list and replace container with response
    @get query, (response) ->
      userTags.enableNext()
      userTags.container.html response

  # Append the next page
  next: (query) ->
    unless @disabled
      # Increment current page
      @currentPage++
      # Need to put @ in the referencing environment for the closures
      # so we set it to a local variable, userTags
      userTags = @
      # Get the tags list and append response to tag list
      @get query, (response) ->
        $(".tags-list", userTags.container).append($("li", response))

  # Get the user tags
  get: (query, manipulate) ->
    # Set the data
    data =
      page: @currentPage
      tag: query if query?
    # Need to put @ in the referencing environment for the closures
    # so we set it to a local variable, userTags
    userTags = @
    # The callback manipulates the response and
    # disables next if appropriate
    @disabled = true
    callback = (response) ->
      manipulate response
      userTags.disabled = false
      userTags.handleNext response
    # and make the call
    $.get @url, data, callback, "html"

  # UserTags as an HTML string
  html: () ->
    $("<span/>").append(@container).html()

# Make the class accessible
window.eshelf ||= {}
window.eshelf.tags ||= {}
window.eshelf.tags.UserTags = UserTags
