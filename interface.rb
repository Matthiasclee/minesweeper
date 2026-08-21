class Interface
  def initialize(board:, gameplay:, statusbar: )
    @height = board.height
    @width = board.width
    @board = board
    @gameplay = gameplay
    @statusbar = statusbar

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
      @board.flagged_tiles -= 1
    when :hidden
      tile[1] = :flagged
      @board.flagged_tiles += 1
    end

    @board.display_board
    @statusbar.display_bar
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
    @statusbar.display_bar
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

  def half_up
    half = (@height-1)/2

    if @y > half
      select_tile(y: half)
    else
      select_tile(y: 0)
    end
  end

  def half_down
    half = (@height-1)/2

    if @y < half
      select_tile(y: half)
    else
      select_tile(y: @height-1)
    end
  end

  def half_left
    half = (@width-1)/2

    if @x > half
      select_tile(x: half)
    else
      select_tile(x: 0)
    end
  end

  def half_right
    half = (@width-1)/2

    if @x < half
      select_tile(x: half)
    else
      select_tile(x: @width-1)
    end
  end

  private
  
  def in_bounds?(y: nil, x: nil)
    ( (0..@width-1).include?(x) || !x) && 
    ( (0..@height-1).include?(y) || !y)
  end
end
