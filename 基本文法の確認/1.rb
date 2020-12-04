#変数

#ローカル変数
class Animal
  name="cat"
  def animalName
    puts name
  end
end

animal=Animal.new
#animal.animalName

#インスタンス変数
class Animal
  def initialize(name)
    @instance_name=name
  end
  def puts_name
    puts @instance_name
  end
end

animal1=Animal.new("dog")
animal2=Animal.new("mouse")
animal1.puts_name
animal2.puts_name

