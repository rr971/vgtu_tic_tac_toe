module Game
  class Matrix
      attr_accessor *%i(columns rows game_matrix)

      def initialize(x, y)
        @columns = x
        @rows = y
        create_matrix
      end

      def make_move(x, y, sign)
        if @game_matrix[x][y] != ' '
          return false;
        else
          @game_matrix[x][y] = sign
        end
      end

      def empty_spots(cordinates_strategy)
        spots = []
        @game_matrix.each_with_index do |row, index|
          row.each_with_index do |ele, ind|
            if ele.to_s == ' '
              spots << cordinates_strategy.format_cord(index, ind) 
            end
           end
        end
        spots
      end

      private

      def create_matrix
        @game_matrix = []
        @rows.times do |var|
          tmp = []
          @columns.times { tmp << ' '}
          @game_matrix << tmp
        end
      end
  end
end