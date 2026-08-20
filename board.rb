class Board
  def initialize(height:, width:, mines:)
    area = height * width
    if area >= mines
      mines = area - 1
    end

    @height = height
    @width = width
    @mines = mines

    @first_hit = false

    generate_board
  end

  def display_board
    R::S.clear
    R::Cr.go_to_pos(0,0)

    @board.each do |row|
      row.each do |tile|
        unless tile[1]
          print "░"
        end
      end
      puts
    end
  end

  private

  def generate_board
    @board = []

    row = []

    @width.times { row << [:safe, false] }
    @height.times { @board << row.dup }
  end

  def place_mines(y, x)
    false unless @first_hit

    @mines.times do
      tile = []
      loop do
        tile = [
          Math.rand(0..@height),
          Math.rand(0..@width)
        ]

        next if tile == [y, x]
        break if @board[tile[0]][tile[1]][0] == :safe
      end

      @board[tile[0]][tile[1]][0] = :bomb
    end
  end
end
