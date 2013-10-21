# Required data attributes
#   - external system: external system being used
# 
# Optional data attributes
#   - user: boolean indicating if this is a logged in user
#   - selector: selector for eshelf elements
#   - record: function that returns a record given a target
#   - success: callback function that gets called by the records controller on success
#   - error: callback function that gets called by the records controller
#   - records_controller: function that returns a records controller
# 
# Sprockets 'requires'
#   - include jquery and all records classes
# 
#= require jquery
#= require modernizr
#= require_tree ./records
_eshelf = _eshelf || [];
((src, options) ->
  _eshelf =
    # Defaults
    defaults: @_defaults ||= new window.eshelf.Defaults
    # URL for the CORS request
    url: () ->
      src.replace('/assets/records.js', '')
    # Required data attributes
    #   - external system: external system being used
    external_system: () ->
      options.eshelfExternalSystem
    # Optional data attributes
    #   - user: boolean indicating if this is a logged in user
    #   - institution: scurrent institution string
    #   - login-url: login URL string
    #   - selector: selector for eshelf elements
    #   - record: function that returns a record given a target
    #   - success: callback function that gets called by the records controller on success
    #   - error: callback function that gets called by the records controller
    user: () ->
      @_user ||= (options.eshelfUser || @defaults.user)
    institution: () ->
      @_institution ||= (options.eshelfInstitution || @defaults.institution)
    login_url: () ->
      @_login_url ||= (options.eshelfLoginUrl || @defaults.login_url)
    selector: () ->
      @_selector ||= (options.eshelfSelector || @defaults.selector)
    record: () ->
      @_record ||= (window[options.eshelfRecord] || @defaults.record)
    success: () ->
      @_success ||= (window[options.eshelfSuccess] || @defaults.success)
    error: () ->
      @_error ||= (window[options.eshelfError] || @defaults.error)

  # Instantiate a records controller.
  records_controller = new window.eshelf.RecordsController
    url: _eshelf.url()
    user: _eshelf.user()
    institution: _eshelf.institution()
    login_url: _eshelf.login_url()
    selector: ".cors " + _eshelf.selector()
    success: _eshelf.success()
    error: _eshelf.error()
    external_system: _eshelf.external_system()
    record: _eshelf.record()

  # Set up the on click event for the targets
  $(document).on('click', _eshelf.selector(), (event) -> records_controller.toggle(event.target))
)($('.cors #eshelf-records-controller').attr('src'), $('.cors #eshelf-records-controller').data())
