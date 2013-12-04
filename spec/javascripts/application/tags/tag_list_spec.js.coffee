#= require application/tags/tag_list
tagList = new window.eshelf.tags.TagList "this tag", "another tag"

describe "TagList#tags", ->
  it "should be defined", ->
    expect(tagList.tags).toBeDefined()

  it "should have tags from the given input", ->
    expect(tagList.tags).toEqual [
      new window.eshelf.tags.Tag("this tag"),
        new window.eshelf.tags.Tag("another tag")]

describe "TagList#size", ->
  it "should be defined", ->
    expect(tagList.size).toBeDefined()

  it "should have size 2", ->
    expect(tagList.size()).toBe 2

describe "TagList#html", ->
  it "should be defined", ->
    expect(tagList.html).toBeDefined()

  it "should be defined", ->
    expect(tagList.html()).toEqual "<span><a href=\"?tag=this%20tag\">this tag</a>, "+
      "<a href=\"?tag=another%20tag\">another tag</a></span>"

emptyTagList = new window.eshelf.tags.TagList

describe "Empty TagList#tags", ->
  it "should be defined", ->
    expect(emptyTagList.tags).toBeDefined()

  it "should have tags from the given input", ->
    expect(emptyTagList.tags).toEqual []

describe "Empty TagList#size", ->
  it "should be defined", ->
    expect(emptyTagList.size).toBeDefined()

  it "should have size 0", ->
    expect(emptyTagList.size()).toBe 0

describe "Empty TagList#html", ->
  it "should be defined", ->
    expect(emptyTagList.html).toBeDefined()

  it "should be defined", ->
    expect(emptyTagList.html()).toEqual "<span></span>"
