describe "including the CORS records' javascript,", ->
  it "doesn't throw an error", ->
    include_fn = ()->
      t = document.createElement 'script'
      t.type  = 'text/javascript'
      t.async = true
      t.id    = 'eshelf-records-controller'
      t.setAttribute 'data-eshelf-external-system', 'primo'
      t.src = "./"
      s = document.getElementsByTagName('script')[0]
      s.parentNode.insertBefore(t, s)
    expect(include_fn()).not.toThrow
