# This is a hack because the aleph account url redirects to the bobcat cleanup script
# the first time it logs into PDS, which is not over HTTPS so the iframe won't load
# once logged into PDS this is a non-issue. This can be removed when and if we can
# get rid of the cleanup redirect in PDS
$ ->
  reload_iframe = ->
    $('#aleph_account').ready ->
      if (!window.location.hash)
        window.location = window.location + '#loaded'
        window.location.reload()

  setTimeout(reload_iframe, 2000)
