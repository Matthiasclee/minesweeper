module RBText
  module Cursor
    def self.up(num=1)
      print "\033[#{num.to_i}A"
    end

    def self.down(num=1)
      print "\033[#{num.to_i}B"
    end

    def self.left(num=1)
      print "\033[#{num.to_i}D"
    end

    def self.right(num=1)
      print "\033[#{num.to_i}C"
    end

    def self.go_to_pos(x, y=nil)
      if x.class == Array && !y
        y = x[1]
        x = x[0]
      end

      print "\033[#{y};#{x}H"
      print "\033[#{y};#{x}f"
    end

    def self.pos
      res = ''
      $stdin.raw do |stdin|
        $stdout << "\e[6n"
        $stdout.flush
        while (c = stdin.getc) != 'R'
          res << c if c
        end
      end
      m = res.match /(?<row>\d+);(?<column>\d+)/
      return [Integer(m[:column]), Integer(m[:row])]
    end

    def self.beginning_of_line
      print "\r"
    end

    def self.show
      print "\033[?25h"
    end

    def self.hide
      print "\033[?25l"
    end
  end
end

RBText::Cr = RBText::Cursor
