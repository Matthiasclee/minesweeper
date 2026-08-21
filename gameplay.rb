class Gameplay
  def initialize(board)
    @board = board
  end

  def recursive_reveal(x:, y:)
    tile = @board.tile(x:, y:)
    tile[1] = :revealed
  end

  private
  
  def neighboring_tiles(x:, y:)
    bombs = []
    safe = []

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

      tile = @board.tile(x: position[0], y: position[1])
      next unless tile

      tiles << tile
    end

    return {
      bombs: bombs,
      safe: safe
    }
  end
end
