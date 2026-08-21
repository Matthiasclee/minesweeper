class Interface
  def initialize(board:, gameplay:)
    @height = board.height
    @width = board.width
    @board = board
    @gameplay = gameplay

    @x = nil
    @y = nil
  end

  def select_tile(y: nil, x: nil)
    return unless in_bounds?(y:,x:)

    @x = x if x
    @y = y if y

    cursor_x = 2 + (@x * 3)
    cursor_y = @y + 2

    R::Cr.go_to_pos(cursor_x, cursor_y)
  end

  def flag_tile
    tile = @board.tile(x: @x, y: @y)
    return if tile[1] == :revealed

    case tile[1]
    when :flagged
      tile[1] = :hidden
    when :hidden
      tile[1] = :flagged
    end

    @board.display_board
  end

  def reveal_tile
    tile = @board.tile(x: @x, y: @y)
    return unless tile[1] == :hidden

    unless @board.mines_placed
      @board.place_mines(x: @x, y: @y)
    end

    if tile[0] == :bomb
      @gameplay.loss
    else
      @gameplay.recursive_reveal(x: @x, y: @y)
    end

    @board.display_board
  end

  def move_left
    select_tile(x: @x-1)
  end

  def move_right
    select_tile(x: @x+1)
  end

  def move_up
    select_tile(y: @y-1)
  end

  def move_down
    select_tile(y: @y+1)
  end

  private
  
  def in_bounds?(y: nil, x: nil)
    ( (0..@width-1).include?(x) || !x) && 
    ( (0..@height-1).include?(y) || !y)
  end
end
