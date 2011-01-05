module MenuTree
  class Leaf
    attr_accessor :commands

    def initialize(parent_tree)
      @parent_tree = parent_tree
      @commands = {}
      @curent_description = ""
    end

    def desc(desc)
      @current_description = desc
    end

    def singleton_method_added(symbol)
      @commands[symbol] = @current_description
    end

    def leaf(&block)
      self.instance_exec(@parent_tree, &block) if block_given?
    end
  end
end
