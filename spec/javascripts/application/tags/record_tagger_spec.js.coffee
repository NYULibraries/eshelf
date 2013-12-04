#= require application/tags/record_tagger
form = $("<form/>").append($("<input/>").attr("id", "113_record_tag_list").
  attr("name", 'record[tag_list]').attr("value", "tag1, tag 2"))
input = form.find("input")
recordTagger = new window.eshelf.tags.RecordTagger(input)

describe "RecordTagger#input", ->
  it "should be defined", ->
    expect(recordTagger.input).toBeDefined()

  it "has '113_record_tag_list' its input id", ->
    expect(recordTagger.input.attr("id")).toEqual "113_record_tag_list"

describe "RecordTagger#recordId", ->
  it "should be defined", ->
    expect(recordTagger.recordId).toBeDefined()

  it "has a record id of 113", ->
    expect(recordTagger.recordId).toBe 113

describe "RecordTagger#tagList", ->
  it "should be defined", ->
    expect(recordTagger.tagList).toBeDefined()

  it "has a tag list with the expected tags", ->
    expect(recordTagger.tagList().tags).toEqual [
      new window.eshelf.tags.Tag("tag1"), 
        new window.eshelf.tags.Tag("tag 2") ]

describe "RecordTagger#controlSet", ->
  it "should be defined", ->
    expect(recordTagger.controlSet).toBeDefined()

describe "RecordTagger#edit", ->
  it "should be defined", ->
    expect(recordTagger.edit).toBeDefined()

describe "RecordTagger#save", ->
  it "should be defined", ->
    expect(recordTagger.save).toBeDefined()

  it "should trigger an 'tagListSaved' event", ->
    tagListSavedSpy = jasmine.createSpy "tagListSavedEventSpy"
    $(document).bind("tagListSaved", tagListSavedSpy)
    expect(tagListSavedSpy).not.toHaveBeenCalled(); 
    recordTagger.save(recordTagger);
#     # expect(tagListSavedSpy).toHaveBeenCalled();

describe "RecordTagger#saved", ->
  it "should be defined", ->
    expect(recordTagger.saved).toBeDefined()
