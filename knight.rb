class Move_tree
    @moves=[]
    def initialize(x_start,y_start)
        @moves=build_tree(x_start,y_start)
    end
    def build_tree(x,y)
        valid_moves=[]
        possible_moves=[]
        possible_moves.push(Square.new(x+2,y+1))
        possible_moves.push(Square.new(x+1,y+2))
        possible_moves.push(Square.new(x-1,y+2))
        possible_moves.push(Square.new(x-2,y+1))
        possible_moves.push(Square.new(x-2,y-1))
        possible_moves.push(Square.new(x-1,y-2))
        possible_moves.push(Square.new(x+1,y-2))
        possible_moves.push(Square.new(x+2,y-1))

        possible_moves.each do |n|
            if n.in_bounds?
                valid_moves.push(n)
            end
        end

        return valid_moves
        
    end

    def to_s
        ret=""
        @moves.each do |n|
            ret +="[#{n}] "
        end
    end

end

class Square
    attr_reader :x, :y 

    def initialize(x,y)
        @x=x
        @y=y
    end

    def in_bounds?
        if x>=0 && y>=0 && x<8 && y<8
            return true
        else
            return false
        end
    end

    def to_s
        puts "x:#{@x},y:#{@y}"
    end
end

class Knight
    attr_reader :x, :y

    def initialize(x_start,y_start)
        @x,@y=x_start,y_start
        @moves=nil
        update_moves

    end
    def update_moves
        @moves=Move_tree.new(@x,@y)

    end
    def 

end

my_tree=Move_tree.new(0,0)
puts my_tree