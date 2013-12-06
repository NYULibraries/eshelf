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
      expect(tagControl.jQuery).toBeDefined()

    it "should exist", ->
      expect(tagControl.jQuery()).toExist()

    it "should be hidden", ->
      expect(tagControl.jQuery()).toBeHidden()

  describe "#hide", ->
    it "should be defined", ->
      expect(tagControl.hide).toBeDefined()

    it "should hide the control", ->
      expect(tagControl.show()).toBeVisible()
      expect(tagControl.jQuery()).toBeVisible()
      expect(tagControl.hide()).toBeHidden()
      expect(tagControl.jQuery()).toBeHidden()

  describe "#show", ->
    it "should be defined", ->
      expect(tagControl.show).toBeDefined()

    it "should show the control", ->
      expect(tagControl.hide()).toBeHidden()
      expect(tagControl.jQuery()).toBeHidden()
      expect(tagControl.show()).toBeVisible()
      expect(tagControl.jQuery()).toBeVisible()

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
      expect(addControl.jQuery).toBeDefined()

    it "should exist", ->
      expect(addControl.jQuery()).toExist()

    it "should be hidden", ->
      expect(addControl.jQuery()).toBeHidden()

  describe "#hide", ->
    it "should be defined", ->
      expect(addControl.hide).toBeDefined()

    it "should hide the control", ->
      expect(addControl.show()).toBeVisible()
      expect(addControl.jQuery()).toBeVisible()
      expect(addControl.hide()).toBeHidden()
      expect(addControl.jQuery()).toBeHidden()

  describe "#show", ->
    it "should be defined", ->
      expect(addControl.show).toBeDefined()

    it "should show the control", ->
      expect(addControl.hide()).toBeHidden()
      expect(addControl.jQuery()).toBeHidden()
      expect(addControl.show()).toBeVisible()
      expect(addControl.jQuery()).toBeVisible()

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
      expect(editControl.jQuery).toBeDefined()

    it "should exist", ->
      expect(editControl.jQuery()).toExist()

    it "should be hidden", ->
      expect(editControl.jQuery()).toBeHidden()

  describe "#hide", ->
    it "should be defined", ->
      expect(editControl.hide).toBeDefined()

    it "should hide the control", ->
      expect(editControl.show()).toBeVisible()
      expect(editControl.jQuery()).toBeVisible()
      expect(editControl.hide()).toBeHidden()
      expect(editControl.jQuery()).toBeHidden()

  describe "#show", ->
    it "should be defined", ->
      expect(editControl.show).toBeDefined()

    it "should show the control", ->
      expect(editControl.hide()).toBeHidden()
      expect(editControl.jQuery()).toBeHidden()
      expect(editControl.show()).toBeVisible()
      expect(editControl.jQuery()).toBeVisible()

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
      expect(saveControl.jQuery).toBeDefined()

    it "should exist", ->
      expect(saveControl.jQuery()).toExist()

    it "should be hidden", ->
      expect(saveControl.jQuery()).toBeHidden()

  describe "#hide", ->
    it "should be defined", ->
      expect(saveControl.hide).toBeDefined()

    it "should hide the control", ->
      expect(saveControl.show()).toBeVisible()
      expect(saveControl.jQuery()).toBeVisible()
      expect(saveControl.hide()).toBeHidden()
      expect(saveControl.jQuery()).toBeHidden()

  describe "#show", ->
    it "should be defined", ->
      expect(saveControl.show).toBeDefined()

    it "should show the control", ->
      expect(saveControl.hide()).toBeHidden()
      expect(saveControl.jQuery()).toBeHidden()
      expect(saveControl.show()).toBeVisible()
      expect(saveControl.jQuery()).toBeVisible()

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
    @fixtures = fixture.load 'tags/controls.html'
    record_tag_list = $(".record_tag_list", fixture.el)
    controlSet = new window.eshelf.tags.ControlSet {}
    record_tag_list.append controlSet.jQuery()

  describe "#controls", ->
    it "should be defined", ->
      expect(controlSet.controls).toBeDefined()

    it "has an add control", ->
      expect(controlSet.controls.add.text).toEqual "add"

    it "has an edit control", ->
      expect(controlSet.controls.edit.text).toEqual "edit"

    it "has an save control", ->
      expect(controlSet.controls.save.text).toEqual "save"

  describe "#showAdd", ->
    beforeEach ->
      controlSet.showAdd()

    it "should be defined", ->
      expect(controlSet.showAdd).toBeDefined()

    it "should show the add control", ->
      expect(controlSet.controls.add.jQuery()).not.toBeHidden()

    it "should hide the edit control", ->
      expect(controlSet.controls.edit.jQuery()).toBeHidden()

    it "should hide the save control", ->
      expect(controlSet.controls.save.jQuery()).toBeHidden()

  describe "#showEdit", ->
    beforeEach ->
      controlSet.showEdit()

    it "should be defined", ->
      expect(controlSet.showEdit).toBeDefined()

    it "should hide the add control", ->
      expect(controlSet.controls.add.jQuery()).toBeHidden()

    it "should show the edit control", ->
      expect(controlSet.controls.edit.jQuery()).not.toBeHidden()

    it "should hide the save control", ->
      expect(controlSet.controls.save.jQuery()).toBeHidden()

  describe "#showSave", ->
    beforeEach ->
      controlSet.showSave()

    it "should be defined", ->
      expect(controlSet.showSave).toBeDefined()

    it "should hide the add control", ->
      expect(controlSet.controls.add.jQuery()).toBeHidden()

    it "should hide the edit control", ->
      expect(controlSet.controls.edit.jQuery()).toBeHidden()

    it "should show the save control", ->
      expect(controlSet.controls.save.jQuery()).not.toBeHidden()

  describe "#jQuery", ->
    it "should be defined", ->
      expect(controlSet.jQuery).toBeDefined()

    it "should exist", ->
      expect(controlSet.jQuery()).toExist()

  describe "#html", ->
    it "should be defined", ->
      expect(controlSet.html).toBeDefined()

    it "should be an HTML span with 3 control anchors", ->
      expect(controlSet.html()).toEqual "<span class=\"controls\">" +
        "<a href=\"#\" class=\"muted btn btn-mini\" style=\"display: none; \">"+
          "<i class=\"icons-famfamfam-add\"></i><span>add</span></a>" +
        "<a href=\"#\" class=\"muted btn btn-mini\" style=\"display: none; \">"+
          "<i class=\"icons-famfamfam-pencil_add\"></i><span>edit</span></a>" +
        "<a href=\"#\" class=\"muted btn btn-mini\" style=\"display: none; \">"+
          "<i class=\"icons-famfamfam-disk\"></i><span>save</span></a></span>"
