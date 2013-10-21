# Default settings
class Defaults
  # Is there a user?
  # Default says no
  user: false
  # What's the current institution?
  # Default says "NYU"
  institution: 'NYU'
  # What's the login url?
  # Default says "/login"
  login_url: '/login'
  # How do we select our targets?
  # Default to anything with data: eshelf-external-id attribute
  selector: '[data-eshelf-external-id]'
  # How should we create a new record?
  # Default to external system and target external id
  record: (external_system, target) ->
    new window.eshelf.Record
      external_system: external_system
      external_id: $(target).data().eshelfExternalId
  # What should we do on a successful AJAX call
  # Default to some HTML manipulation
  # Context (this) is the controller
  success: (data, status, targets) ->
    institution = @institution
    user = @user
    target_label = @target_label
    login_anchor = @login_anchor
    login_url = @login_url
    $(targets).each (index, target) ->
      if target.checked
        text = if user
                 "In e-Shelf" 
               else 
                 "In guest e-Shelf "+
                 "#{ "(#{login_anchor login_url, "login to save permanently"})" unless @institution is "BHS"}"
      else
        text = "Add to e-Shelf"
      $(target).removeAttr('disabled')
      target_label(target).replaceWith "<label for=\"#{this.id}\">#{text}</label>"
  # What should we do on a unsuccessful AJAX call
  # Default to some different HTML manipulation
  # Context (this) is the controller
  error: (data, status, targets) ->
    if console?
      console.log "Error in e-Shelf CORS API"
      console.log "Status: #{status}"
      console.log data
    target_label = @target_label
    $(targets).each (index, target) ->
      text = "Could not contact e-Shelf"
      target_label(target).replaceWith "<label for=\"#{this.id}\">#{text}</label>"

# Make the Defaults class accessible
window.eshelf ||= {}
window.eshelf.Defaults = Defaults
