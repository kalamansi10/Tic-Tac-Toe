class Player
    def initialize
    end
    def place_piece(position)
        if ["a1","a2","a3","b1","b2","b3","c1","c2","c3"].any? {|square| square == position.downcase}
            position
        else
            false
        end
    end
end

class Board
    attr_accessor :board, :board_copy
    def initialize
        @board = {a1:" ", a2:" ", a3:" ", b1:" ", b2:" ", b3:" ", c1:" ", c2:" ", c3:" "}
        print "\n            1   2   3\n
        A  [#{self.board[:a1]}] [#{self.board[:a2]}] [#{self.board[:a3]}]\n
        B  [#{self.board[:b1]}] [#{self.board[:b2]}] [#{self.board[:b3]}]\n
        C  [#{self.board[:c1]}] [#{self.board[:c2]}] [#{self.board[:c3]}]\n\n"
    end
    def updateboard(position, player_piece)
        self.board[position.to_sym] = player_piece
        print "\n            1   2   3\n
        A  [#{self.board[:a1]}] [#{self.board[:a2]}] [#{self.board[:a3]}]\n
        B  [#{self.board[:b1]}] [#{self.board[:b2]}] [#{self.board[:b3]}]\n
        C  [#{self.board[:c1]}] [#{self.board[:c2]}] [#{self.board[:c3]}]\n\n"
    end
    def is_position_not_taken?(position)
        self.board[position.to_sym] == " "
    end
    def win_condition
    end
end

class Game
    attr_accessor :player1, :player2, :board, :win_condition,:playerplaying
    def initialize
        @player1 = Player.new
        @player2 = Player.new
        @board = Board.new
        @win_condition = WinCondition.new
        @playerplaying = rand(1..2) 

        print "Game Start!!!\n"
        print "Player #{self.playerplaying} first.\n"

        self.player_turn(self.playerplaying)
    end
    def player_turn(playerplaying)
        case playerplaying
        when 1
            print "Player 1, pick a square. (e.g. A1)\n\n"
            play_move = self.player1.place_piece(gets.chomp)
            if play_move == false
                print "\nInvalid position.\n\n"
                self.player_turn(1)
            elsif self.board.is_position_not_taken?(play_move)
                self.board.updateboard(play_move, "X")
                self.player_turn(2)
            else
                print "\nPosition is already taken.\n\n"
                self.player_turn(1)
            end
        when 2
            print "Player 2, pick a square. (e.g. A1)\n\n"
            play_move = self.player2.place_piece(gets.chomp)
            if play_move == false
                print "\nInvalid position.\n\n"
                self.player_turn(2)
            elsif self.board.is_position_not_taken?(play_move)
                self.board.updateboard(play_move, "O")
                self.player_turn(1)
            else
                print "\nPosition is already taken.\n\n"
                self.player_turn(2)
            end
        end
    end
    def check_winner
        
    end
end

new_game = Game.new


