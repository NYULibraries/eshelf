#= require application/tags/tag_list
input = $("<input/>").attr("id", "record_1_tag_list").attr("value", "this tag, another tag").get(0)
tag_list = new window.eshelf.tags.TagList
  input: input

describe "TagList#input", ->
  it "should be defined", ->
    expect(tag_list.input).toBeDefined()

  it "should have the given id", ->
    expect(tag_list.input.id).toEqual "record_1_tag_list"

  it "should have the given values", ->
    expect(tag_list.input.value).toEqual "this tag, another tag"

describe "TagList#tags", ->
  it "should be defined", ->
    expect(tag_list.tags).toBeDefined()

  it "should have tags from the given input", ->
    expect(tag_list.tags).toEqual [
      new window.eshelf.tags.Tag(value: "this tag"),
        new window.eshelf.tags.Tag(value: "another tag")]

