class Move_tree
    attr_reader :moves

    def initialize(x_start,y_start)
        @moves=build_tree(x_start,y_start)
        @start_square=Square.new(x_start,y_start)
    end
    def build_tree(x,y)
        valid_moves=[]
        possible_moves=[]
        possible_moves.push(Square.new(x+2,y+1,@start_square))
        possible_moves.push(Square.new(x+1,y+2,@start_square))
        possible_moves.push(Square.new(x-1,y+2,@start_square))
        possible_moves.push(Square.new(x-2,y+1,@start_square))
        possible_moves.push(Square.new(x-2,y-1,@start_square))
        possible_moves.push(Square.new(x-1,y-2,@start_square))
        possible_moves.push(Square.new(x+1,y-2,@start_square))
        possible_moves.push(Square.new(x+2,y-1,@start_square))

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

    def contains_square(x_target,y_target)

        moves.each do |m|
            if m.x==x_target && m.y==y_target
                return m
            end
        end
        return false
    end

end

class Square
    attr_reader :x, :y 
    attr_reader :possible_moves
    attr_reader :previous
    def initialize(x,y,previous=nil)
        @x=x
        @y=y
        # @possible_moves=Move_tree.new(x,y)
        @previous=previous
    end

    def in_bounds?
        if x>=0 && y>=0 && x<8 && y<8
            return true
        else
            return false
        end
    end

    def to_s
        return "x:#{@x},y:#{@y}"
    end
    def get_possible_moves
        return Move_tree.new(x,y).moves
    end

    def has_possible_move(finish_move)
        possible_moves=get_possible_moves

        possible_moves.each do |m|
            if m.x==finish_move.x && m.y==finish_move.y
                return m
            end
        end
        return false
    end

    def ==(other)
        if other ==nil
            return false
        end

        if self.x == other.x && self.y == other.y
            return true
        else
            return false
        end
    end


end

class Knight
    attr_reader :x, :y
    
    def initialize(x_start=4,y_start=4)
        @x,@y=x_start,y_start
        @moves=nil
         update_moves
        @start_square=Square.new(@x,@y)
    end
    def update_moves
        @moves=Move_tree.new(@x,@y)

    end

    def move_to(x_final,y_final,num_moves=0)
        found=false
        final_square=nil
        finish=Square.new(x_final,y_final)
        current_moves=[]
        move_path=[]
        
        
        current_moves[0]=@start_square
        
        while !found
            # puts current_moves
            current_moves.each do |m|
                if m.has_possible_move(finish)
                    found=true
                    puts "I FOUND IT #{m}"
                    final_square=m
                    break
                
                end
             end
            next_moves=[]
            
            current_moves.each do |n|
                puts n
                puts n.class
                more_moves=check_more_moves(n)
                # next_moves.push(check_more_moves(n))
                #puts "More Moves: #{more_moves[0]} Class: #{more_moves[0].class}"
                more_moves.each do |a|
                    next_moves.push(a)
                end
            end

            #puts "Next Moves: #{next_moves} Class: #{next_moves.class}"

            current_moves=next_moves
         end

        move_path.push(get_path(final_square))
       
        move_path.unshift(@start_square)
        move_path.push(finish)

        puts "You made it in #{move_path.length-1}! Heres your path:"
        puts move_path

       
    end
    def check_more_moves(current_square)
       
        # next_moves=[]
        
        # next_moves.push(Move_tree.new(current_moves.x,current_moves.y).moves)
        
        # return next_moves

        return current_square.get_possible_moves 

    end

    def get_path(last_move,arr=[])
        puts "arr: #{arr}"
        puts "178 last move #{last_move}"
        if last_move==nil
            return
        end
        if last_move.previous==@start_square
            return last_move
        end
        puts "185 last move #{last_move}"
        arr.push(last_move)
        arr.push(get_path(last_move.previous,arr)) unless get_path(last_move.previous)==nil
        puts "arr: #{arr}"
        return arr
    end

end


lance=Knight.new
# lance.move_to(5,6)
lance.move_to(3,7)
