require 'test_helper'
require 'institutions'
class ApplicationHelperTest < ActionView::TestCase
  attr_reader :current_primary_institution

  setup do
    @current_primary_institution ||= Institutions.institutions[:NYU]
  end

  test "should return ILL for NYU" do
    assert_not_nil ill
    assert_not_nil ill_url
    assert_equal "https://dev.ill.library.nyu.edu", ill_url
  end

  test "should return ILL for NYUAD" do
    @current_primary_institution = Institutions.institutions[:NYUAD]
    assert_not_nil ill
    assert_not_nil ill_url
    assert_equal "https://dev.ill.library.nyu.edu", ill_url
    @current_primary_institution = nil
  end

  test "should return ILL for NS" do
    @current_primary_institution = Institutions.institutions[:NS]
    assert_not_nil ill
    assert_not_nil ill_url
    assert_equal "https://dev.ill.library.nyu.edu", ill_url
    @current_primary_institution = nil
  end

  test "should return nil ILL for CU" do
    @current_primary_institution = Institutions.institutions[:CU]
    assert_nil ill
    assert_nil ill_url
    @current_primary_institution = nil
  end

  test "should return nil ILL for HSL" do
    @current_primary_institution = Institutions.institutions[:HSL]
    assert_nil ill
    assert_nil ill_url
    @current_primary_institution = nil
  end
end
