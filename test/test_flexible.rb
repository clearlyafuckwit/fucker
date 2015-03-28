require File.dirname(__FILE__) + '/test_helper.rb'

module Fucker
  class Foodie < Base
    flexible :chow
  end
end

class TestFlexible < Test::Unit::TestCase

  def setup
    I18n.backend.store_translations(:xx, :fucker => {:chow => {:yummie => [:fudge, :chocolate, :caramel], :taste => "delicious"}})
    I18n.backend.store_translations(:home, :fucker => {:address => {:birthplace => [:bed, :hospital, :airplane]}})
    I18n.backend.store_translations(:kindergarden, :fucker => {:name => {:girls_name => [:alice, :cheryl, :tatiana]}})
    I18n.backend.store_translations(:work, :fucker => {:company => {:do_stuff => [:work, :work, :work]}})
  end

  def test_flexible_multiple_values
    I18n.with_locale(:xx) do
      actual = Fucker::Foodie.yummie
      assert [:fudge, :chocolate, :caramel].include? actual
    end
  end

  def test_flexible_single_value
    I18n.with_locale(:xx) do
      assert_equal "delicious", Fucker::Foodie.taste
    end
  end

  def test_raises_no_method_error
    I18n.with_locale(:xx) do
      assert_raise(NoMethodError) do
        Fucker::Foodie.eeew
      end
    end
  end
  
  def test_address_is_flexible
    I18n.with_locale(:home) do
      assert [:bed, :hospital, :airplane].include? Fucker::Address.birthplace
    end
  end

  def test_name_is_flexible
    I18n.with_locale(:kindergarden) do
      assert [:alice, :cheryl, :tatiana].include? Fucker::Name.girls_name
    end
  end

  def test_company_is_flexible
    I18n.with_locale(:work) do
      assert Fucker::Company.do_stuff == :work
    end
  end
end
