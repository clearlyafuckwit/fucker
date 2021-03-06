require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

LoadedYaml = ['en', 'en-BORK'].inject({}) do |h, locale|
  h[locale] = YAML.load_file(File.expand_path(File.dirname(__FILE__) + "/../lib/locales/#{locale}.yml"))[locale]['fucker']
  h
end

class TestLocale < Test::Unit::TestCase
  def teardown
    Fucker::Config.locale = nil
  end

  def test_locale_separate_from_i18n
    I18n.locale = :en
    Fucker::Config.locale = :de
    assert Fucker::PhoneNumber.phone_number.match(/\(0\d+\) \d+|\+49-\d+-\d+/)
    assert Fucker::Address.street_name.match(//)
  end

  def test_configured_locale_translation
    Fucker::Config.locale = 'en-BORK'
    assert_equal Fucker::Base.translate('fucker.lorem.words').first, LoadedYaml['en-BORK']['lorem']['words'].first
  end

  def test_locale_override_when_calling_translate
    Fucker::Config.locale = 'en-BORK'
    assert_equal Fucker::Base.translate('fucker.lorem.words', :locale => :en).first, LoadedYaml['en']['lorem']['words'].first
  end

  def test_translation_fallback
    Fucker::Config.locale = 'en-BORK'
    assert_nil LoadedYaml['en-BORK']['name']
    assert_equal Fucker::Base.translate('fucker.name.first_name').first, LoadedYaml['en']['name']['first_name'].first
  end

  def test_regex
    Fucker::Config.locale = 'en-GB'
    re = /[A-PR-UWYZ][A-HK-Y]?[0-9][ABEHMNPRVWXY0-9]? {1,2}[0-9][ABD-HJLN-UW-Z]{2}/
    assert re.match(result = Fucker::Address.postcode), "#{result} didn't match #{re}"
  end

  def test_available_locales
    assert I18n.locale_available?('en-GB')
  end
end
