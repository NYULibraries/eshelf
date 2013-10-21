ActiveSupport.on_load(:after_initialize) do
  ezproxy = "https://ezproxy.library.nyu.edu/login?url="
  ExCite.acts_as_citable_class = "Record"
  # Setting it to a redirect with callback here, leave the default as form, RefWorks likes it better 
  ExCite.refworks.url= ezproxy + ExCite.refworks.url
  ExCite.refworks.action= :redirect
  ExCite.endnote.url= ezproxy + ExCite.endnote.url
end
