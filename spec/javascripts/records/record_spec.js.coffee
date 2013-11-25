#= require records/record

record = new window.eshelf.Record
  external_system: "primo"
  external_id: "primoID"

describe "#external_system", ->
  it "should have primo as the external system", ->
    expect(record.external_system).toEqual "primo"
