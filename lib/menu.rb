module MenuTree
  class Menu
    def initialize(parent_tree)
      @parent_tree = parent_tree
    end

    def menutree(&block)
      self.instance_exec(@parent_tree, &block) if block_given?
    end
  end
end
