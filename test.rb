class Board
    attr_accessor :board, :board_copy
    def initialize
        @board = {a1:" ", a2:" ", a3:" ", b1:" ", b2:" ", b3:" ", c1:" ", c2:" ", c3:" "}
        print
        @board_copy =
        "\n            1   2   3\n
        A  [#{self.board[:a1]}] [#{self.board[:a2]}] [#{self.board[:a3]}]\n
        B  [#{self.board[:b1]}] [#{self.board[:b2]}] [#{self.board[:b3]}]\n
        C  [#{self.board[:c1]}] [#{self.board[:c2]}] [#{self.board[:c3]}]\n\n"
    end
    def updateboard(position, player_piece)
        self.board[position.to_sym] = player_piece
        print
        @board_copy =
        "\n            1   2   3\n
        A  [#{self.board[:a1]}] [#{self.board[:a2]}] [#{self.board[:a3]}]\n
        B  [#{self.board[:b1]}] [#{self.board[:b2]}] [#{self.board[:b3]}]\n
        C  [#{self.board[:c1]}] [#{self.board[:c2]}] [#{self.board[:c3]}]\n\n"
    end
end

newb = Board.new
print newb.updateboard("a1", 'X')