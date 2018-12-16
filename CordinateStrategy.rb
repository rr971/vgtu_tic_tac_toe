module Game
  module Strategies
    class CordinateStrategy
      class << self
        def format_cord(x, y)
          (x + 1).to_s + ' ' + (y + 1).to_s
        end

        def read_cord(cord)
          cord = cord.split(' ')
          x = cord[0].to_i - 1 
          y = cord[1].to_i - 1
          [x, y]
        end
      end
    end
  end
end