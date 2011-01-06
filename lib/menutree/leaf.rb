module MenuTree
  class Leaf
    attr_accessor :commands

    def initialize(parent_tree)
      @parent_tree = parent_tree
      @commands = {}
      reset_dsl
    end

    def desc(desc)
      @current_description = desc
    end

    def arguments(*arguments)
      @current_arguments += arguments
    end

    def singleton_method_added(symbol)
      @commands[symbol] = @current_description
      reset_dsl
    end

    def leaf(&block)
      self.instance_exec(@parent_tree, &block) if block_given?
    end

    private
    def reset_dsl
      @current_description = ""
      @current_arguments = []
    end
  end
end
