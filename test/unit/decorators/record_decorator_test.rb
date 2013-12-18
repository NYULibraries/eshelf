# encoding: UTF-8
require 'test_helper'

class RecordDecoratorTest < ActiveSupport::TestCase
  setup do
    @record = records(:user_primo_record1)
    VCR.use_cassette('record becomes primo') do
      @record.becomes_external_system.save
    end
    @xerxes_record = records(:user_xerxes_record1)
    @xerxes_record.becomes_external_system.save
  end

  test "email nesting" do
    assert_nothing_raised {
      email = RecordDecorator.email(@record, MockRecordDecoratorViewContext.new, "brief")
      assert_equal "book", email.content_type, "Unexpected content type"
      assert_equal "getit/#{@record.id}", email.url, "Unexpected url"
    }
    assert_nothing_raised {
      email = RecordDecorator.email(@xerxes_record, MockRecordDecoratorViewContext.new, "brief")
      assert_equal "article", email.content_type, "Unexpected content type"
      assert_equal "getit/#{@xerxes_record.id}", email.url, "Unexpected url"
    }
  end

  test "print nesting" do
    assert_nothing_raised {
      print = RecordDecorator.print(@record, MockRecordDecoratorViewContext.new, "brief")
      assert_equal "book", print.content_type, "Unexpected content type"
      assert_equal "getit/#{@record.id}", print.url, "Unexpected url"
    }
    assert_nothing_raised {
      print = RecordDecorator.print(@xerxes_record, MockRecordDecoratorViewContext.new, "brief")
      assert_equal "article", print.content_type, "Unexpected content type"
      assert_equal "getit/#{@xerxes_record.id}", print.url, "Unexpected url"
    }
  end

  test "_citation nesting" do
    assert_nothing_raised {
      citation = RecordDecorator._citation(@record, MockRecordDecoratorViewContext.new, "brief")
      assert_equal "book", citation.content_type, "Unexpected content type"
      assert_equal "getit/#{@record.id}", citation.url, "Unexpected url"
    }
    assert_nothing_raised {
      citation = RecordDecorator._citation(@xerxes_record, MockRecordDecoratorViewContext.new, "brief")
      assert_equal "article", citation.content_type, "Unexpected content type"
      assert_equal "getit/#{@xerxes_record.id}", citation.url, "Unexpected url"
    }
  end

  test "_content_type nesting" do
    assert_nothing_raised {
      content_type = RecordDecorator._content_type(@record, MockRecordDecoratorViewContext.new, "brief")
      assert_equal "book", content_type.content_type, "Unexpected content type"
    }
    assert_nothing_raised {
      content_type = RecordDecorator._content_type(@xerxes_record, MockRecordDecoratorViewContext.new, "brief")
      assert_equal "article", content_type.content_type, "Unexpected content type"
    }
  end

  test "_attribute_decorator" do
    assert_nothing_raised {
      attribute = RecordDecorator._attribute_decorator(:content_type, @record, MockRecordDecoratorViewContext.new, "brief")
      assert_equal "book", attribute.content_type, "Unexpected content type"
    }
    assert_nothing_raised {
      attribute = RecordDecorator._attribute_decorator(:content_type, @xerxes_record, MockRecordDecoratorViewContext.new, "brief")
      assert_equal "article", attribute.content_type, "Unexpected content type"
    }
  end

  test "_label nesting" do
    assert_nothing_raised {
      labeled = RecordDecorator._label(@record, MockRecordDecoratorViewContext.new)
      assert_equal "book", labeled.content_type, "Unexpected content type"
      assert_equal "getit/#{@record.id}", labeled.url, "Unexpected url"
    }
    assert_nothing_raised {
      labeled = RecordDecorator._label(@xerxes_record, MockRecordDecoratorViewContext.new)
      assert_equal "article", labeled.content_type, "Unexpected content type"
      assert_equal "getit/#{@xerxes_record.id}", labeled.url, "Unexpected url"
    }
  end

  test "_normalize nesting" do
    assert_nothing_raised {
      normalize = RecordDecorator._normalize(@record, MockRecordDecoratorViewContext.new)
      assert_equal "book", normalize.content_type, "Unexpected content type"
      assert_equal "getit/#{@record.id}", normalize.url, "Unexpected url"
    }
    assert_nothing_raised {
      normalize = RecordDecorator._normalize(@xerxes_record, MockRecordDecoratorViewContext.new)
      assert_equal "article", normalize.content_type, "Unexpected content type"
      assert_equal "getit/#{@xerxes_record.id}", normalize.url, "Unexpected url"
    }
  end
end
