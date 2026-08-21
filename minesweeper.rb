require "rbtext"
require "rbtext/string_methods"

require_relative "board"
require_relative "status"
require_relative "gameplay"
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
statusbar = Statusbar.new(board)
gameplay = Gameplay.new(board)
interface = Interface.new(board:, gameplay:, statusbar: )

board.display_board
statusbar.display_bar

interface.select_tile(y: 0, x: 0)

loop do
  case R::S.getch
  when :"ctrl-c"
    exit

  when :pageup
    interface.select_tile(y: 0)
  when :pagedown
    interface.select_tile(y: board.height-1)
  when :home
    interface.select_tile(x: 0)
  when :end
    interface.select_tile(x: board.width-1)

  when :up
    interface.move_up
  when :down
    interface.move_down
  when :left
    interface.move_left
  when :right
    interface.move_right

  when ?W
    interface.half_up
  when ?S
    interface.half_down
  when ?A
    interface.half_left
  when ?D
    interface.half_right

  when ?w
    interface.move_up
  when ?s
    interface.move_down
  when ?a
    interface.move_left
  when ?d
    interface.move_right

  when ?q
    interface.flag_tile
  when ?/
    interface.flag_tile
  when ?r
    interface.reveal_tile
  when :enter
    interface.reveal_tile
  end
end
