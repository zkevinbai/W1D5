class PolyTreeNode
    attr_accessor :parent, :children, :value
    require 'byebug'

    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent=(parent_node)
        if @parent != nil # gains independence from previous parent 
            @parent.children.delete(self)
        end 

        if parent_node != nil # adds self to another internal node 
            unless parent_node.children.include?(self)
                @parent = parent_node
                parent_node.children << self
            end
        elsif parent_node == nil  # removes self from tree 
            @parent = parent_node
        end
    end

    def add_child(child_node)
        child_node.parent=(self) # opposite process of parent=
    end 

    def remove_child(child_node)
        return nil if @children.empty? # impossible to remove child if parent has no children 
        if @children.include?(child_node) 
            child_node.parent=(nil) # remove if child is in parent's children
        else 
            raise "not a child" # raise error if child is not child of parent
        end 
    end 

    def dfs(target_value)
        return self if @value == target_value
        
        @children.each do |child|
            c = child.dfs(target_value)  # WHY DO WE NEED TO MEMOIZE THIS FOR IT TO WORK?????
            return c if c != nil
        end

        nil
    end

    def bfs(target_value)
        queue = [self]
        until queue.empty? do
            front_customer = queue.shift
            return front_customer if front_customer.value == target_value
            queue.concat(front_customer.children)
        end
        nil
    end


end

# p = PolyTreeNode.new(1

# q.parent=(p) 
# q.parent

# a = PolyTreeNode.new(1)
# b = PolyTreeNode.new("2")
# c = PolyTreeNode.new(3)
# d = PolyTreeNode.new(4)
# e = PolyTreeNode.new("5")
# b.parent=(a)
# c.parent=(a)
# d.parent=(b)
# e.parent=(b)

# a.dfs("5") == e
