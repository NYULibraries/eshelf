#= require application/tags/user_tags
fixture.preload 'tags/user_tags.html'
describe "UserTags", ->
  userTags = null
  beforeEach ->
    @fixtures = fixture.load 'tags/user_tags.html', true
    container = $("#user_tags", fixture.el)
    userTags = new window.eshelf.tags.UserTags container

  describe "#container", ->
    it "should be defined", ->
      expect(userTags.container).toBeDefined()

    it "should exist", ->
      expect(userTags.container).toExist()

    it "should have 'user_tags' as the id", ->
      expect(userTags.container.attr("id")).toEqual("user_tags")

  describe "#form", ->
    it "should be defined", ->
      expect(userTags.form).toBeDefined()

    it "should exist", ->
      expect(userTags.form).toExist()

    it "should have 'user_tags_search' as the id", ->
      expect(userTags.form.attr("id")).toEqual("user_tags_search")

    it "should have '/users/tags' as the action", ->
      expect(userTags.form.attr("action")).toEqual("/users/tags")

  describe "#url", ->
    it "should be defined", ->
      expect(userTags.url).toBeDefined()

    it "should be '/users/tags'", ->
      expect(userTags.url).toBeDefined()

  describe "#input", ->
    it "should be defined", ->
      expect(userTags.input).toBeDefined()

    it "should exist", ->
      expect(userTags.input).toExist()

    it "should have 'tag' as the id", ->
      expect(userTags.input.attr("id")).toEqual("tag")

  describe "#currentPage", ->
    it "should be defined", ->
      expect(userTags.currentPage).toBeDefined()

    it "should be 1", ->
      expect(userTags.currentPage).toBe(1)

  describe "#height", ->
    it "should be defined", ->
      expect(userTags.height).toBeDefined()

    it "should be 0", ->
      expect(userTags.height()).toBe(0)

  describe "#size", ->
    it "should be defined", ->
      expect(userTags.size).toBeDefined()

    it "should be 0", ->
      expect(userTags.size()).toBe(0)

  describe "#disabled", ->
    it "should be defined", ->
      expect(userTags.disabled).toBeDefined()

    xit "should be false", ->
      expect(userTags.disabled).toBe(false)

  describe "#get", ->
    it "should be defined", ->
      expect(userTags.get).toBeDefined()

  describe "#filter", ->
    it "should be defined", ->
      expect(userTags.filter).toBeDefined()

  describe "#next", ->
    it "should be defined", ->
      expect(userTags.next).toBeDefined()

  describe "#enableNext", ->
    it "should be defined", ->
      expect(userTags.enableNext).toBeDefined()

  describe "#handleNext", ->
    it "should be defined", ->
      expect(userTags.handleNext).toBeDefined()
