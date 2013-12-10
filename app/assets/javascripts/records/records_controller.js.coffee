# Records Controller
#   "Public" methods
#     - toggle(target)
#     - create(target)
#     - destroy(target)
class RecordsController
  # Create or destroy based on the targets checked-ness
  toggle: (target) ->
    $(target).attr('disabled', 'disabled')
    if target.checked then @create target else @destroy target
  # Create a record based on the given target
  create: (target) ->
    text = "Saving..."
    @target_label(target).replaceWith "<label for=\"#{this.id}\">#{text}"+
      "</label>"
    $.ajax @_crud_settings("POST", target)
  # Destroy a record based on the given target
  destroy: (target) ->
    text = "Removing..."
    @target_label(target).replaceWith "<label for=\"#{this.id}\">#{text}"+
      "</label>"
    $.ajax @_crud_settings("DELETE", target)

  # Convenience method to get the target label
  target_label: (target) ->
    $(target).parent().children().last()
  # Convenience method to get the login anchor
  login_anchor: (login_url, anchor_html) ->
    "<a href=\"#{login_url}\">#{anchor_html}</a>"

  # "Private" method to set the CSRF token
  _csrf: (@__csrf) ->
  # "Private" method to get the CSRF header
  _csrf_header: () ->
    'X-CSRF-Token': @__csrf
  # "Private" method to initialize the page.
  # Called by the constructor
  _initialize: () ->
    return if @_initialized
    external_ids = $(@selector).map (index, target) ->
      "external_id[]=#{$(target).data().eshelfExternalId}"
    from_url = "#{@url}/records/from/#{@external_system}.json?per=all&"+
      "#{external_ids.toArray().join("&")}"
    $.ajax from_url, @_initialize_settings($(@selector))
  # "Private" method returns CORS setting
  _initialize_settings: (target) ->
    type: "GET"
    cache: false
    context: @_context(target)
    xhrFields:
      withCredentials: true
    success: (data, status, xhr) ->
      @controller._csrf(xhr.getResponseHeader('X-CSRF-Token'))
      selectors = data.map (datum) ->
        "[data-eshelf-external-id='#{datum.external_id}']"
      $(selectors.join(", ")).attr("checked", true)
      # Show the checkboxes
      $(@controller.selector).show()
      @controller.success(data, status, @target)
      @controller._initialized = true
    error: (data, status, xhr) ->
      $(@target).attr('disabled', 'disabled')
      @controller.error(data, status, @target)

  # "Private" method returns CORS setting
  _crud_settings: (type, target) ->
    type: type
    headers: @_csrf_header()
    context: @_context(target)
    url: @records_url
    crossDomain: true
    xhrFields:
      withCredentials: true
    dataType: "json"
    data:
      record: @record(@external_system, target)
    success: (data, status, xhr) ->
      @controller._csrf(xhr.getResponseHeader('X-CSRF-Token'))
      @controller.success(data, status, @target)
    error: (data, status, xhr) ->
      @controller.error(data, status, @target)

  # "Private" method returns AJAX callback context
  _context: (target) ->
    target: target
    controller: this

  # Constructor
  # URL, selector and record function are required
  constructor: (options) ->
    @url = options.url
    @records_url = "#{@url}/records.json"
    @user = options.user
    @institution = options.institution
    @login_url = options.login_url
    @selector = options.selector
    @external_system = options.external_system
    @record = options.record
    @error = options.error if options.error?
    @success = options.success if options.success?
    @_initialized = false
    @_initialize()

# Make the Record class accessible
window.eshelf ||= {}
window.eshelf.RecordsController = RecordsController
