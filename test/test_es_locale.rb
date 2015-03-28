require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

LoadedEsYaml = ['en', 'es'].inject({}) do |h, locale|
  h[locale] = YAML.load_file(File.expand_path(File.dirname(__FILE__) + "/../lib/locales/#{locale}.yml"))[locale]['fucker']
  h
end

class TestEsLocale < Test::Unit::TestCase
  def teardown
    Fucker::Config.locale = nil
  end

  def test_locale_separate_from_i18n
    I18n.locale = :en
    Fucker::Config.locale = :es
    assert Fucker::Address.street_name.match(//)
  end

  def test_configured_locale_translation
    Fucker::Config.locale = 'es'
    assert_equal Fucker::Base.translate('fucker.address.city_prefix').first, LoadedEsYaml['es']['address']['city_prefix'].first
  end

  def test_locale_override_when_calling_translate
    Fucker::Config.locale = 'es'
    assert_equal Fucker::Base.translate('fucker.lorem.words', :locale => :en).first, LoadedEsYaml['en']['lorem']['words'].first
  end

  def test_translation_fallback
    Fucker::Config.locale = 'es'
    assert_nil LoadedEsYaml['es']['company']['bs']
    assert_equal Fucker::Base.translate('fucker.company.bs'), LoadedEsYaml['en']['company']['bs']
  end
end
