#= require application/tags/tag_control
input = $("<input/>").attr("id", "record_1_tag_list").get(0)
tag_control = new window.eshelf.tags.TagControl
  name: "add"
  input: input
  text: "add"
  icon: "add"

describe "TagControl#name", ->
  it "should be defined", ->
    expect(tag_control.name).toBeDefined()

  it "should have 'add' as the name", ->
    expect(tag_control.name).toEqual "add"

describe "TagControl#input", ->
  it "should be defined", ->
    expect(tag_control.input).toBeDefined()

  it "should have 'record 1 tag list' as the id of the input element", ->
    expect(tag_control.input.id).toEqual "record_1_tag_list"

describe "TagControl#text", ->
  it "should be defined", ->
    expect(tag_control.text).toBeDefined()

  it "should have 'add' as the text", ->
    expect(tag_control.text).toEqual "add"

describe "TagControl#icon", ->
  it "should be defined", ->
    expect(tag_control.icon).toBeDefined()

  it "should have 'add' as the icon", ->
    expect(tag_control.icon).toEqual "add"

describe "TagControl#famfam_class", ->
  it "should be defined", ->
    expect(tag_control.famfam_class).toBeDefined()

  it "should have 'icons-famfamfam-add' as the famfam class", ->
    expect(tag_control.famfam_class).toEqual "icons-famfamfam-add"

describe "TagControl#to_jquery", ->
  it "should be defined", ->
    expect(tag_control.to_jquery()).toBeDefined()

describe "TagControl#to_html", ->
  it "should be defined", ->
    expect(tag_control.to_html()).toBeDefined()

  it "should be an HTML anchor tag", ->
    expect(tag_control.to_html()).toEqual(
      "<a id=\"record_1_tag_list_add\" href=\"#\" class=\"muted btn btn-mini\">"+
        "<i class=\"icons-famfamfam-add\"></i><span>add</span></a>")

add_control = new window.eshelf.tags.AddControl
  input: input

describe "AddControl#name", ->
  it "should be defined", ->
    expect(add_control.name).toBeDefined()

  it "should have 'add' as the name", ->
    expect(add_control.name).toEqual "add"

describe "AddControl#input", ->
  it "should be defined", ->
    expect(add_control.input).toBeDefined()

  it "should have 'record 1 tag list' as the id of the input element", ->
    expect(add_control.input.id).toEqual "record_1_tag_list"

describe "AddControl#text", ->
  it "should be defined", ->
    expect(add_control.text).toBeDefined()

  it "should have 'add' as the text", ->
    expect(add_control.text).toEqual "add"

describe "AddControl#icon", ->
  it "should be defined", ->
    expect(add_control.icon).toBeDefined()

  it "should have 'add' as the icon", ->
    expect(add_control.icon).toEqual "add"

describe "AddControl#famfam_class", ->
  it "should be defined", ->
    expect(add_control.famfam_class).toBeDefined()

  it "should have 'icons-famfamfam-add' as the famfam class", ->
    expect(add_control.famfam_class).toEqual "icons-famfamfam-add"

describe "AddControl#to_jquery", ->
  it "should be defined", ->
    expect(add_control.to_jquery()).toBeDefined()

describe "AddControl#to_html", ->
  it "should be defined", ->
    expect(add_control.to_html()).toBeDefined()

  it "should be an HTML anchor tag", ->
    expect(add_control.to_html()).toEqual(
      "<a id=\"record_1_tag_list_add\" href=\"#\" class=\"muted btn btn-mini\">"+
        "<i class=\"icons-famfamfam-add\"></i><span>add</span></a>")

edit_control = new window.eshelf.tags.EditControl
  input: input

describe "EditControl#name", ->
  it "should be defined", ->
    expect(edit_control.name).toBeDefined()

  it "should have 'edit' as the name", ->
    expect(edit_control.name).toEqual "edit"

describe "EditControl#input", ->
  it "should be defined", ->
    expect(edit_control.input).toBeDefined()

  it "should have 'record 1 tag list' as the id of the input element", ->
    expect(edit_control.input.id).toEqual "record_1_tag_list"

describe "EditControl#text", ->
  it "should be defined", ->
    expect(edit_control.text).toBeDefined()

  it "should have 'edit' as the text", ->
    expect(edit_control.text).toEqual "edit"

describe "EditControl#icon", ->
  it "should be defined", ->
    expect(edit_control.icon).toBeDefined()

  it "should have 'edit' as the icon", ->
    expect(edit_control.icon).toEqual "pencil_add"

describe "EditControl#famfam_class", ->
  it "should be defined", ->
    expect(edit_control.famfam_class).toBeDefined()

  it "should have 'icons-famfamfam-pencil_add' as the famfam class", ->
    expect(edit_control.famfam_class).toEqual "icons-famfamfam-pencil_add"

describe "EditControl#to_jquery", ->
  it "should be defined", ->
    expect(edit_control.to_jquery()).toBeDefined()

describe "EditControl#to_html", ->
  it "should be defined", ->
    expect(edit_control.to_html()).toBeDefined()

  it "should be an HTML anchor tag", ->
    expect(edit_control.to_html()).toEqual(
      "<a id=\"record_1_tag_list_edit\" href=\"#\" class=\"muted btn btn-mini\">"+
        "<i class=\"icons-famfamfam-pencil_add\"></i><span>edit</span></a>")

save_control = new window.eshelf.tags.SaveControl
  input: input

describe "SaveControl#name", ->
  it "should be defined", ->
    expect(save_control.name).toBeDefined()

  it "should have 'add' as the name", ->
    expect(save_control.name).toEqual "save"

describe "SaveControl#input", ->
  it "should be defined", ->
    expect(save_control.input).toBeDefined()

  it "should have 'record 1 tag list' as the id of the input element", ->
    expect(save_control.input.id).toEqual "record_1_tag_list"

describe "SaveControl#text", ->
  it "should be defined", ->
    expect(save_control.text).toBeDefined()

  it "should have add as the text", ->
    expect(save_control.text).toEqual "save"

describe "SaveControl#icon", ->
  it "should be defined", ->
    expect(save_control.icon).toBeDefined()

  it "should have 'disk' as the icon", ->
    expect(save_control.icon).toEqual "disk"

describe "SaveControl#famfam_class", ->
  it "should be defined", ->
    expect(save_control.famfam_class).toBeDefined()

  it "should have 'icons-famfamfam-disk' as the famfam class", ->
    expect(save_control.famfam_class).toEqual "icons-famfamfam-disk"

describe "SaveControl#to_jquery", ->
  it "should be defined", ->
    expect(save_control.to_jquery()).toBeDefined()

describe "SaveControl#to_html", ->
  it "should be defined", ->
    expect(save_control.to_html()).toBeDefined()

  it "should be an HTML anchor tag", ->
    expect(save_control.to_html()).toEqual(
      "<a id=\"record_1_tag_list_save\" href=\"#\" class=\"muted btn btn-mini\">"+
        "<i class=\"icons-famfamfam-disk\"></i><span>save</span></a>")
