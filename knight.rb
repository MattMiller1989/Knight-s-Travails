class Move_tree
    attr_reader :moves

    def initialize(x_start,y_start)
        @start_square=Square.new(x_start,y_start)
        @moves=build_tree(x_start,y_start)
        
        
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
            
            current_moves.each do |m|
                
                if m.has_possible_move(finish)
                    found=true
                    
                    final_square=m
                    break
                
                end
             end
            next_moves=[]
            
            current_moves.each do |n|
                
                more_moves=check_more_moves(n)
                
                more_moves.each do |a|
                    next_moves.push(a)
                end
            end

            

            current_moves=next_moves
         end

        path=get_path(final_square)
        puts "path: #{path.class}"
        if path.is_a? Square
            move_path.push(path)
            
        else
            move_path.unshift(@start_square)
            path.each do |p|
                move_path.push(p)
            end
        end
       
       
        move_path.push(finish)

        puts "You made it in #{move_path.length-1}! Heres your path:"
        puts move_path.class
        puts move_path.length
        puts move_path

       
    end
    def check_more_moves(current_square)
       

        return current_square.get_possible_moves 

    end

    def get_path(last_move,arr=[])
        
        if last_move.previous==nil
            return last_move
        end
       
        arr.push(get_path(last_move.previous,arr))
        
        arr.push(last_move)
        puts "arr.length: #{arr.length} arr: #{arr}"
        return arr

    end

end


lance=Knight.new
# lance.move_to(5,6)
#lance.move_to(3,7)
frank=Knight.new
frank.move_to(1,6)
frank.move_to(5,2)