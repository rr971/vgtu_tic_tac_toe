module Game
  class GameRules
    class << self
      
      def is_winner?(player, matrix)
        ( 
          is_winner_by_columns?(player, matrix) || 
          is_winner_by_rows?(player, matrix) || 
          is_winner_by_diagonal?(player, matrix)
        )
      end
      private

      def is_winner_by_columns?(player, matrix)
        win = false
        matrix.rows.times do |row|
          tmp = true
          matrix.columns.times do |column|
            tmp = false unless matrix.game_matrix[row][column] == player.sign
          end
          if tmp
            win = tmp
            break
          end
        end
        win
      end

      def is_winner_by_rows?(player, matrix)
        win = false
        matrix.columns.times do |column|
          tmp = true
          matrix.rows.times do |row|
            tmp = false unless matrix.game_matrix[row][column] == player.sign
          end
          if tmp
            win = tmp
            break
          end
        end
        win
      end

      def is_winner_by_diagonal?(player, matrix)
        tmp_one = true
        tmp_two = true
        matrix.rows.times do |row|
          tmp_one = false unless matrix.game_matrix[row][row] == player.sign
        end

        matrix.rows.times do |row|
          tmp_two = false unless matrix.game_matrix[row][matrix.rows - row] == player.sign
        end
        tmp_one || tmp_two
      end
    end
  end
end