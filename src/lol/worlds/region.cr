module Lol::Worlds
  enum Region
    
    Two
    Three
    Four

    def self.get_pool(numb : Int)
      case numb
      when 1
        One
      when 2
        Two
      when 3
        Three
      when 4
        Four
      else
        raise ArgumentError.new
      end
    end
  end
end
