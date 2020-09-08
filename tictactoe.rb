class Array
  def all_same?
    self.all? { |element| element == self[0] }
  end

  def all_empty?
    self.all? { |element| element == '' }
  end
end

class Cell
  attr_reader :char
  def initialize
    @char = ''
  end

  def is_filled?
    @char != ''
  end

  def fill(char)
    @char = char
  end
end

class Board
  attr_reader :grid
  def initialize()
    @grid = Array.new(3) { Array.new(3) { Cell.new } } 
    @winner = nil
  end

  def is_full?
    grid.flatten.all? { |cell| cell.is_filled? }
  end

  def winner?
    winning_positions.each do |positions|
      chars = positions.map { |cell| cell.char }
      next if chars.all_empty?
      return true if chars.all_same?
    end
    false
  end

  def draw?
    is_full? && !winner?
  end

  def game_over?
    winner? || draw?
  end

  def get_cell(x, y)
    grid[x][y]
  end

  def fill_cell(x, y, char)
    cell = grid[x][y]
    cell.fill(char)
  end

  def winning_positions
    grid + grid.transpose + diagonals
  end

  def diagonals
    [
    [get_cell(0, 0), get_cell(1, 1), get_cell(2, 2)],
    [get_cell(0, 2), get_cell(1, 1), get_cell(2, 0)]
    ]
  end

  def to_s
    chars = grid.flatten.map { |cell| (cell.char == '') ? ' ' : cell.char }
    puts " #{chars[0]} | #{chars[1]} | #{chars[2]} "
    puts "---+---+---"
    puts " #{chars[3]} | #{chars[4]} | #{chars[5]} "
    puts "---+---+---"
    puts " #{chars[6]} | #{chars[7]} | #{chars[8]} "
    return ' '
  end

end

class Player
  attr_reader :name, :player_char
  def initialize(name, player_char)
    @name = name
    @player_char = player_char
  end

end

class Game
  attr_reader :players, :current_player, :other_player, :board
  def initialize(players, board=Board.new)
    @players = players
    @current_player, @other_player = players.shuffle
    @board = board
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def solicit_move
    "#{current_player.name}: Enter a number between 1 and 9 to make your move"
  end

  def get_move(human_move = gets.chomp)
    human_move_to_coordinate(human_move)
  end

  private def human_move_to_coordinate(move)
    moves = {
      '1' => [0,0],
      '2' => [0,1],
      '3' => [0,2],
      "4" => [1, 0],
      "5" => [1, 1],
      "6" => [1, 2],
      "7" => [2, 0],
      "8" => [2, 1],
      "9" => [2, 2]
    }
    moves[move]
  end

  def game_over_message
    return "#{current_player.name} wins!" if board.winner?
    return "It's a tie!" if board.draw?
  end

  def play
    while !board.game_over?
      switch_players
      puts board
      puts solicit_move
      x, y = get_move
      while board.get_cell(x, y).is_filled?
        puts "That spot is already taken! Enter another number:"
        x, y = get_move
      end
      board.fill_cell(x, y, current_player.player_char)
    end
    puts board
    game_over_message
  end
end
