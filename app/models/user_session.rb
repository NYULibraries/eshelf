class UserSession < Authlogic::Session::Base
  pds_url (ENV['PDS_URL'] || 'https://login.library.nyu.edu')
  redirect_logout_url 'http://bobcat.library.nyu.edu'
  calling_system "eshelf"
  institution_param_key "institution"

  # If this is a JSON request, don't attempt SSO.
  # Otherwise, defer to super.
  def attempt_sso?
    (controller.request.format.json?) ? false : super
  end
end
