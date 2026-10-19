module RBText
  class Ftext
    def initialize(str)
      @original_text = str
      @text = ""
      
      str = str.gsub("_.", "\0001").gsub("._", "\0002").gsub("_", "\0000").gsub("\0001", "_.").gsub("\0002", "._").split("_").map{|x|x.gsub("\0000", "_")}

      for x in str do
        if x[0] == "." && x[x.length-1] == "." && x.split(":").length == 2
          x = x.downcase.gsub(".", "").gsub("-","_")
          x = x.split(":")

          if x[0] == "cf" || x[0] == "c"
            @text << RBText::Colors.color(x[1].to_sym)
          elsif x[0] == "cb"
            @text << RBText::Colors.color(x[1].to_sym, type: :bg)
          elsif x[0] == "cfn" || x[0] == "cn"
            @text << RBText::Colors.num_color(x[1])
          elsif x[0] == "cbn"
            @text << RBText::Colors.num_color(x[1], type: :bg)
          elsif x[0] == "f"
            if x[1] == "reset"
              @text << RBText::Formatting.reset
            elsif x[1] == "bold"
              @text << RBText::Formatting.bold
            elsif x[1] == "faint"
              @text << RBText::Formatting.faint
            elsif x[1] == "italic"
              @text << RBText::Formatting.italic
            elsif x[1] == "underline"
              @text << RBText::Formatting.underline
            elsif x[1] == "strikethrough"
              @text << RBText::Formatting.strikethrough
            elsif x[1] == "blinking"
              @text << RBText::Formatting.blinking
            end
          elsif x[0] == "rf"
            if x[1] == "bold"
              @text << RBText::Formatting.reset(R::F.bold)
            elsif x[1] == "faint"
              @text << RBText::Formatting.reset(R::F.faint)
            elsif x[1] == "italic"
              @text << RBText::Formatting.reset(R::F.italic)
            elsif x[1] == "underline"
              @text << RBText::Formatting.reset(R::F.underline)
            elsif x[1] == "strikethrough"
              @text << RBText::Formatting.reset(R::F.strikethrough)
            elsif x[1] == "blinking"
              @text << RBText::Formatting.reset(R::F.blinking)
            end
          end
        else
          @text << x
        end 
      end

      @text << RBText::Formatting.reset
    end

    def to_s
      @text
    end

    def normal_text
      @original_text.gsub(/\_\.([a-z]){1,2}\:([a-z\-])+\.\_/, "")
    end

    def original_text
      @original_text
    end

    def +(str)
      self.to_s + str
    end

    def [](num)
      self.to_s[num]
    end

    def *(n)
      self.to_s*n
    end

    def include?(i)
      self.to_s.include?(i)
    end
  end

  class Ft < RBText::Ftext
  end
end

class String
  def to_ftext
    RBText::Ftext.new self.to_s
  end
end
