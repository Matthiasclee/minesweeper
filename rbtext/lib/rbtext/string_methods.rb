require_relative 'colors.rb'
require_relative 'formatting.rb'

class String
  def color(color, type: :fg)
    RBText::Colors.color(color, type: type) + self + RBText::Colors.color(:reset, type: type)
  end

  def num_color(color, type: :fg)
    RBText::Colors.num_color(color, type: type) + self + RBText::Colors.color(:reset, type: type)
  end

  def bold
    RBText::Formatting.bold + self + RBText::Formatting.reset
  end

  def faint
    RBText::Formatting.faint + self + RBText::Formatting.reset
  end

  def italic
    RBText::Formatting.italic + self + RBText::Formatting.reset
  end

  def underline
    RBText::Formatting.underline + self + RBText::Formatting.reset
  end

  def blinking
    RBText::Formatting.blinking + self + RBText::Formatting.reset
  end

  def strikethrough
    RBText::Formatting.strikethrough + self + RBText::Formatting.reset
  end
end
