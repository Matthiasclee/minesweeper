class Statusbar
  def initialize(board)
    @board = board
    @mines = @board.mines
  end
  
  def display_bar(return_to_pos: true)
    cursor_start_pos = R::Cr.pos

    R::Cr.go_to_pos(1,1)
    RBText::Screen.clear_line

    print(
      "#{@mines - @board.flagged_tiles}".color(:red).color(:light_green, type: :bg).bold
    ) 

    R::Cr.go_to_pos(cursor_start_pos) if return_to_pos
  end
end
