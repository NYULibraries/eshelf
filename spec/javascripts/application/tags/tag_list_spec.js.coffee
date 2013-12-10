#= require application/tags/tag_list
describe "TagList", ->
  tagList = null
  beforeEach ->
    tagList = new window.eshelf.tags.TagList "this tag", "another tag"

  describe "#tags", ->
    it "should be defined", ->
      expect(tagList.tags).toBeDefined()

    it "should have tags from the given input", ->
      expect(tagList.tags).toEqual [
        new window.eshelf.tags.Tag("this tag"),
          new window.eshelf.tags.Tag("another tag")]

  describe "#size", ->
    it "should be defined", ->
      expect(tagList.size).toBeDefined()

    it "should have size 2", ->
      expect(tagList.size()).toBe 2

  describe "#html", ->
    it "should be defined", ->
      expect(tagList.html).toBeDefined()

    it "should be defined", ->
      expect(tagList.html()).toEqual "<span class=\"tag_list\">"+
        "<a href=\"?tag=this%20tag\">this tag</a>, "+
          "<a href=\"?tag=another%20tag\">another tag</a></span>"

describe "Empty TagList", ->
  emptyTagList = null
  beforeEach ->
    emptyTagList = new window.eshelf.tags.TagList

  describe "#tags", ->
    it "should be defined", ->
      expect(emptyTagList.tags).toBeDefined()

    it "should have tags from the given input", ->
      expect(emptyTagList.tags).toEqual []

  describe "#size", ->
    it "should be defined", ->
      expect(emptyTagList.size).toBeDefined()

    it "should have size 0", ->
      expect(emptyTagList.size()).toBe 0

  describe "#html", ->
    it "should be defined", ->
      expect(emptyTagList.html).toBeDefined()

    it "should be defined", ->
      expect(emptyTagList.html()).toEqual "<span class=\"tag_list\"></span>"
