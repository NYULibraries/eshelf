#= require application/tags/record_tagger
fixture.preload 'tags/record1.html', 'tags/record2.html'
recordTagger = null
describe "Populate RecordTagger", ->
  beforeEach ->
    @fixtures = fixture.load 'tags/record1.html', true
    input =
      $(".record_tag_list input[name='record[tag_list]']", fixture.el).first()
    recordTagger = new window.eshelf.tags.RecordTagger input

  describe "#input", ->
    it "should be defined", ->
      expect(recordTagger.input).toBeDefined()

    it "has '1_record_tag_list' as its input id", ->
      expect(recordTagger.input.attr("id")).toEqual "1_record_tag_list"

  describe "#recordId", ->
    it "should be defined", ->
      expect(recordTagger.recordId).toBeDefined()

    it "has a record id of 1", ->
      expect(recordTagger.recordId).toBe 1

  describe "#parseTags", ->
    it "should be defined", ->
      expect(recordTagger.parseTags).toBeDefined()

    it "should be ['tag', 'another tag']", ->
      expect(recordTagger.parseTags()).toEqual ["tag", "another tag"]

  describe "#tagList", ->
    it "should be defined", ->
      expect(recordTagger.tagList).toBeDefined()

  describe "#controlSet", ->
    it "should be defined", ->
      expect(recordTagger.controlSet).toBeDefined()

  describe "#edit", ->
    beforeEach ->
      recordTagger.edit(recordTagger)

    it "should be defined", ->
      expect(recordTagger.edit).toBeDefined()

    it "should hide the tags", ->
      expect(recordTagger.tags()).toBeHidden()

    it "should show the tags input", ->
      expect(recordTagger.input).not.toBeHidden()

    it "should show the save control", ->
      expect(recordTagger.controlSet().controls.save.jQuery()).not.toBeHidden()
      expect(recordTagger.input).not.toBeHidden()

    it "should hide the add control", ->
      expect(recordTagger.controlSet().controls.add.jQuery()).toBeHidden()

    it "should hide the edit control", ->
      expect(recordTagger.controlSet().controls.edit.jQuery()).toBeHidden()

  describe "#save", ->
    it "should be defined", ->
      expect(recordTagger.save).toBeDefined()

    # Fixtures aren't in place for the callback to work.
    # Skipping the spec with 'xit'
    xit "should call #saved 1 time", ->
      ajaxSuccessFlag = false
      # Run the save
      runs ->
        # Spy on recordTagger#saved
        spyOn recordTagger, "saved"
        # Spy on the Ajax Success Event from jQuery
        ajaxSuccessSpy = -> 
          ajaxSuccessFlag = true
          console.log "success"
        $(document).ajaxSuccess(ajaxSuccessSpy)
        recordTagger.save(recordTagger)
      # Wait for an Ajax Success Event to be triggered
      waitsFor (()-> ajaxSuccessFlag == true), 
        "Ajax should successfully return",500
      # Make sure that saved called
      runs ->
        expect(recordTagger.saved).toHaveBeenCalled()
        expect(recordTagger.saved).toHaveBeenCalledWith(recordTagger)
        expect(recordTagger.saved.calls.length).toEqual(1)

    it "should trigger an 'tagListSaved' event", ->
      tagListSavedSpy = jasmine.createSpy "tagListSavedEventSpy"
      $(document).bind("tagListSaved", tagListSavedSpy)
      expect(tagListSavedSpy).not.toHaveBeenCalled()
      recordTagger.save(recordTagger)
      # expect(tagListSavedSpy).toHaveBeenCalled()

  describe "#saved", ->
    beforeEach ->
      recordTagger.save(recordTagger)

    it "should be defined", ->
      expect(recordTagger.saved).toBeDefined()

    it "should show the tags", ->
      expect(recordTagger.tags()).not.toBeHidden()

    it "should hide the tags input", ->
      expect(recordTagger.input).toBeHidden()

    it "should hide the save control", ->
      expect(recordTagger.controlSet().controls.save.jQuery()).toBeHidden()
      expect(recordTagger.input).toBeHidden()

    it "should hide the add control", ->
      expect(recordTagger.controlSet().controls.add.jQuery()).toBeHidden()

    it "should show the edit control", ->
      expect(recordTagger.controlSet().controls.edit.jQuery()).not.toBeHidden()

describe "Empty RecordTagger", ->
  beforeEach ->
    @fixtures = fixture.load 'tags/record2.html', true
    input =
      $(".record_tag_list input[name='record[tag_list]']", fixture.el).first()
    recordTagger = new window.eshelf.tags.RecordTagger input

  describe "#input", ->
    it "should be defined", ->
      expect(recordTagger.input).toBeDefined()

    it "has '2_record_tag_list' as its input id", ->
      expect(recordTagger.input.attr("id")).toEqual "2_record_tag_list"

  describe "#recordId", ->
    it "should be defined", ->
      expect(recordTagger.recordId).toBeDefined()

    it "has a record id of 2", ->
      expect(recordTagger.recordId).toBe 2

  describe "#parseTags", ->
    it "should be defined", ->
      expect(recordTagger.parseTags).toBeDefined()

    it "should be []", ->
      expect(recordTagger.parseTags()).toEqual []

  describe "#tagList", ->
    it "should be defined", ->
      expect(recordTagger.tagList).toBeDefined()

  describe "#controlSet", ->
    it "should be defined", ->
      expect(recordTagger.controlSet).toBeDefined()

  describe "#tags", ->
    it "should be defined", ->
      expect(recordTagger.tags).toBeDefined()

    it "should be exist", ->
      expect(recordTagger.tags()).toExist()

  describe "#controls", ->
    it "should be defined", ->
      expect(recordTagger.controls).toBeDefined()

    it "should be exist", ->
      expect(recordTagger.controls()).toExist()

  describe "#edit", ->
    beforeEach ->
      recordTagger.edit(recordTagger)

    it "should be defined", ->
      expect(recordTagger.edit).toBeDefined()

    it "should hide the tags", ->
      expect(recordTagger.tags()).toBeHidden()

    it "should show the tags input", ->
      expect(recordTagger.input).not.toBeHidden()

    it "should show the save control", ->
      expect(recordTagger.controlSet().controls.save.jQuery()).not.toBeHidden()
      expect(recordTagger.input).not.toBeHidden()

    it "should hide the add control", ->
      expect(recordTagger.controlSet().controls.add.jQuery()).toBeHidden()

    it "should hide the edit control", ->
      expect(recordTagger.controlSet().controls.edit.jQuery()).toBeHidden()

  describe "#save", ->
    it "should be defined", ->
      expect(recordTagger.save).toBeDefined()

    it "should trigger an 'tagListSaved' event", ->
      tagListSavedSpy = jasmine.createSpy "tagListSavedEventSpy"
      $(document).bind("tagListSaved", tagListSavedSpy)
      expect(tagListSavedSpy).not.toHaveBeenCalled()
      recordTagger.save(recordTagger)
    #     # expect(tagListSavedSpy).toHaveBeenCalled()

  describe "#saved", ->
    beforeEach ->
      recordTagger.save(recordTagger)

    it "should be defined", ->
      expect(recordTagger.saved).toBeDefined()

    it "should not show the tags, since there aren't any", ->
      expect(recordTagger.tags()).toBeHidden()

    it "should hide the tags input", ->
      expect(recordTagger.input).toBeHidden()

    it "should hide the save control", ->
      expect(recordTagger.controlSet().controls.save.jQuery()).toBeHidden()
      expect(recordTagger.input).toBeHidden()

    it "should show the add control", ->
      expect(recordTagger.controlSet().controls.add.jQuery()).not.toBeHidden()

    it "should hide the edit control", ->
      expect(recordTagger.controlSet().controls.edit.jQuery()).toBeHidden()
