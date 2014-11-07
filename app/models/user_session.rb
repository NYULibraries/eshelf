class UserSession < Authlogic::Session::Base
  pds_url Settings.pds.login_url
  redirect_logout_url Settings.pds.logout_url
  calling_system "eshelf"
  institution_param_key "institution"

  # If this is a JSON request, don't attempt SSO.
  # Otherwise, defer to super.
  def attempt_sso?
    (controller.request.format.json?) ? false : super
  end
end
