require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

class TestEnUsLocale < Test::Unit::TestCase
  def setup
    Fucker::Config.locale = nil
  end

  def teardown
    Fucker::Config.locale = nil
  end

  def test_au_ocker_methods_with_en_au_ocker_locale
    Fucker::Config.locale = 'en-au-ocker'

    assert Fucker::Name.first_name.is_a? String
    assert Fucker::Name.last_name.is_a? String
    assert Fucker::Name.ocker_first_name.is_a? String
    assert Fucker::Address.street_name.is_a? String
    assert Fucker::Address.city.is_a? String
    assert Fucker::Address.region.is_a? String
  end

end
