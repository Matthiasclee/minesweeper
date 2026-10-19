module RBText
  module Colors
    def self.fg_color_codes
      {
        black: "30",
        red: "31",
        green: "32",
        yellow: "33",
        blue: "34",
        magenta: "35",
        cyan: "36",
        light_gray: "37",
        gray: "90",
        light_red: "91",
        light_green: "92",
        light_yellow: "93",
        light_blue: "94",
        light_magenta: "95",
        light_cyan: "96",
        white: "97",
        reset: "39"
      }
    end

    def self.bg_color_codes
      bg_color_codes = {}

      for c in self.fg_color_codes.keys do
        bg_color_codes[c] = (self.fg_color_codes[c].to_i + 10).to_s
      end

      return bg_color_codes
    end

    def self.color(color, type: :fg, mode: :str)
      return "\033[39m\033[49m" if type == :all && color == :reset

      if type == :fg
        color_code = self.fg_color_codes[color.to_sym]
      elsif type == :bg
        color_code = self.bg_color_codes[color.to_sym]
      else
        return nil
      end

      return "\033[#{color_code}m" if mode == :str
      print "\033[#{color_code}m" if mode == :set
    end

    def self.num_color(num, type: :fg, mode: :str)
      return "\033[#{type == :fg ? "38" : "48"};5;#{num}m" if mode == :str
      print "\033[#{type == :fg ? "38" : "48"};5;#{num}m" if mode == :set
    end
  end
end

RBText::C = RBText::Colors
