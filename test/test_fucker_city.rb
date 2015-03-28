require File.dirname(__FILE__) + '/test_helper.rb'

class TestFuckerCity < Test::Unit::TestCase
  def setup
    xx = {
      :fucker => {
        :name => {:first_name => ['alice'], :last_name => ['smith']},
        :address => {:city_prefix => ['west'], :city_suffix => ['burg']}
      }
    }
    I18n.backend.store_translations(:xx, xx)

    xy = {
      :fucker => {
        :address => {
          :city_prefix => ['big'],
          :city_root => ['rock'],
          :city_root_suffix => ['ing'],
          :city_suffix => ['town'],
          :city => ['#{city_prefix} #{city_root}#{city_root_suffix} #{city_suffix}']
        }
      }
    }
    I18n.backend.store_translations(:xy, xy)
  end

  def test_default_city_formats
    I18n.with_locale(:xx) do
      100.times do
        cities = ["west alice", "west smith", "west aliceburg", "west smithburg", "aliceburg", "smithburg"]
        city = Fucker::Address.city
        assert cities.include?(city), "Expected <#{cities.join(' / ')}>, but got #{city}"
      end
    end
  end

  def test_city_formats_are_flexible
    I18n.with_locale(:xy) do
      cities = ['big rocking town']
      city = Fucker::Address.city
      assert cities.include?(city), "Expected <#{cities.join(' / ')}>, but got #{city}"
    end
  end

end
