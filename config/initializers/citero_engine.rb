ActiveSupport.on_load(:after_initialize) do
  ezproxy = "https://proxy.library.nyu.edu/login?url="
  CiteroEngine.acts_as_citable_class = "Record"
  # Setting it to a redirect with callback here, leave the default as form, RefWorks likes it better
  CiteroEngine.refworks.url= ezproxy + CiteroEngine.refworks.url
  CiteroEngine.refworks.action= :redirect
  CiteroEngine.endnote.url= ezproxy + CiteroEngine.endnote.url
end
