require "rbtext"

require_relative "board"

BOARD_HEIGHT = 30
BOARD_WIDTH = 16
MINES = 99

board = Board.new(height: BOARD_HEIGHT, width: BOARD_WIDTH, mines: MINES)
board.display_board
