module RBText
  module Formatting
    def self.reset(f_opt = nil, mode: :str)
      if f_opt
        r="\033[#{
          f_opt =~ /^\033\[(1|2)m$/ ? "\033[22m" : "\033[2#{f_opt.gsub(/[^0-9]/, "")}m"
        }"
      else
        r="\033[0m"
      end
      return r if mode == :str
      print r if mode == :set
    end

    def self.bold(mode: :str)
      r="\033[1m"
      return r if mode == :str
      print r if mode == :set
    end

    def self.faint(mode: :str)
      r="\033[2m"
      return r if mode == :str
      print r if mode == :set
    end

    def self.italic(mode: :str)
      r="\033[3m"
      return r if mode == :str
      print r if mode == :set
    end

    def self.underline(mode: :str)
      r="\033[4m"
      return r if mode == :str
      print r if mode == :set
    end

    def self.blinking(mode: :str)
      r="\033[5m"
      return r if mode == :str
      print r if mode == :set
    end

    def self.strikethrough(mode: :str)
      r="\033[9m"
      return r if mode == :str
      print r if mode == :set
    end
  end
end

RBText::F = RBText::Formatting
