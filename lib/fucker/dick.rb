module Fucker
  class Dick < Base
    class << self
      DEFAULT_MIN_DICK_LENGTH = 0
      DEFAULT_MAX_DICK_LENGTH = 9
      DEFAULT_MIN_JIZZ_LENGTH = 1
      DEFAULT_MAX_JIZZ_LENGTH = 4

      def dick(length = nil)
        length ||= rand(0..DEFAULT_MAX_DICK_LENGTH)
        "#{balls}#{shaft(length)}#{head_char}"
      end

      def jizzing_dick(length = nil, jizz_length = nil)
        length ||= rand(DEFAULT_MIN_DICK_LENGTH..DEFAULT_MAX_DICK_LENGTH)
        jizz_length ||= rand(DEFAULT_MIN_JIZZ_LENGTH..DEFAULT_MAX_DICK_LENGTH)
        "#{balls}#{shaft(length)}#{head_char}#{jizz(jizz_length)}"
      end

      private

      def balls
        ball_chars.sample
      end

      def ball_chars
        ['B','8']
      end

      def shaft(length)
        shaft_char = shaft_chars.sample
        (1..length).collect {shaft_char}.join
      end

      def shaft_chars
        ['-','=']
      end

      def head_char
        'D'
      end

      def jizz(length)
        (1..length).collect {jizz_char}.join
      end

      def jizz_char
        '~'
      end
    end
  end
end
