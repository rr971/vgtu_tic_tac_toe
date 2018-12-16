require './PcPlayer'
require './CordinateStrategy'
require './player'
require './GameRenderer'
require './matrix'
require './GameRules'

module Game
  class PcPlayer < Player
    attr_accessor :zmogus

    def initialize(sign, zmogus)
      super(sign)
      @zmogus = zmogus
    end

    def get_pc_cordinate(matrix)
      a = mini_max(matrix, self)
      p a
      a[1]
    end

    def mini_max(matrix, player)
      spots = matrix.empty_spots(Strategies::CordinateStrategy)
      if GameRules.is_winner?(@zmogus, matrix)
        return -10
      elsif GameRules.is_winner?(self, matrix)
        return +10
      elsif spots.size == 0
        return 0
      end

      moves = []

      spots.each do |spot|
        x, y = Strategies::CordinateStrategy.read_cord(spot)
        move_index = matrix.game_matrix[x][y]
        matrix.game_matrix[x][y] = player.sign
        if player == self
          move_score = mini_max(matrix, @zmogus)
        elsif player == @zmogus
          move_score = mini_max(matrix, self)
        end

        matrix.game_matrix[x][y] = move_index
        if move_score.class.to_s == 'Integer'
          moves << [move_score, spot]
        else
          moves << [move_score[0], spot]
        end
      end
      @best_move = ''

      if player == self
        best_score = -9999999
        moves.each do |move|
          if move[0] > best_score
            best_score = move[0]
            @best_move = move
          end
        end
      else
        best_score = 9999999
        moves.each do |move|
          if move[0] < best_score
            best_score = move[0]
            @best_move = move
          end
        end
      end
      @best_move
    end
  end
end