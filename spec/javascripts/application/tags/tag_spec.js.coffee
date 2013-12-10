#= require application/tags/tag
describe "Tag", ->
  tag = null
  beforeEach ->
    tag = new window.eshelf.tags.Tag "new tag"

  describe "#value", ->
    it "should have 'new tag' as the tag value", ->
      expect(tag.value).toEqual "new tag"

  describe '#jQuery', ->
    it "should be defined", ->
      expect(tag.jQuery).toBeDefined()

  describe "#html", ->
    it "should be expressed as a link", ->
      expect(tag.html()).toEqual "<a href=\"?tag=new%20tag\">new tag</a>"
