class Player
    attr_reader :player, :piece
    def initialize(player, piece)
        @player = player
        @piece = piece
    end  
    def player_details
        print "\nPlayer #{self.player} turn, you have '#{self.piece}' piece.\n\n"
    end
    def place_piece
        position = gets.chomp
        if ["a1","a2","a3","b1","b2","b3","c1","c2","c3"].any? {|square| square == position.downcase}
            [self.player, self.piece, position]
        else
            [self.player, self.piece, false]
        end
    end
end

class Board
    attr_accessor :board
    def initialize
        @board = {a1:" ", a2:" ", a3:" ", b1:" ", b2:" ", b3:" ", c1:" ", c2:" ", c3:" "}
        self.printboard
    end
    def updateboard(position, player_piece)
        self.board[position.to_sym] = player_piece
        self.printboard
    end
    def printboard
        print "\n            1   2   3\n
        A  [#{self.board[:a1]}] [#{self.board[:a2]}] [#{self.board[:a3]}]\n
        B  [#{self.board[:b1]}] [#{self.board[:b2]}] [#{self.board[:b3]}]\n
        C  [#{self.board[:c1]}] [#{self.board[:c2]}] [#{self.board[:c3]}]\n\n"
    end
    def is_position_not_taken?(position)
        self.board[position.to_sym] == " "
    end
    def win_condition(player_piece)
        (self.board[:a1] == player_piece && self.board[:a2] == player_piece && self.board[:a3] == player_piece ||
        self.board[:b1] == player_piece && self.board[:b2] == player_piece && self.board[:b3] == player_piece ||
        self.board[:c1] == player_piece && self.board[:c2] == player_piece && self.board[:c3] == player_piece ||

        self.board[:a1] == player_piece && self.board[:b1] == player_piece && self.board[:c1] == player_piece ||
        self.board[:a2] == player_piece && self.board[:b2] == player_piece && self.board[:c2] == player_piece ||
        self.board[:a3] == player_piece && self.board[:b3] == player_piece && self.board[:c3] == player_piece ||

        self.board[:a1] == player_piece && self.board[:b2] == player_piece && self.board[:c3] == player_piece ||
        self.board[:a3] == player_piece && self.board[:b2] == player_piece && self.board[:c1] == player_piece)
    end
end

class Game
    attr_accessor :player1, :player2, :board,:playerplaying
    def initialize
        @player1 = Player.new(1, "X")
        @player2 = Player.new(2, "O")
        @board = Board.new
        @playerplaying = rand(1..2) 

        print "\nPlayer #{self.playerplaying} first.\n"

        self.player_turn
    end
    def player_turn
        case self.playerplaying
        when 1
            self.player1.player_details
            player_move = self.player1.place_piece #will return and array of [player, piece, position]
            self.player_action(player_move)
            self.playerplaying = 2
        when 2
            self.player2.player_details
            player_move = self.player2.place_piece
            self.player_action(player_move)
            self.playerplaying = 1
        end
        self.board.win_condition(player_move[1]) ? declare_winner : self.player_turn
    end
    def player_action(player_move)
        if player_move[2] == false
            self.board.printboard
            print "\nInvalid Position!\n"
            self.player_turn
        elsif !self.board.is_position_not_taken?(player_move[2])
            self.board.printboard
            print "\nPosition already taken.\n"
            self.player_turn
        elsif player_move[2] != false && self.board.is_position_not_taken?(player_move[2])
            self.board.updateboard(player_move[2], player_move[1])
            print "\n...\n"
        end
    end
    def declare_winner
        self.board.printboard
        print "\nPlayer #{self.playerplaying} wins!!!\n\n"
    end
end

new_game = Game.new


