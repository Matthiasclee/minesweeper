require "rbtext"
require "rbtext/string_methods"

require_relative "board"
require_relative "interface"

BOARD_HEIGHT = 30
BOARD_WIDTH = 16
MINES = 99

board = Board.new(height: BOARD_HEIGHT, width: BOARD_WIDTH, mines: MINES)
interface = Interface.new(board)

board.display_board

interface.select_tile(y: 0, x: 0)

loop{}
