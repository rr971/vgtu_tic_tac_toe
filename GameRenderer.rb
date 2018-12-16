module Game
  class GameRenderer
    class << self
      def draw_gameplay(matrix)
        puts '-------------'
        matrix.rows.times do |row|
          print '| '
          matrix.columns.times do |column|
            print matrix.game_matrix[row][column].to_s + ' | '
          end
          print "\n"
          puts '-------------'
        end
      end

      def text_for_player
        p '(formatas 1 2 + enter) 1- tai eile 2- tai stulpelis'
        p 'Iveskite kordinates: '
      end
    end
  end
end