require "rbtext"
require "rbtext/string_methods"

require_relative "board"
require_relative "interface"

RBText::Screen.alternate_screen_mode
R::S.clear

at_exit do
  RBText::Screen.exit_alternate_screen_mode
end

BOARD_HEIGHT = 30
BOARD_WIDTH = 16
MINES = 99

board = Board.new(height: BOARD_HEIGHT, width: BOARD_WIDTH, mines: MINES)
interface = Interface.new(board)

board.display_board

interface.select_tile(y: 0, x: 0)

loop do
  case R::S.getch
  when :"ctrl-c"
    exit
  when :up
    interface.move_up
  when :down
    interface.move_down
  when :left
    interface.move_left
  when :right
    interface.move_right
  when "/"
    interface.flag_tile
  when :enter
    interface.reveal_tile
  end
end
