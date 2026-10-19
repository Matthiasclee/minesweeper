require_relative "rbtext/cursor.rb"
require_relative "rbtext/colors.rb"
require_relative "rbtext/formatting.rb"
require_relative "rbtext/ftext.rb"
require_relative "rbtext/screen.rb"
require "io/console"
require "io/wait"

module RBText
  @ver_1 = 0
  @ver_2 = 3
  @ver_3 = 4
  @ver_4 = ""

  def self.version
    "#{@ver_1}.#{@ver_2}.#{@ver_3}#{".#{@ver_4}" if @ver_4.length > 1}"
  end
end

module R
  include RBText
end
