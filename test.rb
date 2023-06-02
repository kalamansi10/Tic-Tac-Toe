class Board
    attr_accessor :board
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
    def win_condition(player_piece)
        if
        self.board[:a1] == player_piece && self.board[:a2] == player_piece && self.board[:a3] == player_piece ||
        self.board[:b1] == player_piece && self.board[:b2] == player_piece && self.board[:b3] == player_piece ||
        self.board[:c1] == player_piece && self.board[:c2] == player_piece && self.board[:c3] == player_piece ||

        self.board[:a1] == player_piece && self.board[:b1] == player_piece && self.board[:c1] == player_piece ||
        self.board[:a2] == player_piece && self.board[:b2] == player_piece && self.board[:c2] == player_piece ||
        self.board[:a3] == player_piece && self.board[:b3] == player_piece && self.board[:c3] == player_piece ||

        self.board[:a1] == player_piece && self.board[:b2] == player_piece && self.board[:c3] == player_piece ||
        self.board[:a3] == player_piece && self.board[:b2] == player_piece && self.board[:c1] == player_piece

            print "\nwin\n"
        else
            print "\nnot win\n"
        end
    end
end

board = Board.new
board.updateboard("a1", "X")
board.win_condition("X")
board.updateboard("b2", "X")
board.win_condition("X")
board.updateboard("c3", "X")
board.win_condition("X")