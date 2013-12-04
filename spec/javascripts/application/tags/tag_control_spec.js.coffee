#= require application/tags/tag_control
tagControl = new window.eshelf.tags.TagControl
  text: "add"
  icon: "add"

describe "TagControl#text", ->
  it "should be defined", ->
    expect(tagControl.text).toBeDefined()

  it "should have 'add' as the text", ->
    expect(tagControl.text).toEqual "add"

describe "TagControl#icon", ->
  it "should be defined", ->
    expect(tagControl.icon).toBeDefined()

  it "should have 'add' as the icon", ->
    expect(tagControl.icon).toEqual "add"

describe "TagControl#iconClass", ->
  it "should be defined", ->
    expect(tagControl.iconClass).toBeDefined()

  it "should have 'icons-famfamfam-add' as the famfam class", ->
    expect(tagControl.iconClass).toEqual "icons-famfamfam-add"

describe "TagControl#jQuery", ->
  it "should be defined", ->
    expect(tagControl.jQuery()).toBeDefined()

describe "TagControl#html", ->
  it "should be defined", ->
    expect(tagControl.html()).toBeDefined()

  it "should be an HTML anchor tag", ->
    expect(tagControl.html()).toEqual(
      "<a href=\"#\" class=\"muted btn btn-mini\" style=\"display: none; \">"+
        "<i class=\"icons-famfamfam-add\"></i><span>add</span></a>")

addControl = new window.eshelf.tags.AddControl

describe "AddControl#text", ->
  it "should be defined", ->
    expect(addControl.text).toBeDefined()

  it "should have 'add' as the text", ->
    expect(addControl.text).toEqual "add"

describe "AddControl#icon", ->
  it "should be defined", ->
    expect(addControl.icon).toBeDefined()

  it "should have 'add' as the icon", ->
    expect(addControl.icon).toEqual "add"

describe "AddControl#iconClass", ->
  it "should be defined", ->
    expect(addControl.iconClass).toBeDefined()

  it "should have 'icons-famfamfam-add' as the famfam class", ->
    expect(addControl.iconClass).toEqual "icons-famfamfam-add"

describe "AddControl#jQuery", ->
  it "should be defined", ->
    expect(addControl.jQuery()).toBeDefined()

describe "AddControl#html", ->
  it "should be defined", ->
    expect(addControl.html()).toBeDefined()

  it "should be an HTML anchor tag", ->
    expect(addControl.html()).toEqual(
      "<a href=\"#\" class=\"muted btn btn-mini\" style=\"display: none; \">"+
        "<i class=\"icons-famfamfam-add\"></i><span>add</span></a>")

editControl = new window.eshelf.tags.EditControl

describe "EditControl#text", ->
  it "should be defined", ->
    expect(editControl.text).toBeDefined()

  it "should have 'edit' as the text", ->
    expect(editControl.text).toEqual "edit"

describe "EditControl#icon", ->
  it "should be defined", ->
    expect(editControl.icon).toBeDefined()

  it "should have 'edit' as the icon", ->
    expect(editControl.icon).toEqual "pencil_add"

describe "EditControl#iconClass", ->
  it "should be defined", ->
    expect(editControl.iconClass).toBeDefined()

  it "should have 'icons-famfamfam-pencil_add' as the famfam class", ->
    expect(editControl.iconClass).toEqual "icons-famfamfam-pencil_add"

describe "EditControl#jQuery", ->
  it "should be defined", ->
    expect(editControl.jQuery()).toBeDefined()

describe "EditControl#html", ->
  it "should be defined", ->
    expect(editControl.html()).toBeDefined()

  it "should be an HTML anchor tag", ->
    expect(editControl.html()).toEqual(
      "<a href=\"#\" class=\"muted btn btn-mini\" style=\"display: none; \">"+
        "<i class=\"icons-famfamfam-pencil_add\"></i><span>edit</span></a>")

saveControl = new window.eshelf.tags.SaveControl

describe "SaveControl#text", ->
  it "should be defined", ->
    expect(saveControl.text).toBeDefined()

  it "should have add as the text", ->
    expect(saveControl.text).toEqual "save"

describe "SaveControl#icon", ->
  it "should be defined", ->
    expect(saveControl.icon).toBeDefined()

  it "should have 'disk' as the icon", ->
    expect(saveControl.icon).toEqual "disk"

describe "SaveControl#tagUpdateSpy", ->
  it "should be defined", ->
    expect(saveControl.iconClass).toBeDefined()

  it "should have 'icons-famfamfam-disk' as the famfam class", ->
    expect(saveControl.iconClass).toEqual "icons-famfamfam-disk"

describe "SaveControl#jQuery", ->
  it "should be defined", ->
    expect(saveControl.jQuery()).toBeDefined()

describe "SaveControl#html", ->
  it "should be defined", ->
    expect(saveControl.html()).toBeDefined()

  it "should be an HTML anchor tag", ->
    expect(saveControl.html()).toEqual(
      "<a href=\"#\" class=\"muted btn btn-mini\" style=\"display: none; \">"+
        "<i class=\"icons-famfamfam-disk\"></i><span>save</span></a>")

controlSet = new window.eshelf.tags.ControlSet {}

describe "ControlSet#controls", ->
  it "should be defined", ->
    expect(controlSet.controls).toBeDefined()

  # it "has a controlSet with the expected tags", ->
  #   expect(controlSet.controls).toEqual
  #     add: new window.eshelf.tags.AddControl
  #     edit: new window.eshelf.tags.EditControl
  #     save: new window.eshelf.tags.SaveControl
