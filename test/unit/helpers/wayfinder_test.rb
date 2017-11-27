require 'test_helper'
class WayfinderTest < ActionView::TestCase
  setup do
    @controller.request.path_info = ""
    @controller.request.session[:referer] = nil
    @bobcat_book_search_results = "http://bobcat.library.nyu.edu/primo_library/libweb/action/search.do?"+
      "dscnt=0&vl(378633853UI1)=all_items&scp.scps=scope%3A%28NS%29%2Cscope%3A%28CU%29%2Cscope%3A%28%22BHS%22%29%2C"+
        "scope%3A%28NYU%29%2Cscope%3A%28%22NYSID%22%29%2Cscope%3A%28%22NYHS%22%29%2Cscope%3A%28GEN%29%2Cscope%3A%28%22NYUAD%22%29&"+
          "frbg=&tab=all&dstmp=1366304684770&srt=rank&ct=search&mode=Basic&dum=true&vl(212921975UI0)=any&indx=1&vl(1UIStartWith0)=contains&"+
            "vl(freeText0)=digital+divide&vid=NYU&fn=search"
    @bobcat_book_search_details = "http://bobcat.library.nyu.edu/primo_library/libweb/action/display.do?"+
      "ct=display&fn=search&doc=nyu_aleph000980206&indx=2&recIds=nyu_aleph000980206&recIdxs=1&elementId=1&"+
        "displayMode=full&frbrVersion=&tabs=detailsTab&dscnt=1&vl(378633853UI1)=all_items&"+
          "scp.scps=scope%3A(NS)%2Cscope%3A(CU)%2Cscope%3A(%22BHS%22)%2Cscope%3A(NYU)%2Cscope%3A(%22NYSID%22)%2C"+
            "scope%3A(%22NYHS%22)%2Cscope%3A(GEN)%2Cscope%3A(%22NYUAD%22)&frbg=&tab=all&dstmp=1366309885834&srt=rank&"+
              "ct=search&mode=Basic&dum=true&vl(212921975UI0)=any&indx=1&vl(1UIStartWith0)=contains&vl(freeText0)=digital%20divide&"+
                "fn=search&vid=NYU"
    @bobcat_database_search_results = "https://arch.library.nyu.edu/?base=databases&action=find&query=this"
    @bobcat_database_search_details = "https://arch.library.nyu.edu/databases/database/NYU00475"
    @bobcat_journal_search_results = "https://dev.getit.library.nyu.edu/search/journal_search?utf8=%E2%9C%93&umlaut.institution=NYU&"+
      "rfr_id=info%3Asid%2Fsfxit.com%3Acitation&rft.date=&rft.title=&rft.object_id=&umlaut.title_search_type=contains&rft.jtitle=new+york&"+
        "rft.issn=&Generate_OpenURL2=Search&rft.atitle=&rft.aulast=&rft.aufirst=&__year=&__month=&__day=&rft.volume=&rft.issue=&rft.spage=&"+
          "rft.epage=&rft_id_type=doi&rft_id_value="
    @bobcat_database_az_results = "https://arch.library.nyu.edu/databases/alphabetical?alpha=A"
    @bobcat_journal_az_results = "https://dev.getit.library.nyu.edu/journal_list/J?umlaut.institution=NYU"
    @bobcat_book_search = "http://bobcat.library.nyu.edu/primo_library/libweb/action/search.do?vid=NYU"
    @bobcat_reserves_search = "http://bobcat.library.nyu.edu/primo_library/libweb/action/search.do?mode=Basic&vid=NYU&tab=reserves"
    @bobcat_database_search = "https://arch.library.nyu.edu/databases/subject/general-search"
    @bobcat_articles_search = "https://arch.library.nyu.edu/"
    @example_url = URI::parse("http://example.org/this/is/the/path?key1=value1&key2=value2&key3=value3")
    @empty_matcher = {}
  end

  test "initialize" do
    assert_nothing_raised {
      Wayfinder.new(@controller.request)
    }
  end

  test "should match host" do
    matcher1 = "example.org"
    matcher2 = "example"
    matcher3 = ""
    wayfinder = Wayfinder.new(@controller.request)
    assert(wayfinder.send(:url_matches_host?, @example_url, matcher1))
    assert(wayfinder.send(:url_matches_host?, @example_url, matcher2))
    assert(wayfinder.send(:url_matches_host?, @example_url, matcher3))
    assert(wayfinder.send(:url_matches_host?, @example_url, nil))
  end

  test "should not match host" do
    matcher = "example.com"
    wayfinder = Wayfinder.new(@controller.request)
    assert((not wayfinder.send(:url_matches_host?, @example_url, matcher)))
  end

  test "should match path" do
    matcher1 = "/this/is/the/path"
    matcher2 = "/the/path"
    matcher3 = "/is/the/"
    matcher4 = ""
    wayfinder = Wayfinder.new(@controller.request)
    assert(wayfinder.send(:url_matches_path?, @example_url, matcher1))
    assert(wayfinder.send(:url_matches_path?, @example_url, matcher2))
    assert(wayfinder.send(:url_matches_path?, @example_url, matcher3))
    assert(wayfinder.send(:url_matches_path?, @example_url, matcher4))
    assert(wayfinder.send(:url_matches_path?, @example_url, nil))
  end

  test "should not match path" do
    matcher = "/this/isnt/the/path"
    wayfinder = Wayfinder.new(@controller.request)
    assert((not wayfinder.send(:url_matches_path?, @example_url, matcher)))
  end

  test "should match with kevs" do
    matcher1 = ["key1=value1", "key2=value2", "key3=value3"]
    matcher2 = ["key1=value1", "key2=value2"]
    matcher3 = []
    wayfinder = Wayfinder.new(@controller.request)
    assert(wayfinder.send(:url_matches_with_kevs?, @example_url, matcher1))
    assert(wayfinder.send(:url_matches_with_kevs?, @example_url, matcher2))
    assert(wayfinder.send(:url_matches_with_kevs?, @example_url, matcher3))
    assert(wayfinder.send(:url_matches_with_kevs?, @example_url, nil))
  end

  test "should not match with kevs" do
    matcher = ["key4=value4", "key5=value5"]
    wayfinder = Wayfinder.new(@controller.request)
    assert((not wayfinder.send(:url_matches_with_kevs?, @example_url, matcher)))
  end

  test "should match without kevs" do
    matcher1 = ["key4=value4", "key5=value5"]
    matcher2 = ["key4=value4"]
    matcher3 = []
    wayfinder = Wayfinder.new(@controller.request)
    assert(wayfinder.send(:url_matches_without_kevs?, @example_url, matcher1))
    assert(wayfinder.send(:url_matches_without_kevs?, @example_url, matcher2))
    assert(wayfinder.send(:url_matches_without_kevs?, @example_url, matcher3))
    assert(wayfinder.send(:url_matches_without_kevs?, @example_url, nil))
  end

  test "should not match without kevs" do
    matcher = ["key1=value1", "key2=value2"]
    wayfinder = Wayfinder.new(@controller.request)
    assert((not wayfinder.send(:url_matches_without_kevs?, @example_url, matcher)))
  end

  test "should return nil text and url for an empty current url and referer" do
    wayfinder = Wayfinder.new(@controller.request)
    assert_nil(wayfinder.text)
    assert_nil(wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_nil(wayfinder.url)
    assert_nil(wayfinder.text)
  end

  test "should return nil text and url for an empty referer" do
    @controller.request.path_info = "/"
    wayfinder = Wayfinder.new(@controller.request)
    assert_nil(wayfinder.text)
    assert_nil(wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_nil(wayfinder.url)
    assert_nil(wayfinder.text)
  end

  test "should return 'Back to search' text and BobCat URL for an account current url with a referer" do
    @controller.request.path_info = "/account"
    @controller.request.session[:referer] = @bobcat_book_search
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to search", wayfinder.text)
    assert_equal("http://bobcat.library.nyu.edu", wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("http://bobcat.library.nyu.edu", wayfinder.url)
    assert_equal("Back to search", wayfinder.text)
  end

  test "should return nil text and url for an account current url with a nil referer" do
    @controller.request.path_info = "/account"
    @controller.request.session[:referer] = nil
    wayfinder = Wayfinder.new(@controller.request)
    assert_nil(wayfinder.text)
    assert_nil(wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_nil(wayfinder.url)
    assert_nil(wayfinder.text)
  end

  test "should return 'Back to search' text and BobCat URL for an account referer" do
    @controller.request.path_info = "/"
    @controller.request.session[:referer] = "/account"
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to search", wayfinder.text)
    assert_equal("http://bobcat.library.nyu.edu", wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("http://bobcat.library.nyu.edu", wayfinder.url)
    assert_equal("Back to search", wayfinder.text)
  end

  test "should return 'Back to search results' text and referer url for a BobCat book search results referer" do
    @controller.request.session[:referer] = @bobcat_book_search_results
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to search results", wayfinder.text)
    assert_equal(@bobcat_book_search_results, wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal(@bobcat_book_search_results, wayfinder.url)
    assert_equal("Back to search results", wayfinder.text)
  end

  test "should return 'Back to search results' text and referer url for a BobCat book search details referer" do
    @controller.request.session[:referer] = @bobcat_book_search_details
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to search results", wayfinder.text)
    assert_equal(@bobcat_book_search_details, wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal(@bobcat_book_search_details, wayfinder.url)
    assert_equal("Back to search results", wayfinder.text)
  end

  test "should return 'Back to search results' text and referer url for a BobCat database search results referer" do
    @controller.request.session[:referer] = @bobcat_database_search_results
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to search results", wayfinder.text)
    assert_equal(@bobcat_database_search_results, wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal(@bobcat_database_search_results, wayfinder.url)
    assert_equal("Back to search results", wayfinder.text)
  end

  test "should return 'Back to search results' text and referer url for a BobCat database search details referer" do
    @controller.request.session[:referer] = @bobcat_database_search_details
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to search results", wayfinder.text)
    assert_equal(@bobcat_database_search_details, wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal(@bobcat_database_search_details, wayfinder.url)
    assert_equal("Back to search results", wayfinder.text)
  end

  test "should return 'Back to search results' text and referer url for a BobCat journal search results referer" do
    @controller.request.session[:referer] = @bobcat_journal_search_results
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to search results", wayfinder.text)
    assert_equal(@bobcat_journal_search_results, wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal(@bobcat_journal_search_results, wayfinder.url)
    assert_equal("Back to search results", wayfinder.text)
  end

  test "should return 'Back to search' text and BobCat URL for a BobCat book search referer" do
    @controller.request.session[:referer] = @bobcat_book_search
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to search", wayfinder.text)
    assert_equal('http://bobcat.library.nyu.edu', wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal('http://bobcat.library.nyu.edu', wayfinder.url)
    assert_equal("Back to search", wayfinder.text)
  end

  test "should return 'Back to search' text and referer url for a BobCat reserves search referer" do
    @controller.request.session[:referer] = @bobcat_reserves_search
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to search", wayfinder.text)
    assert_equal(@bobcat_reserves_search, wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal(@bobcat_reserves_search, wayfinder.url)
    assert_equal("Back to search", wayfinder.text)
  end

  test "should return 'Back to Databases A-Z' text and referer url for a BobCat database az results referer" do
    @controller.request.session[:referer] = @bobcat_database_az_results
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to Databases A-Z", wayfinder.text)
    assert_equal(@bobcat_database_az_results, wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal(@bobcat_database_az_results, wayfinder.url)
    assert_equal("Back to Databases A-Z", wayfinder.text)
  end

  test "should return 'Back to E-Journals A-Z' text and referer url for a BobCat journal az results referer" do
    @controller.request.session[:referer] = @bobcat_journal_az_results
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to E-Journals A-Z", wayfinder.text)
    assert_equal(@bobcat_journal_az_results, wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal(@bobcat_journal_az_results, wayfinder.url)
    assert_equal("Back to E-Journals A-Z", wayfinder.text)
  end

  test "should return 'Back to Articles & Databases' text and referer url for a BobCat articles search referer" do
    @controller.request.session[:referer] = @bobcat_articles_search
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal("Back to Articles & Databases", wayfinder.text)
    assert_equal(@bobcat_articles_search, wayfinder.url)
    # Order shouldn't matter
    wayfinder = Wayfinder.new(@controller.request)
    assert_equal(@bobcat_articles_search, wayfinder.url)
    assert_equal("Back to Articles & Databases", wayfinder.text)
  end
end
