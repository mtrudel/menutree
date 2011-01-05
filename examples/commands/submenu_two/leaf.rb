leaf do |tree|
  desc "This is action one's help inside submenu two"
  def action_one(*args)
    puts "This is action one in submenu two, called with: #{args.join ' '}"
  end

  desc "This is action two's help inside submenu one"
  def action_two(*args)
    puts "This is action two in submenu two, called with: #{args.join ' '}"
  end
end
