class Board
  attr_reader :height, :width, :mines, :mines_placed

  def initialize(height:, width:, mines:)
    area = height * width
    if area <= mines
      mines = area - 1
    end

    @height = height
    @width = width
    @mines = mines

    @mines_placed = false

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
        #  print "[■]"
        #  next
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
    return nil if (x < 0 || y < 0)
    return @board[y]&.[](x)
  end

  def place_mines(y:, x:)
    return false if @mines_placed

    @mines.times do
      cur_tile = []
      loop do
        cur_tile = [
          rand(0..@height-1),
          rand(0..@width-1)
        ]

        next if cur_tile == [y, x]
        next if @board[cur_tile[0]][cur_tile[1]][0] == :bomb
        break if @board[cur_tile[0]][cur_tile[1]][0] == :safe
      end

      @board[cur_tile[0]][cur_tile[1]][0] = :bomb
    end

    place_numbers

    @mines_placed = true
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

  def place_numbers
    @height.times do |y|
      @width.times do |x|
        next unless tile(x:,y:)[0] == :safe

        bombs = 0

        tile_relative_positions = [
          [-1, -1],
          [-1, 0],
          [-1, 1],
          [0, -1],
          [0, 1],
          [1, -1],
          [1, 0],
          [1, 1]
        ]

        tile_relative_positions.each do |r_pos|
          position = [
            x + r_pos[0],
            y + r_pos[1]
          ]

          cur_tile = tile(x: position[0], y: position[1])
          next unless cur_tile

          if cur_tile[0] == :bomb
            bombs += 1 
          end
        end

        if bombs != 0
          tile(x:,y:)[0] = bombs
        end
      end
    end
  end
end
