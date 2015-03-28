require File.expand_path(File.dirname(__FILE__) + '/test_helper.rb')

class TestFuckerAvatar < Test::Unit::TestCase
  def setup
    @tester = Fucker::Avatar
  end

  def test_avatar
    assert @tester.image.match(/http:\/\/robohash\.org\/(.+)\.png/)[1] != nil
  end

  def test_avatar_with_param
    assert @tester.image('fucker').match(/http:\/\/robohash\.org\/(.+)\.png/)[1] == 'fucker'
  end

  def test_avatar_with_correct_size
    assert @tester.image('fucker', '150x320').match(/http:\/\/robohash\.org\/fucker\.png\?size=(.+)/)[1] == '150x320'
  end

  def test_avatar_with_incorrect_size
    assert_raise ArgumentError do
      @tester.image(nil, '150x320z')
    end
  end

  def test_avatar_with_supported_format
    assert @tester.image('fucker', '300x300', 'jpg').match(/http:\/\/robohash\.org\/fucker\.jpg/)
  end

  def test_avatar_with_incorrect_format
    assert_raise ArgumentError do
      @tester.image(nil, '300x300', 'wrong_format')
    end
  end

end
