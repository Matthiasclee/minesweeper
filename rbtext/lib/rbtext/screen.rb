module RBText
  module Screen
    @@key_press_mappings = {:escape=>"\e", :f1=>"\eOP", :f2=>"\eOQ", :f3=>"\eOR", :f4=>"\eOS", :f5=>"\e[15~", :f6=>"\e[17~", :f7=>"\e[18~", :f8=>"\e[19~", :f9=>"\e[20~", :f10=>"\e[21~", :f11=>"\e[23~", :f12=>"\e[24~", :home=>"\e[1~", :end=>"\e[4~", :insert=>"\e[2~", :delete=>"\e[3~", "~"=>"~", "!"=>"!", "@"=>"@", "#"=>"#", "$"=>"$", "%"=>"%", "^"=>"^", "&"=>"&", "*"=>"*", "("=>"(", ")"=>")", "_"=>"_", "+"=>"+", :backspace=>"\u007F", "`"=>"`", "1"=>"1", "2"=>"2", "3"=>"3", "4"=>"4", "5"=>"5", "6"=>"6", "7"=>"7", "8"=>"8", "9"=>"9", "0"=>"0", "-"=>"-", "="=>"=", :tab=>"\t", "q"=>"q", "Q"=>"Q", :"ctrl-q"=>"\u0011", "w"=>"w", "W"=>"W", :"ctrl-w"=>"\u0017", "e"=>"e", "E"=>"E", :"ctrl-e"=>"\u0005", "r"=>"r", "R"=>"R", :"ctrl-r"=>"\u0012", "t"=>"t", "T"=>"T", :"ctrl-t"=>"\u0014", "y"=>"y", "Y"=>"Y", :"ctrl-y"=>"\u0019", "u"=>"u", "U"=>"U", :"ctrl-u"=>"\u0015", "i"=>"i", "I"=>"I", :"ctrl-i"=>"\t", "o"=>"o", "O"=>"O", :"ctrl-o"=>"\u000F", "p"=>"p", "P"=>"P", :"ctrl-p"=>"\u0010", "["=>"[", "]"=>"]", "\\"=>"\\", "{"=>"{", "}"=>"}", "|"=>"|", "a"=>"a", "A"=>"A", :"ctrl-a"=>"\u0001", "s"=>"s", "S"=>"S", :"ctrl-s"=>"\u0013", "d"=>"d", "D"=>"D", :"ctrl-d"=>"\u0004", "f"=>"f", "F"=>"F", :"ctrl-f"=>"\u0006", "g"=>"g", "G"=>"G", :"ctrl-g"=>"\a", "h"=>"h", "H"=>"H", :"ctrl-h"=>"\b", "j"=>"j", "J"=>"J", :"ctrl-j"=>"\n", "k"=>"k", "K"=>"K", :"ctrl-k"=>"\v", "l"=>"l", "L"=>"L", :"ctrl-l"=>"\f", ";"=>";", "'"=>"'", ":"=>":", "\""=>"\"", :enter=>"\r", "z"=>"z", "Z"=>"Z", :"ctrl-z"=>"\u001A", "x"=>"x", "X"=>"X", :"ctrl-x"=>"\u0018", "c"=>"c", "C"=>"C", :"ctrl-c"=>"\u0003", "v"=>"v", "V"=>"V", :"ctrl-v"=>"\u0016", "b"=>"b", "B"=>"B", :"ctrl-b"=>"\u0002", "n"=>"n", "N"=>"N", :"ctrl-n"=>"\u000E", "m"=>"m", "M"=>"M", :"ctrl-m"=>"\r", ","=>",", "."=>".", "/"=>"/", "<"=>"<", ">"=>">", "?"=>"?", :up=>"\e[A", :down=>"\e[B", :left=>"\e[D", :right=>"\e[C", :pageup=>"\e[5~", :pagedown=>"\e[6~"}

    def self.alternate_screen_mode
      print "\e[?1049h"
    end

    def self.exit_alternate_screen_mode
      print "\e[?1049l"
    end

    def self.clear
      print "\033[2J"
    end

    def self.clear_line
      print "\033[2K"
    end

    def self.size
      IO.console.winsize
    end

    def self.height
      self.size[0]
    end

    def self.width
      self.size[1]
    end

    def self.bell
      print "\a"
    end

    def self.getch
      out = STDIN.getch

      while STDIN.ready? do
        out << STDIN.getch
      end

      return @@key_press_mappings.key(out)
    end
  end
end

RBText::S = RBText::Screen
