class Board
  attr_reader :height, :width, :mines

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

  def display_board(return_to_pos: true)
    cursor_start_pos = R::Cr.pos

    R::S.clear
    R::Cr.go_to_pos(1,1)

    @board.each do |row|
      row.each do |tile|
        case tile[1]
        when :hidden
          print "[■]"
          next
        when :flagged
          print "[◄]".color :light_red
          next
        end

        case tile[0]
        when :safe
          print "[ ]"
        when :bomb
          print "[✱]".color :light_red, type: :bg
        when 1
          print "[1]".color :light_blue
        when 2
          print "[2]".color :light_green
        when 3
          print "[3]".color :light_red
        when 4
          print "[4]".color :blue
        when 5
          print "[5]".color :red
        when 6
          print "[6]".color :green
        when 7
          print "[7]".color :light_gray
        when 8
          print "[8]".color :gray
        end
      end

      puts
    end

    R::Cr.go_to_pos(cursor_start_pos) if return_to_pos
  end

  def tile(x:, y:)
    return @board[y][x]
  end

  private

  def generate_board
    @board = []

    row = []

    @width.times { row << nil }
    @height.times { @board << row.dup }

    @height.times do |y|
      @width.times do |x|
        @board[y][x] = [:safe, :hidden]
      end
    end
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
