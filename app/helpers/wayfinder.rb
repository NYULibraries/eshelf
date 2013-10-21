require 'uri'
# Wayfinder is class for dermining where to send a user back to.
# Match groups rules for determining a match in descending order.
#   - current_url - matcher for the current url (optional)
#     - path - matches current urls with this path (optional)
#     - with_kevs - matches current urls with these query string key-value pairs (optional)
#     - without_kevs - matches current urls without this query string key-value pairs (optional)
#   - session_referer - matcher for this session's referer (optional)
#     - host - matches referers with this host (optional)
#     - path - matches referers with this path (optional)
#     - with_kevs - matches referers with these query string key-value pairs (optional)
#     - without_kevs - matches referers without this query string key-value pair (optional)
#   - matched_url - explicit url to link for this match rule, if blank links to referer (optional)
# Matched group params
class Wayfinder
  MATCH_GROUPS = {
      "Back to search results" => [
        # Search results from Primo
        { session_referer: 
          { path: '/primo_library/libweb/action/search.do', 
            with_kevs: ['fn=search'] }},
        { session_referer: { path: '/primo_library/libweb/action/display.do' }},
        # Search results from a Xerxes federated search
        { session_referer: { path: '/metasearch' }},
        # Search results from a Xerxes database search
        { session_referer: 
          { path: '/', with_kevs: ['base=databases', 'action=find'] }},
        # Search results from a Xerxes database A-Z search
        { session_referer: { path: '/databases/database' }},
        # Search results from a GetIt journal search
        { session_referer: { path: '/search/journal_search' }}],
      "Back to search" => [
        # Books and more search
        { session_referer: 
          { path: '/primo_library/libweb/action/search.do', 
            without_kevs: ['tab=reserves'] },
            matched_url: 'http://bobcat.library.nyu.edu' },
        # Account
        { session_referer: { path: '/account' },
          matched_url: 'http://bobcat.library.nyu.edu' },
        # Account
        { current_url: { path: '/account' },
          matched_url: 'http://bobcat.library.nyu.edu' },
        # Databases by subject
        { session_referer: { path: '/databases/subject' }},
        # NYU Course reserves
        { session_referer: 
          { path: '/primo_library/libweb/action/search.do', 
            with_kevs: ['tab=reserves'], 
            without_kevs: ['fn=search'] }},
        # Cleanup page
        { session_referer: { path: 'cleanup.jsp' },
          matched_url: 'http://bobcat.library.nyu.edu' }],
      "Back to Databases A-Z" => [
        # Databases A-Z
        { session_referer: { path: '/databases/alphabetical' }},
        # DUNNO!
        { session_referer: { path: '/collections/subject' }}],
      "Back to E-Journals A-Z" => [
        { session_referer: { host: 'getit.library.nyu.edu' }}],
      "Back to Articles & Databases" => [
        { session_referer: { host: 'arch.library.nyu.edu' }}]}

  attr_reader :request, :session, :matched_group, :matched_matcher

  # Initialize the Wayfinder for this request
  def initialize(request)
    @request = request
    @session = request.session
  end

  # Get the text for this Wayfinder object.
  # Within a group, Wayfinder matches current url first
  # and session referers second.
  def text
    @text if match?
  end

  # Get the url for this Wayfinder object.
  # Within a group, Wayfinder matches current url first
  # and session referers second.
  def url
    @url if match?
  end

  # Returns a boolean indicating whether we got a match.
  def match?
    return @match if defined? @match
    # Short circuit unless we have a referer for this session
    return @match = false unless session_referer
    # THIS IS WEIRD AND CONFUSING!!!!!!!
    # Attempts to set the successful matcher as an instance variable on this class while looping through
    # the MATCH_GROUPS hash.
    (@text, @matched_group) = MATCH_GROUPS.find do |text, matchers|
      @matched_matcher = matchers.find do |matcher|
        (current_url_matches?(matcher) or session_referer_matches?(matcher))
      end
    end
    # If we don't have a matched matcher, match is false and we're done
    return @match = false unless matched_matcher
    @url = (matched_matcher[:matched_url]) ? matched_matcher[:matched_url] : session_referer.to_s
    return @match = true
  end

  # Returns a URI of the current URL
  def current_url
    parse_url(request.path_info)
  end
  private :current_url

  # Returns a URI of this session's referer
  def session_referer
    parse_url(session[:referer])
  end
  private :session_referer

  # Returns a URI or nil if not given a valid url string
  def parse_url(url_string)
    URI::parse(url_string)
  rescue URI::InvalidURIError
  end
  private :parse_url

  # Does the current url match the given matcher
  def current_url_matches?(matcher)
    url_matches?(current_url, matcher[:current_url])
  end
  private :current_url_matches?

  # Does the session referer match the given matcher
  def session_referer_matches?(matcher)
    url_matches?(session_referer, matcher[:session_referer])
  end
  private :session_referer_matches?

  # Does the given URI match the given matcher
  # Checks in order:
  #   - matcher given?
  #   - URI matches the matcher host
  #   - URI matches the matcher path
  #   - URI matches the matcher with_kevs
  #   - URI excludes the matcher without_kevs
  def url_matches?(url, matcher)
    (matcher and
      url_matches_host?(url, matcher[:host]) and 
        url_matches_path?(url, matcher[:path]) and
          url_matches_with_kevs?(url, matcher[:with_kevs]) and
            url_matches_without_kevs?(url, matcher[:without_kevs]))
  end
  private :url_matches?

  # Does the given URI match the host
  # Returns true if host is blank
  def url_matches_host?(url, host)
    host.blank? or
      url.host.include? host if url
  end
  private :url_matches_host?

  # Does the given URI match the path
  # Returns true if path is blank
  def url_matches_path?(url, path)
    path.blank? or
      url.path.include? path if url
  end
  private :url_matches_path?

  # Does the given URI match the with kevs
  # Returns true if with_kevs is nil or empty
  def url_matches_with_kevs?(url, with_kevs)
    with_kevs.nil? or with_kevs.empty? or 
      with_kevs.all? { |kev| (url.query and url.query.include?(kev)) } if url
  end
  private :url_matches_with_kevs?

  # Does the given URI match the without kevs
  # Returns true if without_kevs is nil or empty
  def url_matches_without_kevs?(url, without_kevs)
    without_kevs.nil? or without_kevs.empty? or 
      without_kevs.all? { |kev| url.query.nil? or (not url.query.include?(kev)) } if url
  end
  private :url_matches_without_kevs?
end
