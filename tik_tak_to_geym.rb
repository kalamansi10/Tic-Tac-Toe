# class for the players and method that checks player input
class Player
  attr_reader :player, :piece

  def initialize(player, piece)
    @player = player
    @piece = piece
  end

  def player_details
    print "\nPlayer #{player} turn, you have '#{piece}' piece.\n\n"
  end

  def place_piece
    position = gets.chomp
    if %w[a1 a2 a3 b1 b2 b3 c1 c2 c3].any? { |square| square == position.downcase }
      [player, piece, position]
    elsif position.downcase == 'reset'
      'reset'
    else
      [player, piece, false]
    end
  end
end

# class that creates an instance of a 3x3 board and methods for interacting with the board
class Board
  attr_accessor :board

  def initialize
    @board = { a1: ' ', a2: ' ', a3: ' ', b1: ' ', b2: ' ', b3: ' ', c1: ' ', c2: ' ', c3: ' ' }
    printboard
  end

  def updateboard(position, player_piece)
    board[position.to_sym] = player_piece
    printboard
  end

  def printboard
    print "\n\n\n\n\n            1   2   3\n
        A  [#{board[:a1]}] [#{board[:a2]}] [#{board[:a3]}]\n
        B  [#{board[:b1]}] [#{board[:b2]}] [#{board[:b3]}]\n
        C  [#{board[:c1]}] [#{board[:c2]}] [#{board[:c3]}]\n\n"
  end

  def position_taken?(position)
    !board[position.to_sym] == ' '
  end

  def board_full?
    board.none? { |_postion, piece| piece == ' ' }
  end

  def win_condition(player_piece)
    (board[:a1] == player_piece && board[:a2] == player_piece && board[:a3] == player_piece ||
    board[:b1] == player_piece && board[:b2] == player_piece && board[:b3] == player_piece ||
    board[:c1] == player_piece && board[:c2] == player_piece && board[:c3] == player_piece ||

    board[:a1] == player_piece && board[:b1] == player_piece && board[:c1] == player_piece ||
    board[:a2] == player_piece && board[:b2] == player_piece && board[:c2] == player_piece ||
    board[:a3] == player_piece && board[:b3] == player_piece && board[:c3] == player_piece ||

    board[:a1] == player_piece && board[:b2] == player_piece && board[:c3] == player_piece ||
    board[:a3] == player_piece && board[:b2] == player_piece && board[:c1] == player_piece)
  end

  def board_reset
    self.board = { a1: ' ', a2: ' ', a3: ' ', b1: ' ', b2: ' ', b3: ' ', c1: ' ', c2: ' ', c3: ' ' }
  end
end

# class that initializes the game and implements the rules
class Game
  attr_accessor :player1, :player2, :board, :playerplaying

  def initialize
    @player1 = Player.new(1, 'X')
    @player2 = Player.new(2, 'O')
    @board = Board.new
    @playerplaying = rand(1..2)

    print "\nPlayer #{playerplaying} first.\n"

    player_turn
  end

  def player_turn
    if board.board_full?
      board.printboard
      print "\nBoard is full.\n\nType in RESET to reset board.\n\n"
      gets.chomp.downcase == 'reset' ? reset_game : player_turn
    else
      case playerplaying
      when 1
        player1.player_details
        player_move = player1.place_piece # will return and array of [player, piece, position]
        player_action(player_move)
        self.playerplaying = 2
      when 2
        player2.player_details
        player_move = player2.place_piece
        player_action(player_move)
        self.playerplaying = 1
      end
      board.win_condition(player_move[1]) ? declare_winner : player_turn
    end
  end

  def player_action(player_move)
    if player_move == 'reset'
      reset_game
      player_turn
    elsif player_move[2] == false
      board.printboard
      print "\nInvalid Position!\n"
      player_turn
    elsif board.position_taken?(player_move[2])
      board.printboard
      print "\nPosition already taken.\n"
      player_turn
    elsif player_move[2] != false && board.position_taken?(player_move[2]) == false
      board.updateboard(player_move[2], player_move[1])
      print "\n...\n"
    end
  end

  def declare_winner
    board.printboard
    print "\nPlayer #{playerplaying} wins!!!\n\n"
  end

  def reset_game
    board.board_reset
    board.printboard
    print "\nBoard has been reset.\n"
    self.playerplaying = rand(1..2)
    player_turn
  end
end

new_game = Game.new
