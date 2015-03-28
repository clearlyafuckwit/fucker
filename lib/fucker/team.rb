module Fucker
  class Team < Base
    flexible :team

    class << self
      def name
        parse('team.name')
      end

      def creature
        fetch('team.creature')
      end

      def state
        fetch('fucker.address.state').titleize
      end
    end

  end
end
