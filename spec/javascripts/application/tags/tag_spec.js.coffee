#= require application/tags/tag
tag = new window.eshelf.tags.Tag
  value: "new tag"

describe "Tag#value", ->
  it "should have 'new tag' as the tag value", ->
    expect(tag.value).toEqual "new tag"

describe 'Tag#to_jquery', ->
  it "should be defined", ->
    expect(tag.to_jquery).toBeDefined()

describe "Tag#to_html", ->
  it "should be expressed as a link", ->
    expect(tag.to_html()).toEqual "<a href=\"?tag=new%20tag\">new tag</a>"
