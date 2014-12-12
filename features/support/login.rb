UserSession.class_eval do
  def attempt_sso?
    false
  end
end
