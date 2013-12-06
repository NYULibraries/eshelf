#= require application/tags/tag_control
fixture.preload 'tags/controls.html'
describe "TagControl", ->
  tagControl = null
  beforeEach ->
    @fixtures = fixture.load 'tags/controls.html', true
    controls = $(".controls", fixture.el)
    tagControl = new window.eshelf.tags.TagControl
      text: "add"
      icon: "add"
    controls.append tagControl.jQuery()

  describe "#text", ->
    it "should be defined", ->
      expect(tagControl.text).toBeDefined()

    it "should have 'add' as the text", ->
      expect(tagControl.text).toEqual "add"

  describe "#icon", ->
    it "should be defined", ->
      expect(tagControl.icon).toBeDefined()

    it "should have 'add' as the icon", ->
      expect(tagControl.icon).toEqual "add"

  describe "#iconClass", ->
    it "should be defined", ->
      expect(tagControl.iconClass).toBeDefined()

    it "should have 'icons-famfamfam-add' as the famfam class", ->
      expect(tagControl.iconClass).toEqual "icons-famfamfam-add"

  describe "#jQuery", ->
    it "should be defined", ->
      expect(tagControl.jQuery()).toBeDefined()

    it "should exist", ->
      expect(tagControl.jQuery()).toExist()

    it "should be hidden", ->
      expect(tagControl.jQuery()).toBeHidden()

  describe "TagControl#hide", ->
    it "should be defined", ->
      expect(tagControl.hide).toBeDefined()

    it "should hide the element", ->
      expect(tagControl.show()).toBeVisible()
      expect(tagControl.jQuery()).toBeVisible()
      expect(tagControl.hide()).toBeHidden()
      expect(tagControl.jQuery()).toBeHidden()

  describe "#html", ->
    it "should be defined", ->
      expect(tagControl.html()).toBeDefined()

    it "should be an HTML anchor tag", ->
      expect(tagControl.html()).toEqual(
        "<a href=\"#\" class=\"muted btn btn-mini\" style=\"display: none; \">"+
          "<i class=\"icons-famfamfam-add\"></i><span>add</span></a>")

describe "AddControl", ->
  addControl = null
  beforeEach ->
    @fixtures = fixture.load 'tags/controls.html'
    controls = $(".controls", fixture.el)
    addControl = new window.eshelf.tags.AddControl
    controls.append addControl.jQuery()

  describe "#text", ->
    it "should be defined", ->
      expect(addControl.text).toBeDefined()

    it "should have 'add' as the text", ->
      expect(addControl.text).toEqual "add"

  describe "#icon", ->
    it "should be defined", ->
      expect(addControl.icon).toBeDefined()

    it "should have 'add' as the icon", ->
      expect(addControl.icon).toEqual "add"

  describe "#iconClass", ->
    it "should be defined", ->
      expect(addControl.iconClass).toBeDefined()

    it "should have 'icons-famfamfam-add' as the famfam class", ->
      expect(addControl.iconClass).toEqual "icons-famfamfam-add"

  describe "#jQuery", ->
    it "should be defined", ->
      expect(addControl.jQuery()).toBeDefined()

    it "should exist", ->
      expect(addControl.jQuery()).toExist()

    it "should be hidden", ->
      expect(addControl.jQuery()).toBeHidden()

  describe "#hide", ->
    it "should be defined", ->
      expect(addControl.hide).toBeDefined()

    it "should hide the element", ->
      expect(addControl.show()).toBeVisible()
      expect(addControl.jQuery()).toBeVisible()
      expect(addControl.hide()).toBeHidden()
      expect(addControl.jQuery()).toBeHidden()

  describe "#html", ->
    it "should be defined", ->
      expect(addControl.html()).toBeDefined()

    it "should be an HTML anchor tag", ->
      expect(addControl.html()).toEqual(
        "<a href=\"#\" class=\"muted btn btn-mini\" style=\"display: none; \">"+
          "<i class=\"icons-famfamfam-add\"></i><span>add</span></a>")

describe "EditControl", ->
  editControl = null
  beforeEach ->
    @fixtures = fixture.load 'tags/controls.html'
    controls = $(".controls", fixture.el)
    editControl = new window.eshelf.tags.EditControl
    controls.append editControl.jQuery()

  describe "#text", ->
    it "should be defined", ->
      expect(editControl.text).toBeDefined()

    it "should have 'edit' as the text", ->
      expect(editControl.text).toEqual "edit"

  describe "#icon", ->
    it "should be defined", ->
      expect(editControl.icon).toBeDefined()

    it "should have 'edit' as the icon", ->
      expect(editControl.icon).toEqual "pencil_add"

  describe "#iconClass", ->
    it "should be defined", ->
      expect(editControl.iconClass).toBeDefined()

    it "should have 'icons-famfamfam-pencil_add' as the famfam class", ->
      expect(editControl.iconClass).toEqual "icons-famfamfam-pencil_add"

  describe "#jQuery", ->
    it "should be defined", ->
      expect(editControl.jQuery()).toBeDefined()

    it "should exist", ->
      expect(editControl.jQuery()).toExist()

    it "should be hidden", ->
      expect(editControl.jQuery()).toBeHidden()

  describe "#hide", ->
    it "should be defined", ->
      expect(editControl.hide).toBeDefined()

    it "should hide the element", ->
      expect(editControl.show()).toBeVisible()
      expect(editControl.jQuery()).toBeVisible()
      expect(editControl.hide()).toBeHidden()
      expect(editControl.jQuery()).toBeHidden()

  describe "#html", ->
    it "should be defined", ->
      expect(editControl.html()).toBeDefined()

    it "should be an HTML anchor tag", ->
      expect(editControl.html()).toEqual(
        "<a href=\"#\" class=\"muted btn btn-mini\" style=\"display: none; \">"+
          "<i class=\"icons-famfamfam-pencil_add\"></i><span>edit</span></a>")

describe "SaveControl", ->
  saveControl = null
  beforeEach ->
    @fixtures = fixture.load 'tags/controls.html'
    controls = $(".controls", fixture.el)
    saveControl = new window.eshelf.tags.SaveControl
    controls.append saveControl.jQuery()

  describe "#text", ->
    it "should be defined", ->
      expect(saveControl.text).toBeDefined()

    it "should have add as the text", ->
      expect(saveControl.text).toEqual "save"

  describe "#icon", ->
    it "should be defined", ->
      expect(saveControl.icon).toBeDefined()

    it "should have 'disk' as the icon", ->
      expect(saveControl.icon).toEqual "disk"

  describe "#iconClass", ->
    it "should be defined", ->
      expect(saveControl.iconClass).toBeDefined()

    it "should have 'icons-famfamfam-disk' as the famfam class", ->
      expect(saveControl.iconClass).toEqual "icons-famfamfam-disk"

  describe "#jQuery", ->
    it "should be defined", ->
      expect(saveControl.jQuery()).toBeDefined()

    it "should exist", ->
      expect(saveControl.jQuery()).toExist()

    it "should be hidden", ->
      expect(saveControl.jQuery()).toBeHidden()

  describe "#hide", ->
    it "should be defined", ->
      expect(saveControl.hide).toBeDefined()

    it "should hide the element", ->
      expect(saveControl.show()).toBeVisible()
      expect(saveControl.jQuery()).toBeVisible()
      expect(saveControl.hide()).toBeHidden()
      expect(saveControl.jQuery()).toBeHidden()

  describe "#html", ->
    it "should be defined", ->
      expect(saveControl.html()).toBeDefined()

    it "should be an HTML anchor tag", ->
      expect(saveControl.html()).toEqual(
        "<a href=\"#\" class=\"muted btn btn-mini\" style=\"display: none; \">"+
          "<i class=\"icons-famfamfam-disk\"></i><span>save</span></a>")

describe "ControlSet", ->
  controlSet = null
  beforeEach ->
    controlSet = new window.eshelf.tags.ControlSet {}

  describe "ControlSet#controls", ->
    it "should be defined", ->
      expect(controlSet.controls).toBeDefined()

    # it "has a controlSet with the expected tags", ->
    #   expect(controlSet.controls).toEqual
    #     add: new window.eshelf.tags.AddControl
    #     edit: new window.eshelf.tags.EditControl
    #     save: new window.eshelf.tags.SaveControl
