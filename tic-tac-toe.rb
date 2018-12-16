require './PcPlayer'
require './CordinateStrategy'
require './player'
require './GameRenderer'
require './matrix'
require './GameRules'


module Game
  class MainGame
    attr_accessor *%i(pc zmogus cord_strategy matrix cordinate)
    def initialize
      @zmogus = Player.new('0')
      @pc = PcPlayer.new('X', @zmogus)
      @cord_strategy = Strategies::CordinateStrategy
      @matrix = Matrix.new(3, 3)
      @cordinate = ''
    end

    def play
      player = 1; # 1 - zmogus -1 - pc
      GameRenderer.draw_gameplay(@matrix)
      while (@cordinate != 'q')
        GameRenderer.text_for_player
        player = make_moves(player)
        GameRenderer.draw_gameplay(@matrix)
        check_for_end_game
      end
    end

    def make_moves(player)
      if player == 1
        @cordinate = gets.chomp
        x, y = @cord_strategy.read_cord @cordinate
        unless @matrix.make_move(x, y , @zmogus.sign)
          player *= -1
        end
      else
        x, y = @cord_strategy.read_cord @pc.get_pc_cordinate(@matrix)
        @matrix.make_move(x, y , @pc.sign)
      end
      player *= -1
      system('clear')
      player
    end

    def check_for_end_game
      if GameRules.is_winner? @zmogus, @matrix
        p 'Sveikinu jus Laimejote !!!!!!!!'
        @cordinate = 'q'
      elsif GameRules.is_winner? @pc, @matrix
        p 'Deja, jus pralaimejote :('
        @cordinate = 'q'
      elsif @matrix.empty_spots(@cord_strategy).size == 0
        p 'Lygiosios'
        @cordinate = 'q'
      end
    end
  end
end


Game::MainGame.new.play