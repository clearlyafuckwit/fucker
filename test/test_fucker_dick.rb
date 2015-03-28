require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

class TestFuckerDick < Test::Unit::TestCase
  def setup
    @tester = Fucker::Dick
  end

  def test_dick
    100.times do
      assert @tester.dick.match(/[8B][-=]*D/)
    end
  end

  def test_jizzing_dick
    100.times do
      assert @tester.jizzing_dick.match(/[8B][-=]*D~+/)
    end
  end

end
