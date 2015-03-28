require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

class TesetEnUsLocale < Test::Unit::TestCase
  def setup
    Fucker::Config.locale = nil
  end

  def teardown
    Fucker::Config.locale = nil
  end

  def test_us_phone_methods_return_nil_for_nil_locale
    assert_nil Fucker::PhoneNumber.area_code
    assert_nil Fucker::PhoneNumber.exchange_code
  end

  def test_subscriber_number_method
    assert Fucker::PhoneNumber.subscriber_number.is_a? String
    assert_equal Fucker::PhoneNumber.subscriber_number.length, 4
    assert_equal Fucker::PhoneNumber.subscriber_number(10).length, 10
    assert_equal Fucker::PhoneNumber.method(:extension), Fucker::PhoneNumber.method(:subscriber_number)
  end

  def test_us_phone_methods_with_en_us_locale
    Fucker::Config.locale = 'en-US'

    assert Fucker::PhoneNumber.area_code.is_a? String
    assert Fucker::PhoneNumber.area_code.to_i.is_a? Integer
    assert_equal Fucker::PhoneNumber.area_code.length, 3

    assert Fucker::PhoneNumber.exchange_code.is_a? String
    assert Fucker::PhoneNumber.exchange_code.to_i.is_a? Integer
    assert_equal Fucker::PhoneNumber.exchange_code.length, 3
  end

  def test_validity_of_phone_method_output
    Fucker::Config.locale = 'en-US'

    # got the following regex from http://stackoverflow.com/a/123666/1210055 as an expression of the NANP standard.
    us_number_validation_regex = /^(?:(?:\+?1\s*(?:[.-]\s*)?)?(?:\(\s*([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9])\s*\)|([2-9]1[02-9]|[2-9][02-8]1|[2-9][02-8][02-9]))\s*(?:[.-]\s*)?)?([2-9]1[02-9]|[2-9][02-9]1|[2-9][02-9]{2})\s*(?:[.-]\s*)?([0-9]{4})(?:\s*(?:#|x\.?|ext\.?|extension)\s*(\d+))?$/
    assert_match(us_number_validation_regex, Fucker::PhoneNumber.phone_number)
  end

  def test_us_invalid_state_raises_exception
    Fucker::Config.locale = 'en-US'
    assert_raise I18n::MissingTranslationData do Fucker::Address.zip_code('NA') end
  end

  def test_us_zip_codes_match_state

    Fucker::Config.locale = 'en-US'

    state_abbr = 'AZ'
    expected = /^850\d\d$/
    assert_match(expected, Fucker::Address.zip_code(state_abbr))

    # disjointed ranges for these states
    # http://www.fincen.gov/forms/files/us_state_territory_zip_codes.pdf
    state_abbr = 'AR'
    expected = /^717\d\d$/
    assert_match(expected, Fucker::Address.zip_code(state_abbr))
    state_abbr = 'GA'
    expected = /^301\d\d$/
    assert_match(expected, Fucker::Address.zip_code(state_abbr))
    state_abbr = 'MA'
    expected = /^026\d\d$/
    assert_match(expected, Fucker::Address.zip_code(state_abbr))
    state_abbr = 'NY'
    expected = /^122\d\d$/
    assert_match(expected, Fucker::Address.zip_code(state_abbr))
    state_abbr = 'TX'
    expected = /^798\d\d$/
    assert_match(expected, Fucker::Address.zip_code(state_abbr))
    state_abbr = 'VA'
    expected = /^222\d\d$/
    assert_match(expected, Fucker::Address.zip_code(state_abbr))

  end
end
