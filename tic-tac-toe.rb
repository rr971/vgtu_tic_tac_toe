
  @game_matrix = [
                  [' ', ' ', ' '],
                  [' ', ' ', ' '],
                  [' ', ' ', ' ']         
                 ]

  @zmogus = '0'
  @pc = 'X'


  def main
    cordinate = ''
    player = 1; # 1 - zmogus -1 - pc
    draw_gameplay(@game_matrix)
    while (cordinate != 'q')
      p '(formatas 1 2 + enter) 1- tai eile 2- tai stulpelis'
      p 'Iveskite kordinates: '
      # cordinate = gets.chomp
      if player == 1
        cordinate = gets.chomp
        unless make_move(cordinate: cordinate, player: @zmogus)
          player *= -1
        end
      else
        # p get_pc_cordinate
        make_move(cordinate: get_pc_cordinate, player: @pc)
      end

      player *= -1
      system('clear')
      draw_gameplay(@game_matrix)
      if is_winner?(@game_matrix, @zmogus)
        p 'Sveikinu jus Laimejote !!!!!!!!'
        cordinate = 'q'

      elsif is_winner?(@game_matrix, @pc)
        p 'Deja, jus pralaimejote :('
        cordinate = 'q'
      elsif empty_spots(@game_matrix).size == 0
        p 'Lygiosios'
        cordinate = 'q'
      end
      # p empty_spots(@game_matrix)

    end

  end

  def draw_gameplay(matrix)
    puts '-------------'
    matrix.each do |row|
      print '| '
      row.each do |element|
        print element.to_s + ' | '
      end
      print "\n"
      puts '-------------'
    end
  end

  def make_move(options = {})
    x, y = read_cord(options[:cordinate])
    if @game_matrix[x][y] != ' '
      return false;
    else
      @game_matrix[x][y] = options[:player]
    end
  end

  def get_pc_cordinate
    a = mini_max(@game_matrix, @pc)
    p a
    a[1]
  end

  def format_cord(x, y)
    (x + 1).to_s + ' ' + (y + 1).to_s
  end

  def read_cord(cord)
    cord = cord.split(' ')
    x = cord[0].to_i - 1 
    y = cord[1].to_i - 1
    [x, y]
  end

  def empty_spots(matrix)
    spots = []
    matrix.each_with_index do |row, index|
      row.each_with_index do |ele, ind|
        if ele.to_s == ' '
          spots << format_cord(index, ind) 
        end
      end
    end
    spots
  end

  def is_winner?(matrix, player)
    ((matrix[0][0] == player && matrix[0][1] == player && matrix[0][2] == player) ||
      (matrix[1][0] == player && matrix[1][1] == player && matrix[1][2] == player) ||
      (matrix[2][0] == player && matrix[2][1] == player && matrix[2][2] == player) ||
      (matrix[0][0] == player && matrix[1][0] == player && matrix[2][0] == player) ||
      (matrix[0][1] == player && matrix[1][1] == player && matrix[2][1] == player) ||
      (matrix[0][2] == player && matrix[1][2] == player && matrix[2][2] == player) ||
      (matrix[0][0] == player && matrix[1][1] == player && matrix[2][2] == player) ||
      (matrix[0][2] == player && matrix[1][1] == player && matrix[2][0] == player))

  end

  def mini_max(matrix, player)
    spots = empty_spots(matrix)

    if is_winner?(matrix, @zmogus)
      # p 'wdadwadwdawdwd'
      return -10
    elsif is_winner?(matrix, @pc)
      # p 'ad'
      return +10
    elsif spots.size == 0
      return 0
    end

    moves = []

    spots.each do |spot|
      x, y = read_cord(spot)
      move_index = matrix[x][y]
      matrix[x][y] = player
      if player == @pc
        move_score = mini_max(matrix, @zmogus)
      elsif player == @zmogus
        move_score = mini_max(matrix, @pc)
      end
      # draw_gameplay(matrix)

      matrix[x][y] = move_index
      if move_score.class.to_s == 'Integer'
        moves << [move_score, spot]
        # p moves
      else
        moves << [move_score[0], spot]
      end
    end

    # p moves

    @best_move = ''

    if player == @pc
      best_score = -9999999
      moves.each do |move|
        # p move 
        # p move[0]
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

main
