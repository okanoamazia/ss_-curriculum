class Dog
  def self.jump
    puts "====================="
    p self
    p self.class
    puts "====================="
  end
end
Dog.jump