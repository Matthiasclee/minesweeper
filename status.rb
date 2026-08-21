class Statusbar
  def initialize(board)
    @board = board
    @mines = @board.mines
  end
  
  def display_bar(return_to_pos: true, game_over: false)
    cursor_start_pos = R::Cr.pos

    R::Cr.go_to_pos(1,1)
    RBText::Screen.clear_line

    case game_over
    when :loss
      print(
        "YOU LOSE".color(:red).color(:light_green, type: :bg).bold
      ) 
    when :win
      print(
        "YOU WIN".color(:red).color(:light_green, type: :bg).bold
      ) 
    when false
      print(
        "#{@mines - @board.flagged_tiles}".color(:red).color(:light_green, type: :bg).bold
      ) 
    end

    R::Cr.go_to_pos(cursor_start_pos) if return_to_pos
  end
end
