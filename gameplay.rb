class Gameplay
  attr_accessor :status

  def initialize(board)
    @board = board
    @status = :in_play
  end

  def recursive_reveal(x:, y:)
    tile = @board.tile(x:, y:)
    return unless tile[1] == :hidden

    tile[1] = :revealed
    @board.revealed_tiles += 1

    if tile[0] == :safe
      neighboring_tiles(x:,y:).each do |t|
        recursive_reveal(x: t[0], y: t[1])
      end
    end
  end

  def loss
    @status = :loss
    @board.show_all = true
  end

  private
  
  def neighboring_tiles(x:, y:)
    tiles = []

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

      tiles << [position[0], position[1]]
    end

    return tiles
  end
end
