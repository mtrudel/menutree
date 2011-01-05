leaf do |tree|
  desc "This is action one's help"
  def action_one(*args)
    puts "This is action one, called with: #{args.join ' '}"
  end

  desc "This is action two's help"
  def action_two(*args)
    puts "This is action two, called with: #{args.join ' '}"
  end
end
